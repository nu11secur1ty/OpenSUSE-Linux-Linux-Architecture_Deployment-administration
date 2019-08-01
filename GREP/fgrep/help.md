Pattern selection and interpretation:
```bash
  -E, --extended-regexp     PATTERN is an extended regular expression
  -F, --fixed-strings       PATTERN is a set of newline-separated strings
  -G, --basic-regexp        PATTERN is a basic regular expression (default)
  -P, --perl-regexp         PATTERN is a Perl regular expression
  -e, --regexp=PATTERN      use PATTERN for matching
  -f, --file=FILE           obtain PATTERN from FILE
  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline
```
Miscellaneous:
```bash
  -s, --no-messages         suppress error messages
  -v, --invert-match        select non-matching lines
  -V, --version             display version information and exit
      --help                display this help text and exit
```
Output control:
```bash
  -m, --max-count=NUM       stop after NUM selected lines
  -b, --byte-offset         print the byte offset with output lines
  -n, --line-number         print line number with output lines
      --line-buffered       flush output on every line
  -H, --with-filename       print file name with output lines
  -h, --no-filename         suppress the file name prefix on output
      --label=LABEL         use LABEL as the standard input file name prefix
  -o, --only-matching       show only the part of a line matching PATTERN
  -q, --quiet, --silent     suppress all normal output
      --binary-files=TYPE   assume that binary files are TYPE;
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                equivalent to --binary-files=text
  -I                        equivalent to --binary-files=without-match
  -d, --directories=ACTION  how to handle directories;
                            ACTION is 'read', 'recurse', or 'skip'
  -D, --devices=ACTION      how to handle devices, FIFOs and sockets;
                            ACTION is 'read' or 'skip'
  -r, --recursive           like --directories=recurse
  -R, --dereference-recursive  likewise, but follow all symlinks
      --include=FILE_PATTERN  search only files that match FILE_PATTERN
      --exclude=FILE_PATTERN  skip files and directories matching FILE_PATTERN
      --exclude-from=FILE   skip files matching any file pattern from FILE
      --exclude-dir=PATTERN  directories that match PATTERN will be skipped.
  -L, --files-without-match  print only names of FILEs with no selected lines
  -l, --files-with-matches  print only names of FILEs with selected lines
  -c, --count               print only a count of selected lines per FILE
  -T, --initial-tab         make tabs line up (if needed)
  -Z, --null                print 0 byte after FILE name
```
Context control:
```bash
  -B, --before-context=NUM  print NUM lines of leading context
  -A, --after-context=NUM   print NUM lines of trailing context
  -C, --context=NUM         print NUM lines of output context
  -NUM                      same as --context=NUM
      --color[=WHEN],
      --colour[=WHEN]       use markers to highlight the matching strings;
                            WHEN is 'always', 'never', or 'auto'
  -U, --binary              do not strip CR characters at EOL (MSDOS/Windows)
```
When FILE is '-', read standard input.  With no FILE, read '.' if
recursive, '-' otherwise.  With fewer than two FILEs, assume -h.
Exit status is 0 if any line is selected, 1 otherwise;
if any error occurs and -q is not given, the exit status is 2.

Report bugs to: bug-grep@gnu.org
GNU grep home page: <http://www.gnu.org/software/grep/>
General help using GNU software: <http://www.gnu.org/gethelp/>

# Examples;
```bash
fgrep -f words.txt file1
```
- find elements in file
```bash
fgrep -C 0 '(f|g)ile' check_file
fgrep -C 0 '\(f\|g\)ile' check_file
```
- Output
```bash
(f|g)ile
```
# To search several files for a simple string of characters: 
```bash
fgrep strcpy *.c
```

This searches for the string strcpy in all files in the current directory with names that end in the .c character string.
- To count the number of lines that match a pattern:
```bash
fgrep -c “{” pgm.c
fgrep -c “}” pgm.c
```
It displays the number of lines in pgm.c that contain left and right braces.

If you do not put more than one { (left brace) or one } (right brace) on a line in your C programs, and if the braces are properly balanced, the two numbers displayed are usually the same if the proper conditions are met. If the numbers are not the same, you can display the lines that contain braces in the order that they occur in the file with: 

```bash
egrep {\|} pgm.c 
```

- To display the names of files that contain a pattern:
```bash
fgrep -l strcpy *.c
```
It searches the files in the current directory that end with .c and displays the names of those files that contain the strcpy string.

- Take a string line and parse it to the output file perl
```bash
fgrep "DO NOT" perl5/perlbrew/bin/cpanm > perl
```
- Check for result
```bash
cat perl
```
- output 
```bash
# DO NOT EDIT -- this is an auto generated file
```
