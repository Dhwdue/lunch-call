/* Offline shell. Network-first for the page so updates land on the next
   online open; cache-first for icons. Fonts are cross-origin and skipped —
   offline they fall back to the system stack declared in the CSS. */
var CACHE = "lunch-call-v1";
var ASSETS = ["./", "./index.html", "./manifest.webmanifest",
              "./icon-192.png", "./icon-512.png", "./apple-touch-icon.png"];

self.addEventListener("install", function(e){
  e.waitUntil(caches.open(CACHE).then(function(c){ return c.addAll(ASSETS); })
    .then(function(){ return self.skipWaiting(); }));
});

self.addEventListener("activate", function(e){
  e.waitUntil(caches.keys().then(function(keys){
    return Promise.all(keys.filter(function(k){ return k !== CACHE; })
      .map(function(k){ return caches.delete(k); }));
  }).then(function(){ return self.clients.claim(); }));
});

self.addEventListener("fetch", function(e){
  if(e.request.method !== "GET") return;
  if(new URL(e.request.url).origin !== location.origin) return;
  if(e.request.mode === "navigate"){
    e.respondWith(fetch(e.request).then(function(r){
      var copy = r.clone();
      caches.open(CACHE).then(function(c){ c.put("./index.html", copy); });
      return r;
    }).catch(function(){ return caches.match("./index.html"); }));
    return;
  }
  e.respondWith(caches.match(e.request).then(function(hit){ return hit || fetch(e.request); }));
});
