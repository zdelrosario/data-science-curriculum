---
title: 'An Open-Source Active Learning Curriculum for Data Science in Engineering'
tags:
  - Active learning
  - Data science
  - R
  - Tidyverse
  - Engineering
authors:
  - name: Zachary del Rosario
    orcid: 0000-0003-4676-1692
    affiliation: 1
affiliations:
 - name: Assistant Professor of Engineering and Applied Statistics, Olin College of Engineering
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

As of writing (Fall 2021), Data Science is an exciting new area of study: Many
students seek to learn how to obtain, wrangle, and make sense of data, and
instructors are working to both define and teach this field. An explosion of
resources is available to both teachers and learners---to name just a
few---published books [@grolemund2018r], course materials
[adhikari2021data8,timbers2021introduction], and YouTube channels such as
StatQuest [@statquest]. Much of this content is excellent and informative, and
the broader proliferation of open educational resources contributes positively
to a more equitable learning environment.

However, one of the most profound findings from the science of learning is the
importance of *active learning* for student outcomes; *active learning* is a
pedagogical style that has students actively engaged in the process of learning,
rather than simply reading a book, skimming a blog post, or watching a lecture.
Notably, active learning has been shown to be superior to a purely passive form
of instruction [@freeman2014active]. Passive resources are an essential
component of self-study and are useful for reference, but curricular materials
for active learning-based instruction are necessary for an instructor seeking to
maximize student learning. This project seeks to provide active learning
materials for an intructor seeking to teach data science *to engineers*.

The content in this project has been used to teach a Data Science course at Olin
College of Engineering; a small engineering college outside Boston that
emphasizes project-based and active learning pedagogies. Since this course
caters to engineering students, it has a stronger emphasis on engineering
problems than is typically found in data science materials. This includes
analyzing datasets on material properties, basic reliability analysis, and using
fitted models to make engineering predictions. This curriculum also makes use of
concepts from statistics education to arm students with the conceptual tools to
recognize and handle different forms of variability that typically arise in
engineering problems [@wild1999statistical,@aggarwal2021qualitative].

This work provides a two-tiered set of content for active learning of data
science. This content is appropriate for both instructors seeking to teach data
science using a flipped classroom model [@bishop2013flipped], and for individual
learners seeking a self-study course in data science. Additionally, since the
materials herein are released under a permissive open-source license, other
instructors are welcome (and encouraged) to rearrange and modify the content
provided.

## Story: How This Was Made

As a PhD student I took a course called *The Data Challenge Lab* (DCL) [@dcl].
This was one of the most inspiring courses I've ever taken, both for the direct
learning I gained and for the pedagogical innovations the course employed. The
original DCL course focused on *exploratory data analysis*
(EDA) [@tukey1977eda]: a subfield of statistics that emphasizes hypothesis
*generation* over hypothesis *testing*. Having taken several traditional
statistics courses prior to the DCL, I found the skillset to be a beautiful
complement to the largely mathematical treatment of statistical ideas I had
encountered.

Pedagogically, the DCL was based on many sound principles from the learning
sciences. There were essentially no lectures; the course leaned heavily into
active learning [@freeman2014active]. Content was presented in a sequence of
small, hands-on exercises and applied in more difficult challenges. Exercises
were sequenced to rotate through topics, leveraging the benefits of interleaving
[@lang2016small]. Students were assigned to small groups (4--5) to form
"learning teams," which promoted motivation to learn through making the learning
social [@lang2016small]. The basic design of the present materials is based
heavily on this DCL design.

Now as a faculty member at Olin College, my teaching and research aims are to
help engineers reason about uncertainty: I designed a Data Science course to
give undergraduate engineers a solid foundation in EDA and statistical thinking.
Since Olin students (and most engineers) only take a single course in
statistics, I used the DCL design as a starting point and exchanged some of the
data-manipulation content for statistical ideas. The result is a Data Science
course that focuses less on a traditional introduction to probability theory,
but instead gives students lots of practice studying real datasets, builds an
"informal" understanding of probability to ground statistical inference
[@moore1997new], and contextualizes inferential ideas in real scenarios.

## Pedagogical Design

The full set of desired learning outcomes is documented [in the project
repository](https://github.com/zdelrosario/data-science-curriculum/blob/master/curriculum.md),
but at a high level the learning goals of this content are for students to
develop:

1. The ability to set up and maintain a scientifically reproducible data science workflow,
2. The skills and self-efficacy to load, tidy, and access data,
3. The skills to visualize data, for both exploration and communication,
4. The tools and mindset to think statistically,
5. The skills and understanding to fit and interpret data-driven models, and
6. The skills to communicate results clearly and productively.

The content is organized into two levels: *exercises* and *challenges*.

**Exercises** are designed to be small (1/2 to an hour long) hands-on
introductions to particular topics; for instance, exercise `e-data01-isolate`
introduces the concept of isolating rows and columns of a dataset. While many
exercises point to an external reading, exercises mainly provide students with
hands-on practice on new concepts; for instance `e-data01-isolate` has students
work with a dataset of flights to select columns matching the pattern `"_time"`
and rows matching the destination `"LAX"`. The exercise solutions are available
in a [web-based solution
manual](https://zdelrosario.github.io/data-science-curriculum/index.html), and
are intended to be provided to students *from the beginning of the course*. Many
of these exercises contain unit tests, which allow students to check the
correctness of their work immediately---this provides immediate formative
feedback.

**Challenges** are designed to be substantial (~3 hours or longer) hands-on
elaborations of concepts learned in the exercises. Each challenge has students
explore and answer questions about a dataset, with subsequent challenges
increasing in complexity. For instance `c01-titanic` has students study the
built-in Titanic dataset, while `c06-covid19` has students pull and join data
from the New York Times and the US Census Bureau. While the challenge
[assignment
files](https://github.com/zdelrosario/data-science-curriculum/tree/build/challenges)
are openly available in the repository, the challenge solutions are witheld to
discourage cheating---instructors may contact the author to obtain the challenge
solution files. Providing the challenges without solutions is intended as an
opportunity for summative feedback.

## Guidance on Use of Materials

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
