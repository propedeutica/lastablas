# Catequesis
## Introduction
This application tries to make it possible to reserve places in aurch school or similar system. Parents can sign up and then add their offspring, and then ask for a particular shift where they want to be assigned.


##TODO
* Validations of models, ~~users should not be able to assign shifts that are full~~
* Create new rspec that covers 100% of the tool
* Make sure that only admins has access to the admin tab
* Create new admin users type, instead of using an admin attribute, as admins won't use the tool
* ~~Change age of children to course~~
* Configure devise to use email from an external provider
* Configure devise to send onboarding email to active accounts
* Configure devise to reset password
* Move erb to haml
* Allow the admin to create shifts and rooms graphically
* ~~Allow the users to assign offpsring to shifts~~
* Allow the user to delete assignments to shifts
* Validate that children have the same surname among them so all children are brothers (or similar)
* Make a message explaining that only legal tutors can add offspring
* ~~Make admin capable of knowing which offspring is assigned to each shift.~~
* Improve documentation
* Comment code
* Update Admin to use Ajax
* Update Admin dashboard to AngularJS
* Localize. Make sure that 100% of the interface is in Spanish, including devise messages and forms

## Description
Catequesis is a simple program to make it possible distributed assignment of shifts to students that can not do it by themselves, so their parents do it in their behalf.
There are different rooms that hold classes in parallel, and each of those rooms have a shift. A new student needs to be assigned to one of the shifts for the full course. Rooms have a capacity, but some of the shifts can have some places reserved (prebooked) for different reasons, and the parent is free to choose any shift that has some free space left.

### Users
Users are identified with parents. They can add and delete offspring and assing them so a shift. Only one parent is in the syste, there is no space for the two parents (although it could be added). They can sign up and add children into the system, and they can assign those children to shifts that has some space available. They can also delete those children from the system.
The amount of information requested is the minimum possible.

### Offsprings
Offsprings are related to parents and they are the subject that is assigned to a shift. An offspring is assigned to a single shift for the year.

### Room and shift
There are different rooms that can be assigned. Each one has different shifts that corresponds to a group of students and a teacher.

An offspring can only be assigned to a shift in a single room.



