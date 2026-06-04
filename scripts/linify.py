import json

with open("effects.txt", encoding="utf8") as f:
    contents = f.read()
    paragraphs = contents.split("\n\n")
    lines = [ "".join(paragraph.split("\n")).strip() for paragraph in paragraphs]
    with open("templates/Gleneagles/sections/disease-risks-assessment/bacteria-effects-cognition.json", 'w', encoding="utf8") as results:
        json.dump(lines, results, ensure_ascii=False, indent=2)