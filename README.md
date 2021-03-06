Pug
====

Pug is a simple light-weight distributed issue tracker whose purpose is to autogenerate releasereports.

Why
----
We are lazy. We don't want to manually keep track of releases.

How?
----

Add a bug:

    CMD> cd example
    CMD> pug.rb add Bug Reported
    (enter title of the bug)

Pug creates a new file with the filename set to a safe namne from the title. The 
file will be created in pugs/Bug/Reported. The first line of the file
contains the exact title. Feel free to edit the content of the title by changing 
the text on the first line. Pug does not care about the rest of the file so you
can add whatever other content you want to the file. 
Do not change the filename since that is used to track the file later on...

The Bug parameter tells pug what kind of issue to add, could be bug, feature or whatever. Pug will
create a new directory if none exists.

The Reported parameter tells pug the initial status/state of the issue. Pug will create a new directory
if none exists.

    CMD> pug.rb diff Bug pugs_previous_release
(shows a report on what has happened to issues between two imaginary releases..)

    CMD> pug.rb list type=Bug status=Reported
(shows a list of all open bugs)

To get a html version of the diff, use pugdiff:

    CMD> pugdiff.rb Bug pugs_new_release pugs_previous_release templates/diff_html_standard.erb

To get an idea of what this will look in a real-world scenario when pushing releases to production
and automatically generating a release report for each release, checkout the code in release_example.rb,
or run it:

    CMD> ruby ./release_example.rb

This will use pugs from ./pugs_new_release as the state of issues for the release being deployed and compare
this to the state of issues of the currently deployed pugs in ./pugs_previous_release and generate an html report
in the ./release_reports directory. Pugs from previous release will be replaced with pugs from the new release.
