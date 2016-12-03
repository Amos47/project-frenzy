Feature: Student choose project
  A student logs in a and selects a project

Scenario: Student selects a project
Given a student logs in
When the student requests an unattributed project
Then the student is attributed on the project

Scenario: Student can't select a project that has already been taken
Given a student logs in
When the student requests a project that's already been attributed
Then the student is not attributed on the project
