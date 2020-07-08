#!/usr/bin/env python3
import os
from pandas import read_csv
from shutil import copyfile


df_schedule = read_csv("./scripts/schedule.csv")
dir_base = os.path.dirname(__file__)

for i in range(df_schedule.shape[0]):
    source = os.path.join(dir_base, "exercises", df_schedule.name[i] + "-assignment.Rmd")
    target = os.path.join(
        dir_base,
        "exercises_sequenced",
        "d{0:02d}-".format(df_schedule.day[i]) + \
        df_schedule.name[i] + \
        "-assignment.Rmd"
    )

    copyfile(source, target)
