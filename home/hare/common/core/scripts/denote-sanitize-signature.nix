{pkgs, ...}: {
  home.packages = with pkgs; [
    (writers.writePython3Bin "denoteSanitizeSignature" {} ''
      import re
      import sys


      def denote_slug_put_equals(string):
          """Replace spaces and underscores with equals signs in STRING.
          Also replace multiple equals signs with a single one and remove
          any leading and trailing signs.
          """
          string = re.sub(r"_|\s+", "=", string)
          string = re.sub(r"={2,}", "=", string)
          string = re.sub(r"^=|=$", "", string)
          return string


      def denote_sluggify_signature(string):
          """Make STRING an appropriate slug for signature."""
          string = re.sub(
              r"""[][{}!@#$%^&*()+'"?,.|;:~`‘’“”/-]*""",
              "",
              string,
          )
          return denote_slug_put_equals(string).lower()


      def main():
          if len(sys.argv) != 2:
              print(f"Usage: {sys.argv[0]} 'signature'", file=sys.stderr)
              sys.exit(1)

          print(denote_sluggify_signature(sys.argv[1]))


      if __name__ == "__main__":
          main()
    '')
  ];
}
