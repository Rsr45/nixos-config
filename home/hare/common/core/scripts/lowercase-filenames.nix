{pkgs, ...}: {
  home.packages = with pkgs; [
    (writers.writePython3Bin "lowercase-filenames" {} ''
      import os
      import sys


      def lowercase_file(filename, verbose=False):
          directory, name = os.path.split(filename)
          stem, ext = os.path.splitext(name)

          lower_name = stem.lower() + ext

          if name == lower_name:
              return

          new_path = os.path.join(directory, lower_name)

          os.rename(filename, new_path)

          if verbose:
              print(f"{filename}\t{new_path}")


      def undo(logfile):
          with open(logfile, "r", encoding="utf-8") as f:
              entries = [
                  line.rstrip("\n").split("\t", 1)
                  for line in f
                  if line.strip()
              ]

          for old_path, new_path in reversed(entries):
              if not os.path.exists(new_path):
                  print(
                      f"Skipping, file not found: {new_path}",
                      file=sys.stderr,
                  )
                  continue

              if os.path.exists(old_path):
                  print(
                      f"Skipping, destination exists: {old_path}",
                      file=sys.stderr,
                  )
                  continue

              os.rename(new_path, old_path)
              print(f"{new_path} -> {old_path}")


      args = sys.argv[1:]


      if not args:
          answer = input(
              "Lowercase all files in the current directory? [y/N] "
          ).strip().lower()

          if answer != "y":
              print("Aborted.")
              sys.exit(0)

          for filename in os.listdir("."):
              if os.path.isfile(filename):
                  lowercase_file(filename)


      elif args[0] == "--verbose":
          if len(args) != 1:
              print(
                  f"Usage: {sys.argv[0]} [--verbose] [file]",
                  file=sys.stderr,
              )
              sys.exit(1)

          print(
              "Lowercase all files in the current directory? [y/N] ",
              end="",
              file=sys.stderr,
          )
          answer = input().strip().lower()

          if answer != "y":
              print("Aborted.", file=sys.stderr)
              sys.exit(0)

          for filename in os.listdir("."):
              if os.path.isfile(filename):
                  lowercase_file(filename, verbose=True)


      elif args[0] == "--undo":
          if len(args) != 2:
              print(
                  f"Usage: {sys.argv[0]} --undo LOGFILE",
                  file=sys.stderr,
              )
              sys.exit(1)

          undo(args[1])


      elif len(args) == 1:
          lowercase_file(args[0])


      else:
          print(
              f"Usage: {sys.argv[0]} [--verbose] [file]",
              file=sys.stderr,
          )
          print(
              f"       {sys.argv[0]} --undo LOGFILE",
              file=sys.stderr,
          )
          sys.exit(1)
    '')
  ];
}
