#!/usr/bin/env python3
"""Generate the Claude Artifact body from index.html.

The site and the artifact are the same app. The artifact runtime supplies
its own document shell, so this strips ours and drops the service worker
(there is no sw.js at the artifact origin). Everything else is identical.
"""
import re, sys, pathlib

root = pathlib.Path(__file__).resolve().parent.parent
src  = (root / "index.html").read_text()

head = src[src.index("<title>"):src.index("</head>")]
head = "\n".join(l for l in head.splitlines()
                 if not re.match(r'\s*<(meta|link rel="(manifest|icon|apple-touch-icon)")', l))
body = src[src.index('<div class="wrap">'):src.index("</body>")]
body = body.replace('''if("serviceWorker" in navigator) addEventListener("load", function(){
  navigator.serviceWorker.register("sw.js").catch(function(){});
});
''', "")

out = root / "artifact.html"
out.write_text(head.strip() + "\n\n" + body.strip() + "\n")
print(f"{out} ({out.stat().st_size} bytes)")
