
# Simple example, creating a gzipped tarball out of a directory, excluding a subdirectory and listing the contents:

```bash
$ ls fruit/
apple  banana  peach  tomato
$ tar -czf onlyfruit.tar.gz --exclude=tomato fruit/
$ tar tf onlyfruit.tar.gz 
fruit/
fruit/peach/
fruit/apple/
fruit/banana/
```
- multiple

```bash
$ ls fruit/
apple  banana  peach  tomato
$ tar -czf onlyfruit.tar.gz --exclude=tomato --exclude=peach fruit/
$ tar tf onlyfruit.tar.gz 
fruit/
fruit/peach/
fruit/apple/
fruit/banana/
```
