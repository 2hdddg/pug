Todo
====

Todo is a simple light-weight distributed issue tracker that handles what's released on a server.

Why
----
We are lazy. We don't want to manually keep track of releases.

How?
----

Add a bug:
> ruby todo.rb add bug

..and enter the required information to report a bug
A new file with the information will be created, commit the file to git/hg/svn/whatever

When releasing your code (along with updated statuses on bugs):
Generate difference between the state of bugs in what you are about to release compared to what's already released(folder _releasefolder_):
> ruby todo.rb diff _releasefolder_ > _releasereport_

..and then copy the state of bugs to folder _releasefolder_

The file _releasereport_ will contain a report of the work you have done on bugs since the last release 