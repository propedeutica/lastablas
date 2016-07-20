#TODO
* Adding the capability for the administrator to stop changes in users. No new users will be added, no offspring, shifts won't be able to be changed or reassigned, except for the administrator. Users can delete their accounts in any case.
* Switch system on: being able to close the system (so no new users can be added), until the admin changes a switch, so we can deploy before the date an hour when the system is open
* Configure devise to use email from an external provider
* Configure devise to send onboarding email to active accounts
* Configure devise to reset password
* Validations of models, ~~users should not be able to assign shifts that are full~~
* Create new rspec that covers 100% of the tool
* Make sure that only admins has access to the admin tab
* Create new admin users type, instead of using an admin attribute, as admins won't use the tool
* Allow administrator to update rooms and shifts. (i.e. change the number of prebooked with a slider)
* Allow the user to delete assignments to shifts #done only changing it to other
* Allow the admin to create shifts and rooms graphically
* ~Validate that children have the same surname among them so all children are brothers (or similar)~
* Add error message explaining the reason when somebody tries to add a child with different surname
* Make a message explaining that only legal tutors can add offspring in help
* Move erb to haml
* Improve documentation
* Comment code
* Update Admin to use Ajax
* Update Admin dashboard to AngularJS
* Localize. Make sure that 100% of the interface is in Spanish, including devise messages and forms
* ~~Change age of children to course~~
* ~~Allow the users to assign offpsring to shifts~~
* ~~Make admin capable of knowing which offspring is assigned to each shift.~~
