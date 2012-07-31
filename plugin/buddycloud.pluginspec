Jenkins::Plugin::Specification.new do |plugin|

  plugin.name = 'buddycloud'
  plugin.display_name = 'Buddycloud Plugin'
  plugin.version = '0.1.1'
  plugin.description = 'Sends build notifications to a Buddycloud instance.'

  # You should create a wiki-page for your plugin when you publish it, see
  # https://wiki.jenkins-ci.org/display/JENKINS/Hosting+Plugins#HostingPlugins-AddingaWikipage
  # This line makes sure it's listed in your POM.
  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Buddycloud+Plugin'

  # The first argument is your user name for jenkins-ci.org.
  plugin.developed_by 'lloydwatkin', 'Lloyd Watkin <lloyd@evilprofessor.co.uk>'

  # This specifies where your code is hosted.
  plugin.uses_repository :github => 'lloydwatkin/buddycloud-plugin-for-jenkins'

  # This is a required dependency for every ruby plugin.
  plugin.depends_on 'ruby-runtime', '0.10'
  plugin.depends_on 'token-macro', '1.5.1'

end
