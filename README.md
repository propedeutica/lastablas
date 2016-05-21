# Catequesis
## Introduction
This application tries to make it possible to reserve places in a school or similar system, for parents


##TODO
* Validations of models, ~~users should not be able to assign shifts that are full~~
* Create new rspec that covers 100% of the tool
* Make sure that only admins has access to the admin tab
* Move erb to haml
* Allow the admin to create shifts and rooms
* ~~Allow the users to assign offpsring to shifts~~
* Allow the user to delete assignments to shifts
* Update Admin to use Ajax
* Update Admin dashboard to AngularJS
* Configure devise to use email from an external provider
* Configure devise to send onboarding email to active accounts
* Configure devise to reset password
* Make admin capable of knowing which offspring is assigned to each shift.
* Improve documentation
* Comment code
* Localize? Perhaps it is not needed

## Description
Catequesis is a simple program to make it possible distributed assignment of shifts to students that can not do it by themselves, so their parents do it in their behalf

### Users
Users are identified with parents. They can add and delete offspring and assing them so a shift. Only one parent is in the system.

### Offsprings
Offsprings are related to parents and they are the subject that is assigned to a shift. An offspring is assigned to a single shift for the year.

### Room and shift
There are different rooms that can be assigned. Each one has different shifts that corresponds to a group of students and a teacher.

An offspring can only be assigned to a shift in a single room.



