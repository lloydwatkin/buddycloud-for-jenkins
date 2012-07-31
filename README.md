# Buddycloud for Jenkins

This Buddycloud (http://www.buddycloud.org) plugin for Jenkins CI (http://jenkinsci.org) enables notifcation to be sent to a Buddycloud channel on the success or failure of a build.

The success and fail messages can be customised for each project.

## Installation

I am currently adding one last feature and then I shall make available via the standard Jenkins CI plugin system

## Enable Buddycloud notifications

In the job configuration, under Post-build actions, select __Buddycloud Notification__.

Enter an API base URL (e.g. https://api.buddycloud.org - __no ending slash__), a valid username and password, and the channel to wish you want the posts to go. Note: The user must have post rights to that channel.

## Todo

* Add the ability to update a channels status line depending on the status of the last build
* Add example messages

## Feedback

To [raise an issue](https://github.com/lloydwatkin/buddycloud-for-jenkins/issues) or send an email to lloyd@evilprofessor.co.uk.

## Notes

Inspiration from https://github.com/mattriley/yammer-plugin-for-jenkins
