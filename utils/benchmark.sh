#!/bin/bash

CPUPROFILE=/tmp/rod.1 RUBYOPT="-r`gem which perftools | tail -1`" $1
