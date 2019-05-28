# Cleaning of files.

```perl
#!/usr/bin/perl
# author V.Varbanovski @nu11secur1ty

use strict;
use warnings;
use diagnostics;
# Define all folders in array elements
# folder0 folder1 folder2 ...etc 

our @tupotii = ('folder0/*', 'folder1/*', 'folder2/*');

foreach (@tupotii) {
        our $check_tupotii_clean = `rm -rf $_`;
}
	print "Cleaning is finished\n";
exit 0;
```
