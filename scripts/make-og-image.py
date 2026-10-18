#!/usr/bin/env python3
"""One-shot generator for docs/og.png (1200x630). Re-run only to change branding."""
from PIL import Image, ImageDraw, ImageFont
import os

W, H = 1200, 630
BG = (15, 23, 42)        # slate-900
ACCENT = (45, 212, 191)  # teal-400
FG = (226, 232, 240)     # slate-200
MUTED = (148, 163, 184)  # slate-400

img = Image.new("RGB", (W, H), BG)
d = ImageDraw.Draw(img)

def font(path, size, fallbacks=("/System/Library/Fonts/Supplemental/Arial Bold.ttf",
                                 "/System/Library/Fonts/Helvetica.ttc")):
    for p in (path,) + fallbacks:
        if os.path.exists(p):
            try:
                return ImageFont.truetype(p, size)
            except Exception:
                continue
    return ImageFont.load_default()

title_f = font("/System/Library/Fonts/SFNS.ttf", 84)
sub_f = font("/System/Library/Fonts/SFNS.ttf", 36, fallbacks=("/System/Library/Fonts/Supplemental/Arial.ttf",))
dom_f = font("/System/Library/Fonts/Menlo.ttc", 34, fallbacks=("/System/Library/Fonts/SFNS.ttf",))

# accent frame + terminal prompt
d.rectangle([0, 0, W, 10], fill=ACCENT)
d.rectangle([0, H - 10, W, H], fill=ACCENT)
d.text((80, 120), "❯_", font=dom_f, fill=ACCENT)

d.text((80, 220), "Awesome", font=title_f, fill=FG)
d.text((80, 320), "Agentic DevOps", font=title_f, fill=ACCENT)
d.text((84, 448), "AI agents · MCP servers · SRE agents · agentic CI/CD", font=sub_f, fill=MUTED)
d.text((84, 520), "agentic-devops.online", font=dom_f, fill=FG)

os.makedirs("docs", exist_ok=True)
img.save("docs/og.png", optimize=True)
print("docs/og.png written", img.size)
