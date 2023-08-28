# tag
Short bash script for file tagging system

**How it Works:**
The script generates tag directories within `$HOME/.local/share/sha256tags/`. Tagged files are linked to their SHA256 hash within these directories.

**Shortcomings:**
It causes problems if a tagged file is modified (changing its hash) or if the file is moved. I might add functions to deal with these scenarios.

**Usage:**
- Add a tag: `./tag <tag_name> <file(s)>`
- Remove a tag: `./tag <tag_name> -r <file(s)>`
- List tagged files: `./tag <tag_name> -l`

**Examples:**
1. Play all files tagged "music" in `mpv`:
   ```
   mpv --playlist <(tag.sh music -l)
   ```

2. View all files tagged "image" in `feh`:
   ```
   feh $(tag.sh image -l)
   ```

**License:**
This project is licensed under GPLv3. Refer to the `LICENSE` file for details.
