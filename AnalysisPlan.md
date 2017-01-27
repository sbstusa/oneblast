> [*Overview and Expectations:*](#overview-and-expectations)
>
> [*Design:*](#design)
>
> [*Randomization*](#randomization)
>
> [*Randomization Assessment*](#randomization-assessment)
>
> [*Analysis Plan:*](#analysis-plan)
>
> [*Attrition:*](#attrition)
>
> [*Missing Treatments:*](#missing-treatments)

Overview and Expectations:
==========================

DOD and the SBST collaborated to compare the effectiveness of different modes of email communication in encouraging members of the military to subscribe to a newsletter.

Representatives of the two agencies designed six different strategies of email communication. The SBST randomly assigned the strategies to a list of about 500,000 email addresses provided by the DOD. The DOD distributed the emails to the list. Before the study no one version was expected to be particularly powerful. 

Design: 
========

<span id="h.ynl9i32vduyh" class="anchor"></span>

<span id="h.gjdgxs" class="anchor"></span>The experimental design varied:

-   Choice (single opt-in or enhanced active choice);

-   Block of 10 (present or absent);

-   If present, format of 10 (list or quiz).

Crossing gives the resultant six (6) emails:

|                 |                     | **A** | **B** | **C** | **D** | **E** | **F** |
|-----------------|---------------------|-------|-------|-------|-------|-------|-------|
| **Choice**      | **Opt-in**          | X     |       | X     |       | X     |       |
|                 | **Enhanced-Active** |       | X     |       | X     |       | X     |
| **Block of 10** | **Present**         | X     | X     | X     | X     |       |       |
|                 | **Absent**          |       |       |       |       | X     | X     |
| **Format**      | **List**            | X     | X     |       |       |       |       |
|                 | **Quiz**            |       |       | X     | X     |       |       |

Randomization
-------------

This is a block randomized trial with 82 blocks defined by the day on which the email was sent (in variable BATCH). The six treatments were randomly assigned (complete random assignment) to 491879 unique email addresses ( 81980 assigned to each of A through E, and 81979 to F). So, for example:

Randomization Assessment
------------------------

No background information was available about the subjects so the only assessment was to see that the same number were assigned to each group.

Analysis Plan:
==============

The aim is to compare the relative effectiveness of six treatments in terms of encouraging subscription to a newsletter. The outcome is whether a recipient of an email subscribes to the newsletter.

We will report the average proportion subscribing in each of the 6 treatment conditions. (This is an estimate of the proportion who would subscribe in each of those conditions if treatment were reassigned.)

The first question is whether the treatments differ from each other at all. We will test this hypothesis using the generalized Cochran-Mantel-Haenszel Test because of the blocking by day. If we cannot reject this hypothesis, we will not test other hypotheses.

Then, we will test the following three hypotheses also using the generalized Cochran-Mantel-Haenszel Test. We will also report relevant estimated proportions subscribing in each group.

-   A,C,E versus B,D,F (a test of opt-in versus enhanced active).

-   A,B,C,D versus E,F (a test of Block of 10 present versus active)

-   A,B versus C,D (a test of list versus quiz format)

-   We will also test whether we can distinguish the version with the highest proportion subscribing from the test (i.e. a test of the winner versus the rest).

We do not have expected directions of effects, so we use two-tailed p-values throughout.

The outcome is very sparse and so, although we have a large sample, we worry about the large sample theory behind the standard calculations of this test. We will then use approximative randomization inference directly to assess our conclusions that arise from the standard approach.

Attrition:
----------

We don't have anyone who dropped out of the study mainly because the outcome was simply whether or not a person clicked on the link in the email, followed it to the website, and subscribed to the newsletter. Those who did not subscribe are counted as not subscribing rather than missing.

Missing Treatments:
-------------------

The outcome measure depends on matching the email address and name from one file to that of another file. A lack of match could mean that the person did not subscribe OR it could mean that the person subscribed but used a different email address. After matching first on email address and then on name among people without a matching email address, we are left with 142 people with no matching email address and duplicate or triplicate names. For example, we could have two "Jake Bowers" in the outcome dataset, neither of which has a unique match to the baseline data. We know that, say, 6 people named "Jake Bowers" were sent treatment, and we were able to match 3 of them on the basis of email address, but have two extra Jake Bowers's who did subscribe to the newsletter, but we don't know which of the 3 original Jake Bowers's they were. We do know that those 3 Jake Bowers's were assigned to treatments 1,2 and 3. Assuming that no one subscribed twice, we will take the following steps:

-   First, exclude anyone who we couldn't uniquely associate with a treatment condition. Do the analysis described above for those people.

-   Second, redo the analysis for all/nearly all/a large sample of the ways that the treatments could have been assigned to the 142 people for whom treatment status is not uniquely known.


