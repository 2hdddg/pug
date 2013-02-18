Pug
====

Pug is a simple light-weight distributed issue tracker that handles what's released on a server.

Why
----
We are lazy. We don't want to manually keep track of releases.

How?
----

Add a bug:
> ruby pug.rb add bug

..and enter the required information to report a bug
A new file with the information will be created, commit the file to git/hg/svn/whatever

Add a comment on an existing bug:
> ruby pug.rb comment ./pugs/a_new_bug.yml
