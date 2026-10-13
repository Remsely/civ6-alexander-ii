"""Workshop / GitHub preview image: workshop/preview.png (512x512) from art/source.

python tools/make_preview.py
"""
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent.parent
SIZE = 512
GOLD = (212, 160, 23)
DARK = (28, 28, 28)
FONT = Path("C:/Windows/Fonts/timesbd.ttf")


def main() -> None:
    bg = Image.open(ROOT / "art" / "source" / "cabinet.png").convert("RGBA")
    side = bg.height
    bg = bg.crop(((bg.width - side) // 2, 0, (bg.width + side) // 2, side)).resize((SIZE, SIZE), Image.LANCZOS)
    canvas = Image.new("RGBA", (SIZE, SIZE), DARK)
    canvas.alpha_composite(Image.blend(canvas, bg, 0.55))
    leader = Image.open(ROOT / "art" / "source" / "alexander_ii_short.png").convert("RGBA")
    leader = leader.crop(leader.getbbox())
    scale = (SIZE * 0.78) / leader.height
    leader = leader.resize((round(leader.width * scale), round(leader.height * scale)), Image.LANCZOS)
    canvas.alpha_composite(leader, ((SIZE - leader.width) // 2, SIZE - leader.height))
    fade = Image.new("L", (SIZE, SIZE), 0)
    d = ImageDraw.Draw(fade)
    for y in range(150):
        d.line((0, y, SIZE, y), fill=round(230 * (1 - y / 150)))
    canvas.alpha_composite(Image.merge("RGBA", (Image.new("L", (SIZE, SIZE), 0),) * 3 + (fade,)))
    draw = ImageDraw.Draw(canvas)
    big, small = ImageFont.truetype(str(FONT), 54), ImageFont.truetype(str(FONT), 24)
    for text, font, y, fill in (("Alexander II", big, 18, GOLD), ("Remsely's alternate leader of Russia", small, 84, (235, 225, 200))):
        w = draw.textlength(text, font=font)
        draw.text(((SIZE - w) / 2, y), text, font=font, fill=fill)
    draw.rectangle((6, 6, SIZE - 7, SIZE - 7), outline=GOLD, width=3)
    out = ROOT / "workshop" / "preview.png"
    canvas.convert("RGB").save(out, optimize=True)
    print(out, out.stat().st_size // 1024, "KB")


if __name__ == "__main__":
    main()
