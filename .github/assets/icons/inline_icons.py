#!/usr/bin/env python3
"""
Fetch remote SVGs and inline them into wrapper SVG files so GitHub will render them.
"""
import re
import sys
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError

ROOT = ".github/assets/icons"
ICONS = [
    "plex", "tautulli", "posterizarr", "tdarr", "radarr", "sonarr",
    "bazarr", "prowlarr", "flaresolverr", "recyclarr", "gluetun",
    "sabnzbd", "qbittorrent", "homepage", "vaultwarden", "nextcloud",
    "mealie", "sillytavern", "mediawiki", "audiobookshelf", "deunhealth",
    "watchtower",
]

def fetch(url):
    req = Request(url, headers={"User-Agent": "inline-icons-script/1.0"})
    try:
        with urlopen(req, timeout=15) as r:
            return r.read().decode("utf-8")
    except (HTTPError, URLError) as e:
        print(f"ERROR fetching {url}: {e}")
        return None

def extract_svg_parts(svg_text):
    m = re.search(r"<svg([^>]*)>", svg_text, flags=re.IGNORECASE)
    if not m:
        return None, None
    open_tag_attrs = m.group(1)
    vb_m = re.search(r'viewBox=["\']([^"\']+)["\']', open_tag_attrs)
    viewbox = vb_m.group(1) if vb_m else None
    inner = re.sub(r"^.*?<svg[^>]*>", "", svg_text, flags=re.IGNORECASE | re.DOTALL)
    inner = re.sub(r"</svg>\s*$", "", inner, flags=re.IGNORECASE | re.DOTALL)
    return viewbox, inner

def make_wrapper(name, inner_svg, viewbox, source_url):
    svg_id = f"sh_{name}_bg"
    vb_attr = f' viewBox="{viewbox}"' if viewbox else ''
    nested_viewbox = viewbox if viewbox else "0 0 128 128"
    source_comment = f"<!-- source: {source_url} -->"
    content = f'''<svg width="104.25" height="48" viewBox="0 0 556 256" fill="none" xmlns="http://www.w3.org/2000/svg" version="1.1">
<g transform="translate(0, 0)">
<svg x="0" y="0" width="556" height="256" viewBox="0 0 128 128" preserveAspectRatio="xMinYMin meet">
<style>
#{svg_id} {{fill: #15191C}}
@media (prefers-color-scheme: light) {{
    #{svg_id} {{fill: #F4F2ED}}
}}
</style>
<rect id="{svg_id}" width="128" height="128" rx="20"/>
<svg x="12" y="12" width="104" height="104" viewBox="{nested_viewbox}" preserveAspectRatio="xMidYMid meet">
{source_comment}
{inner_svg}
</svg>
</svg>
</g>
</svg>
'''
    return content

def main():
    bases = [
        "https://cdn.jsdelivr.net/gh/selfhst/icons@main/svg/",
        "https://raw.githubusercontent.com/selfhst/icons/main/svg/",
        "https://upload.wikimedia.org/wikipedia/commons/a/a6/",
        "./.github/assets/icons/",
    ]
    for name in ICONS:
        svg_text = None
        for base in bases:
            url = base + name + ".svg"
            print(f"Fetching {url}...")
            svg_text = fetch(url)
            if svg_text:
                break
        if not svg_text:
            print(f"Skipping {name}")
            continue
        viewbox, inner = extract_svg_parts(svg_text)
        if inner is None:
            print(f"Failed to parse SVG for {name}, skipping")
            continue
        out = make_wrapper(name, inner, viewbox, url)
        out_path = f"{ROOT}/sh-{name}.svg"
        try:
            with open(out_path, "w", encoding="utf-8") as f:
                f.write(out)
            print(f"Wrote {out_path}")
        except Exception as e:
            print(f"Failed to write {out_path}: {e}")

if __name__ == '__main__':
    main()
