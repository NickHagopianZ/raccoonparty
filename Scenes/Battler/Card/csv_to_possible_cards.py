import csv
import io
import re
import sys


def clean_bbcode(text):
    # Remove specific artifacts if needed, or handle newline normalization
    return text.replace("\n", "\\n").strip()


def translate_csv_to_godot(data):
    reader = csv.DictReader(io.StringIO(data.strip()))

    print("extends Node")
    print()
    print("class_name AllPossibleCards")
    print()
    print()

    for row in reader:
        var_name = row["name"]
        title = row["title"]
        desc_base = clean_bbcode(row["description"])

        # Track stats to build the footer and the Action array
        stats = []
        if row.get("vibes"):
            stats.append(f"{row['vibes']} Vibes")
        if row.get("fear"):
            stats.append(f"{row['fear']} Fear")
        if row.get("sus"):
            stats.append(f"{row['sus']} Sus")

        # Format stats with + sign if they are pure integers
        formatted_stats = []
        for s in stats:
            # Add '+' if it's a positive digit and doesn't have a sign or 'D'
            if s[0].isdigit():
                formatted_stats.append(f"+{s}")
            else:
                formatted_stats.append(s)

        # Build the strings
        stat_string = "\\n".join(formatted_stats)
        full_description = f"{desc_base}\\n\\n{stat_string}"

        actions = ", ".join(
            [f'BattleScores.new("{s}")' for s in formatted_stats]
        )

        # Print the Godot block
        godot_block = (
            f"static var {var_name} = CardResource.new(\n"
            f'\t"{title}",\n'
            f'\t"{full_description}",\n'
            f"\t[{actions}],\n"
            f'\t"{desc_base}",\n'
            f")"
        )
        print(godot_block)


if __name__ == "__main__":
    with open(sys.argv[1]) as f:
        csv_data = f.read()
    translate_csv_to_godot(csv_data)
