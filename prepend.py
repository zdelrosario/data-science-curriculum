#!/usr/bin/env python
import os
from shutil import copyfile

## Process the schedule document
names = []
days = []

with open("./scripts/schedule.csv", "r") as file_schedule:
    ## Dump the header
    file_schedule.readline()
    ## Process each line
    for i, line in enumerate(file_schedule):
        name, day = line.split(",")
        names.append(name)
        days.append(int(day))

## Copy the exercises
dir_base = os.path.dirname(__file__)

for i in range(len(names)):
    source = os.path.join(dir_base, "exercises", names[i] + "-assignment.Rmd")
    target = os.path.join(
        dir_base,
        "exercises_sequenced",
        "d{0:02d}-".format(days[i]) + \
        names[i] + \
        "-assignment.Rmd"
    )

    copyfile(source, target)
