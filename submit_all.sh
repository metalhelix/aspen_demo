#!/bin/bash
parallel ./qsub_example.sh ::: *.gz
