#!/usr/bin/bash
# Author nu11secur1ty
cd /usr/src/
  wget https://rakudostar.com/files/star/rakudo-star-2019.03.tar.gz
  tar xfz rakudo-star-2019.03.tar.gz
cd rakudo-star-2019.03
  perl Configure.pl --gen-moar --make-install --prefix ~/rakudo
  ln -s /usr/src/rakudo-star-2019.03/perl6 /usr/local/bin/perl6
exit 0;
