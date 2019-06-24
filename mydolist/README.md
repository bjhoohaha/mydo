# README

This README would normally document whatever steps are necessary to get the application up and running.

* Developer Informaiton
Name: Ong Bing Jue

The following application was developed using MacOS Mojave version 10.14.2 , Terminal Version 2.9.1 (421.1) and Atom 1.33.1 (Text Editor)

Webpage application was tested using Safari Version 12.0.2 (14606.3.4)

Things you may want to cover:

* Ruby version
ruby 2.6.0

* System dependencies

* Configuration
Routes:
CRUD path for each task\
show path for all completed task\
show path for all active task\
show path for all tasks that are near due date\
patch part to update position for jquery ui sortable\
update path for their relative positions\
update path for bookmark colour\
update path for update time left to due date\
update path to complete tasks that are in the different status\
delete path for deleting multiple\


* Database creation
Each record is made up of a Task class\
Task has the following attributes :title, :description, :position, :due_date\

* Database initialization
1.Local copy of database has been uploaded\
2.Creating new tasks one by one\

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
1.Open Application\
2.Create New Task\
3.Change Status of Task when completed\
  Each task has a status of inprogress, awaiting reply, pending or completed\
4.Buttons can be pressed to update status along the way\
5.Edit Task information if required along the way\
6.Position active tasks in the active task tab (jquery ui sortable)\
7.Press "Complete" when Task finishes and view completed tasks\


* Heroku App:
https://vast-taiga-58297.herokuapp.com/tasks
