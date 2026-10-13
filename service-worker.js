// v3.1 migration: retire the legacy offline service worker and cached pages.
self.addEventListener('install',event=>event.waitUntil(self.skipWaiting()));
self.addEventListener('activate',event=>event.waitUntil((async()=>{
  const keys=await caches.keys();
  await Promise.all(keys.filter(k=>k.startsWith('pb-workspace-offline-')).map(k=>caches.delete(k)));
  await self.registration.unregister();
  const clientsList=await self.clients.matchAll({type:'window',includeUncontrolled:true});
  for(const client of clientsList){if(client.url.startsWith(self.location.origin))client.navigate(client.url);}
})()));
