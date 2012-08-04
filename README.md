# buddycloud for Jenkins

This buddycloud (http://www.buddycloud.org) plugin for Jenkins CI (http://jenkinsci.org) enables notifcation to be sent to a buddycloud channel on the success or failure of a build.

The success and fail messages can be customised for each project.

## Installation

Install the plugin from the Jenkins Plugin Manager. It should be listed as __buddycloud Plugin__ under __Build Notifiers__.

### Manual Install

* Install the ruby-runtime plugin.
* Install the Token Macro Plugin. It may already be installed.
* Download the latest buddycloud plugin .hpi file from: http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/ruby-plugins/buddycloud.
* Upload the .hpi file into Jenkins from Plugin Manager > Advanced.
* Restart Jenkins.

## Enable buddycloud notifications

In the job configuration, under Post-build actions, select __buddycloud Notification__.

Enter an API base URL (e.g. https://api.buddycloud.org - __no ending slash__), a valid username and password, and the channel to wish you want the posts to go. Note: The user must have post rights to that channel.

You can also update the status message of a channel dependent on build success, you must have write permission to this node also.

## Todo

* Add the ability to update a channels status line depending on the status of the last build
* Add example messages
* Add some images to README.md

## Feedback

To [raise an issue](https://github.com/lloydwatkin/buddycloud-for-jenkins/issues) or send an email to lloyd@evilprofessor.co.uk.

## Notes

For more information on the buddycloud HTTP API please see https://buddycloud.org/wiki/Buddycloud_HTTP_API.
Inspiration from https://github.com/mattriley/yammer-plugin-for-jenkins

## Version 

* __0.2.3__
  * Bundled nokogiri
  * Bugs fixed from deployment to a third party server
* __0.2.2__
  * Update to support latest Jenkins instance
  * Nokogiri not bundled do not use
* __0.2.1__
  * Fixed endpoint
  * Nokogiri not bundled do not use
* __0.2.0__
  * Update to new API end points https://buddycloud.org/wiki/Buddycloud_HTTP_API#API_Endpoints
  * %s/Buddycloud/buddycloud/g https://github.com/lloydwatkin/buddycloud-for-jenkins/issues/1
* __0.1.0__
  * Initial working version
