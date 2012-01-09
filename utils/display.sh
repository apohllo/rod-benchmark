#!/bin/bash

pprof.rb --gif  /tmp/rod.1 --focus=Rod > /tmp/rod.1.png
gqview /tmp/rod.1.png
