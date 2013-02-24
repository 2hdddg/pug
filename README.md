Pug
====

Pug is a simple light-weight distributed issue tracker whose purpose is to autogenerate releasereports.

Why
----
We are lazy. We don't want to manually keep track of releases.

How?
----

Add a bug:
> cd example
> pug.rb init
(enter ./pugs_new_release)

Pug will create a file .pug_global containing what directory pug should use to 
store issues in.

> pug.rb add Bug Reported
(enter title of the bug)

Pug creates a new file with the filename set to a safe namne from the title. The 
file will be created in pugs_new_release/Bug/Reported. The first line of the file
contains the exact title. Feel free to edit the content of the title by changing 
the text on the first line. Pug does not care about the rest of the file. 
Do not change the filename since that is used to track the file later on...

> pug.rb diff Bug pugs_previous_release
(shows a report on what has happened to issues between two imaginary releases..)