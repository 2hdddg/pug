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

To generate a report of what has happened since last release:
> ruby release_example.rb ./pugs_current ./pugs_new ./release_reports

./pugs_current is the directory where bugs are located for the release that has been deployed previously and is about to be replaced by a new release.

./pugs_new is the directory containing bugs for the release being deployed

./release_reports is the directory that will contain the report for what has happened since last release

