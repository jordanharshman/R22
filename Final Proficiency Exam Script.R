# Your name here: 

# Libraries ---------------------------------------------------------------


# Metadata ----------------------------------------------------------------

# The data found in "Predictions.xlsx" are data from a freshman intro chemistry course that I taught in 2018.
# I implemented a strategy that attempts to improve self-regulated learning of students by encouraging them
# to be more realistic and aware (metacognitive) about what they did and did not fully understand. I did this
# by asking them to PREdict and POSTdict their exam scores.

# A PREdiction is when the students were asked "What grade (out of 100%) do you think you will make on the upcoming
# exam?" and I asked this one class period prior to taking the exam. A POSTdiction is when the students were asked
# "What grade (out of 100%) do you think you will earn now that you have completed the exam?" and was the final question
# on every exam. This ensures that a student took the exam fully and only after seeing and completing every problem (but
# prior to receiving any grades) did they POSTdict their scores. Therefore, a PREdiction measures a students' evaluation of:
#   1. ...how well they understand the content
#   2. ...how well they can predict what they will be assessed on during the exam
#   3. ...how well they will perform on those exam items
#   4. ...general confidence / self-efficacy
# A POSTdiction measures a students' evaluation of:
#   1. ...how well they understand the content
#   2. ...how well they can recognize problems that they don't know enough to answer correctly without yet getting
#         feedback about the correctness of their response
#   3. ...general confidence / self-efficacy

# The theory that drives this little experiment is that those students who can accurately PREdict and POSTdict their
# exam scores likely have a very good idea about what they know, what they will be assessed on, and have the metacognitive
# strategies in place to know when they don't know something well enough (they are highly self-regulated learners). These
# are likely high-performing students because when they do homework, if they get a problem incorrect, they use that as 
# feedback to correct their understanding BEFORE an exam, and therefore perform well. Alternatively students who OVERESTIMATE
# their exam scores through PREdictions and POSTdictions are likely unregulated in their learning. It is more likely that
# when these students get a problem wrong on homework, no/little meta-level thoughts occur that signal to the student that
# they need further studying and practice, and therefore they may perform lower on exams. Research suggests it's likely that
# they will explain why they got a problem incorrect by latching onto "simple" or "stupid" mistakes (i.e. "I was just moving
# too fast") and walk away thinking they understand something to a satisfactory degree, but in reality they don't, and their
# exam scores suffer because of it.

# The ultimate goal is to improve students' self-regulatory abilities and begin to recognize well before the exam if a 
# student doesn't have sufficient knowledge/understanding so that they can correct it prior to exams. If you as a student
# PREdict you will earn a 95%, POSTdict you will earn a 90%, but actually score a 70%, that is as hard of proof as you can 
# get that you are not receiving signals that you don't understand this stuff as well as you think you do!

# The data have the following variables:
# ID - generic ID number to replace names
# Gender - m or f designation only available (no students identified otherwise) [not used in this exam]
# Prediction1, Prediction2, Prediction3 - PREdicted scores on Exams 1, 2, and 3, percent
# Postdiction1, Postdiction2, Postdiction3 - POSTdicted scores on Exams 1, 2, and 3, percent
# Grade1, Grade2, Grade3 - Actual grade recieved on Exams 1, 2, and 3, percent
# FinalScore - Overall grade (percent points possible) in the class, percent [not used in this exam]

# Your Exam Questions:

# #1 ----------------------------------------------------------------------

# Import the data and write over the existing data for all grades so they are a percent 
# (out of 100) instead of a proportion out of 1. You can find the data here:
# https://raw.githubusercontent.com/jordanharshman/R22/main/data/Predictions.csv

# code

# #2 ----------------------------------------------------------------------
# Across all 3 exams, how many missing PREdictions (not POSTdictions, just PREdictions) 
# were there? Just looking for a single number; don't need to know how many per exam. 

# code

# My Answer (1 number): 

# #3 ----------------------------------------------------------------------
# For each exam, what is the correct order for the average PREdiction, POSTdiction,
# and grade on the exam? In other words, For each of exam 1, 2, and 3, which of these
# orders is correct for the average score:

# Pre > Post > Grade
# Pre > Grade > Post
# Post > Pre > Grade
# Post > Grade > Pre
# Grade > Pre > Post
# Grade > Post > Pre

# code

# My Answers (3 orders):
# Exam 1 order: 
# Exam 2 order: 
# Exam 3 order: 

# #4 ----------------------------------------------------------------------
# On one single plot, show the relationship between PREdiction or POSTdiction (x) and Grade (y)
# broken down by Exam (one faceted plot for each exam, another for each PREdiction/POSTdiction).
# The desired pdf output is here:
# https://github.com/jordanharshman/R22/blob/main/Predictions.pdf
# Make your plot AS SIMILAR AS POSSIBLE to the one I've uploaded including:
# - vector based output height = 4.5, width = 6 inches
# - Official Auburn colors, #03244d (dark blue) and #dd550c (burnt orange)
# - Include the solid (perfect pre/postdiction) and dotted lines (+/- 10% of perfect PREdiction/POSTdiction);
#   y'all forget about the lines on the last assignment so I'm reminding you here :)

# Hints: There is a lot to do here both behind the scenes and in the plot itself. Here are some hints:

# Hint 1: Normally, when you make a facet plot(), you need to pivot_longer() first. While that is kind of true
# here (you will likely want to pivot eventually), it won't be so straightforward. If you pivot, you'll get all
# Pred1, Pred2... Post1, Post2... Grade1, Grade2... stacked on top of each other, but what you really need is a
# tibble that has 5 columns: A value that is the Prediction or Postdiction (x), Grade (y), a variable that identifies 
# if someone is within 10% of their prediction/postdiction (color), Exam (facet), and a column that identifies if we
# are looking at a Prediction or a Postdiction here; pivot_longer() won't directly return this, so you will need to 
# get creative.

# Hint 2: To make the variable that tracks whether or not an observation falls within 10% of the prediction/postdiction,
# consider turning the following logic into a mutate():
# "If a students' grade on a particular exam is between (Grade - 10) and (Grade + 10), then I'll call that student 'in';
# if not, I'll call that student 'out'" [check out ?between()]

# Hint 3: Some details to make the plot consistent with mine:
# - I used a geom_jitter(width = 1, height = 1)
# - I used theme_classic() to get rid of grids and panels

# code


