#!/usr/bin/env python3

"""
Load python3 prior to run:
> module load python/3
> ./0.multiqc.py
"""

## Required software
import multiqc

## Performing MultiQC locally
multiqc.run("pwd")		## Change according to the pwd containing the FastQC.zip files

exit 0
