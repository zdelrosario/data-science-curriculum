#!/usr/bin/env python
import os
from shutil import copyfile

## Process the schedule document
names = []
days = []

# with open("./scripts/schedule.csv", "r") as file_schedule:
with open("./scripts/exercise-calendar.csv", "r") as file_schedule:
    ## Dump the header
    file_schedule.readline()
    ## Process each line
    for i, line in enumerate(file_schedule):
        name, pr, cl, md, ds, dc, fn, ex, date, url = line.split(",")

        ## Split M/D/Y
        month, day, year = date.split("/")
        datecode = "{:02d}".format(int(month)) + \
            "-{:02d}".format(int(day)) + "-"

        ## Record
        names.append(name)
        days.append(datecode)

## DEBUG
print(datecode)

## Copy the exercises
dir_base = os.path.dirname(__file__)

for i in range(len(names)):
    source = os.path.join(dir_base, "exercises", names[i] + "-assignment.Rmd")
    target = os.path.join(
        dir_base,
        "exercises_sequenced",
        days[i] + \
        names[i] + \
        "-assignment.Rmd"
    )

    copyfile(source, target)
