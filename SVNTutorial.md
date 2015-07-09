# Introduction #
This is the basic SVN tutorial I wrote for another project some time back.  Hopefully you find it helpful. :)

# General Method #
The basics for SVN are checkout, add, commit, and update.
## Checkout ##
The first thing you need to do is "checkout" the repository to a folder on your computer.  This creates a copy of whatever you checked out.  We should use
> https://friday-software-engineering.googlecode.com/svn/trunk/
This provides the current (trunk) development line of the project.
## Add ##
Once we have the active area in which to work, we need to add our files to it.  If you have existing files, move them to your working area.  Now we need to "add" them, so that svn knows they exist.  Once they are added, don't change their names through your OS, or you will confuse your checkout and have to revert.  You can tell svn to change filenames, though.
## Commit ##
Once we have files in the active space we need to commit the space.  This copies everything to the repository, allowing us to check it out and use it.
## Update ##
This updates your working copy to the current revision in the repository.  It's a good idea to update your copy before you start working on anything.
# Linux Commands #
On Linux, the commands are thus:
## Checkout ##
> svn checkout https://friday-software-engineering.googlecode.com/svn/trunk/ [where/you/want/it] --username $YourUsername
## Status ##
Lists things like what has changed and files that svn isn't sure about (like things you added but didn't add to SVN).
This is run in your working area.
> svn status
## Add ##
This is run in your working area.
> svn add $filename
## Commit ##
This is run in your working area.
> svn commit
## Update ##
This is run in your working area.
> svn update
# Windows Method #
There is an svn tool for Windows called [TortoiseSVN](http://tortoisesvn.net/downloads) which I have found works very well.