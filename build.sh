#! /bin/bash

mkdocs build -v
npx mathjax-render-for-mkdocs-material --srcDir=./site --useWorker
