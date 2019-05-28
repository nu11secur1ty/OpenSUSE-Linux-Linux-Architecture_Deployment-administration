# Cleaning of files.

```perl
#!/usr/bin/perl
# author V.Varbanovski @nu11secur1ty

use strict;
use warnings;
use diagnostics;
# Define all files in array elements
# file0 file1 file2 ...etc 

our @bots = ('file0/*', 'file1/*', 'file2/*');

foreach (@bots) {
        our $check_proxy = `rm -rf $_`;
}
	print "Cleaning is finished\n";
exit 0;
```
