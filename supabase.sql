-- PB Workspace v3.2: academic metadata only (NOT document blobs).
-- Run once in Supabase > SQL Editor for your personal project.
create table if not exists public.pb_records (
  user_id uuid not null references auth.users(id) on delete cascade,
  entity_type text not null check (entity_type in ('profile','course','task','exam')),
  entity_id text not null check (char_length(entity_id) between 1 and 160),
  payload jsonb not null default '{}'::jsonb,
  deleted boolean not null default false,
  revision bigint not null default 1 check (revision > 0),
  updated_at timestamptz not null default now(),
  primary key(user_id, entity_type, entity_id)
);

alter table public.pb_records enable row level security;
revoke all on table public.pb_records from anon, authenticated;
grant select, insert, update on table public.pb_records to authenticated;

drop policy if exists "pb_read_own" on public.pb_records;
create policy "pb_read_own" on public.pb_records for select to authenticated
  using (user_id = (select auth.uid()));
drop policy if exists "pb_insert_own" on public.pb_records;
create policy "pb_insert_own" on public.pb_records for insert to authenticated
  with check (user_id = (select auth.uid()));
drop policy if exists "pb_update_own" on public.pb_records;
create policy "pb_update_own" on public.pb_records for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- Atomic revision check prevents stale devices silently overwriting newer data.
create or replace function public.pb_apply_change(
  p_kind text,
  p_id text,
  p_payload jsonb,
  p_deleted boolean,
  p_expected bigint
) returns bigint
language plpgsql
security invoker
set search_path = ''
as $$
declare
  v_user uuid := (select auth.uid());
  v_revision bigint;
begin
  if v_user is null then raise exception 'Sign-in required'; end if;
  if p_kind not in ('profile','course','task','exam')
    or p_id is null or length(p_id) not between 1 and 160
    or p_expected is null or p_expected < 0
    or p_payload is null or jsonb_typeof(p_payload) <> 'object'
    or pg_column_size(p_payload) > 50000
  then raise exception 'Invalid record'; end if;

  if p_expected = 0 then
    insert into public.pb_records(user_id,entity_type,entity_id,payload,deleted,revision,updated_at)
      values (v_user,p_kind,p_id,p_payload,p_deleted,1,now())
      on conflict (user_id,entity_type,entity_id) do nothing
      returning revision into v_revision;
  else
    update public.pb_records
      set payload=p_payload,deleted=p_deleted,revision=revision+1,updated_at=now()
      where user_id=v_user and entity_type=p_kind and entity_id=p_id and revision=p_expected
      returning revision into v_revision;
  end if;
  if v_revision is null then raise exception 'PB_CONFLICT'; end if;
  return v_revision;
end;
$$;
revoke all on function public.pb_apply_change(text,text,jsonb,boolean,bigint) from public,anon;
grant execute on function public.pb_apply_change(text,text,jsonb,boolean,bigint) to authenticated;

-- Broadcast only the authenticated user's rows to subscribed clients.
do $$begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname='supabase_realtime' and schemaname='public' and tablename='pb_records'
  ) then
    alter publication supabase_realtime add table public.pb_records;
  end if;
end$$;
