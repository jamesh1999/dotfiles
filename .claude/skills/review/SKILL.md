---
name: review
description: Reviews changes for quality (both style and behavioural)
---

# Instructions

## Identify the scope
Your instructions should indicate the target of your review. If not, assume you are to compare the current, working state of the Git repository with the committed `main` branch.

## Understand the work
Read the raw diff for each changed file. You may need to read elsewhere to contextualise the change. As you read, consider the following:
* How does the file affect the metrics for your evaluation?
* What actionable improvements could be made? (Both short term - before the work is merged, and longer term)

## Rate the work
Here are several metrics to use. Each should be given as a score 1-10.

### For code:
* Clarity - How readable and self-explanatory is the code?
* Correctness – Does the code achieve its intended purpose without bugs or logical issues?
* Robustness – How well does it handle edge cases, errors, and future changes?
* (For repos with test suites) Testing - Is new behaviour covered? Are there any quick unit tests to improve this?

### For prose / documentation (including inline commentary):
* Precision - Does the language avoid ambiguity and are its terms defined / idiomatic?
* Structure - Is there a clear hierarchy with a natural progression that a reader could follow without jumping?
* Simplicity - At the sentence structure needlessly complex? Would more common words suffice? A reader should not need to re-read a sentence.
* Conciseness - Does everything earn its place? Wordy documentation will never be read.

## Summarise
Provide a report with the following format:

```md
#Review: <what is being reviewed>

## Ratings

| Metric | Score (1-10) |
|--------|:------------:|
|Clarity | <score> |
| ... | ... | 

## Actionable Improvements
1. **<severity>** - <description + suggested rewrite>

## What wasn't covered
<anything your method didn't check>

## Summary
<quick summary in your own words>
```

Improvements should be prioritised - most critical first. For small fixes / refactors, give the edit examples inline. For larger issues, describe the approach concisely.
Mention what your method didn't check / couldn't have found because this prevents a reader from getting a false sense of confidence from your review.
