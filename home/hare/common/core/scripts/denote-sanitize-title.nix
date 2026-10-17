{pkgs, ...}: {
  home.packages = with pkgs; [
    (writers.writePython3Bin "denoteSanitizeTitle" {} ''
      import re
      import sys


      def denote_slug_hyphenate(string):
          """Replace spaces and underscores with hyphens in STRING.
          Also replace multiple hyphens with a single one and remove
          any leading and trailing hyphen.
          """
          string = re.sub(r"_|\s+", "-", string)
          string = re.sub(r"-{2,}", "-", string)
          string = re.sub(r"^-|-$", "", string)
          return string


      def denote_sluggify_title(string):
          """Make STRING an appropriate slug for title."""
          string = re.sub(
              r"""[][{}!@#$%^&*()+'"?,.|;:~`‘’“”/=]*""",
              "",
              string,
          )
          return denote_slug_hyphenate(string).lower()


      def main():
          if len(sys.argv) != 2:
              print(f"Usage: {sys.argv[0]} 'title'", file=sys.stderr)
              sys.exit(1)

          print(denote_sluggify_title(sys.argv[1]))


      if __name__ == "__main__":
          main()
    '')
  ];
}
