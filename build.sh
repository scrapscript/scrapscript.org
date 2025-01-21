#!/bin/bash

mkdir -p dist
for f_ in src/* ; do
  f=`basename $f_`
  if [[ $f == *.html ]] ; then
    printf "`cat template.html`" "`cat src/$f`" > dist/$f
  elif [[ $f == *.md ]] ; then
    printf "`cat template.html`" "`pandoc --no-highlight -f markdown -t html src/$f`" > "dist/`basename $f .md`.html"
  else
    cp src/$f dist/$f
  fi
done
