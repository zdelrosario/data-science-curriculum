---
title: 'An Open-Source Active Learning Curriculum for Data Science'
tags:
  - Active learning
  - Data science
  - R
  - Tidyverse
authors:
  - name: Zachary del Rosario
    orcid: 0000-0003-4676-1692
    affiliation: 1
affiliations:
 - name: Visiting Professor, Olin College of Engineering
   index: 1
date:
bibliography: paper.bib
---

# Summary

[This work](https://github.com/zdelrosario/data-science-curriculum) provides
open-source content for an active learning curriculum in data science. The scope
of the content is sufficient for a full-semester introduction to scientifically
reproducible statistical computation, data wrangling, visualization, basic
statistical literacy, and data-driven modeling. The content is broken into short
**exercises** that introduce new concepts, and longer **challenges** that
encourage students to develop those skills in an open-ended context.

## Statement of Need

As of writing (Fall 2020), Data Science is an exciting new area of study: Many
students seek to learn how to obtain, wrangle, and make sense of data, and
instructors are working to both define and teach this field. An explosion of
resources is available to both teachers and learners---to name just a
few---published books [@grolemund2018r], blog posts on Medium [@medium], and
YouTube channels such as StatQuest [@statquest]. Much of this content is
excellent and informative.

However, one of the most profound findings from the science of learning is the
importance of *active learning* for student outcomes; *active learning* is a
pedagogical style that has students actively engaged in the process of learning,
rather than simply reading a book, skimming a blog post, or watching a video.
Notably, if teachers held pedagogical design to the same standards as medical
interventions, a purely passive approach to learning would have been abandoned
for ethical considerations [@freeman2014active].

This work provides a two-tiered set of content for active learning of data
science. This content is appropriate for both instructors seeking to teach data
science using a flipped classroom model [@bishop2013flipped], and for individual
learners seeking a self-study course in data science.

## Pedagogical Design

The full set of desired learning outcomes is documented in the project
repository, but at a high level the learning goals of this content are for
students to develop:

1. The ability to set up and maintain a scientifically reproducible data science workflow,
2. The skills and self-efficacy to access, clean, and tidy data,
3. The skills to visualize data, for both exploration and communication,
4. The mindset to think statistically, and
5. The skills and understanding to fit and interpret data-driven models.

The content is organized into two levels: *exercises* and *challenges*.

**Exercises** are designed to be small (1/2 to an hour long) hands-on
introductions to particular topics; for instance, exercise `e-data01-isolate`
introduces the concept of isolating rows and columns of a dataset. While many
point to an external reading, exercises mainly provide hands-on practice for
students on new concepts; for instance `e-data01-isolate` has students work with
a dataset of flights to select columns matching the pattern `"_time"` and rows
matching the destination `"LAX"`. The exercise source files are available in the
project repository, and are intended to be provided to students *with
solutions*. Many of these exercises contain unit tests, which allow students to
check the correctness of their work immediately.

**Challenges** are designed to be substantial (~3 hours or longer) hands-on
elaborations of concepts learned in the exercises. Each challenge has students
explore and answer questions about a dataset, with subsequent challenges
increasing in complexity. For instance `c01-titanic` has students study the
built-in Titanic dataset, while `c06-covid19` has students pull and join data
from the New York Times and the US Census Bureau. While the challenge
*assignment* files are openly available in the repository, the challenge
solutions are witheld to discourage cheating---instructors may contact the
author to obtain the challenge solution files.

I have used the curriculum exercises in place of lectures in a flipped-classroom
model [@bishop2013flipped]. Students complete exercises outside class, so their
first introduction to course content includes a hands-on component. Introducing
content outside the classroom frees in-class time to focus on active learning
activities; I choose to use in-class time to discuss student findings on the
challenges.

## Inspiration and Dependencies

Both the content and structure of this curriculum are inspired by the
(discontinued) Data Challenge Lab course at Stanford University [@dcl]. The
exercises make heavy use of the `Tidyverse` [@wickham2019tidyverse]
"metapackage", as well as other R packages
[@broom;@fitdistrplus;@curl;@gapminder;@ggrepel;@googlesheets4;@nycflights;@mvtnorm;@viridis;@modelr].

# References
