{pkgs, ...}: {
  home.packages = with pkgs; [
    (writers.writePython3Bin "denoteSanitizeKeywords" {} ''
      import re
      import sys


      KEYWORD_REMOVE_RE = re.compile(
          r"""[][{}!@#$%^&*()+'"?,.|;:~`‘’“”/_ =-]*"""
      )


      def sluggify_keyword(keyword):
          """Clean and slugify one keyword."""
          keyword = KEYWORD_REMOVE_RE.sub("", keyword)
          return keyword.lower()


      def sluggify_keywords(string):
          """Clean comma-separated keywords and join them with underscores."""
          keywords = [
              sluggify_keyword(keyword)
              for keyword in string.split(",")
          ]

          return "_".join(keyword for keyword in keywords if keyword)


      def main():
          if len(sys.argv) != 2:
              print(f"Usage: {sys.argv[0]} 'keyword1,keyword2,...'", file=sys.stderr)
              sys.exit(1)

          print(sluggify_keywords(sys.argv[1]))


      if __name__ == "__main__":
          main()
    '')
  ];
}
