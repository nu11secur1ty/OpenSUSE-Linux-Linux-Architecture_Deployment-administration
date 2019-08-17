#!/usr/bin/bash
wget https://rakudostar.com/files/star/rakudo-star-2019.03.tar.gz
  tar xfz rakudo-star-2019.03.tar.gz
cd rakudo-star-2019.03
  perl Configure.pl --gen-moar --make-install --prefix ~/rakudo
  cd /usr/src/rakudo-star-2019.03/
  ln -s perl6 /usr/bin/perl6
exit 0;
