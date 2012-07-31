require 'erb'
require File.expand_path(File.dirname(__FILE__) + '/confluence')

class BuddycloudPluginWikiPage

  def post(username, password)
    confluence = Confluence.new
    confluence.post content, 'Buddycloud Plugin', 'JENKINS', username, password, 'wiki.jenkins-ci.org'
  end

  private

  def content
    template = ERB.new template_as_text
    readme = readme_as_wiki
    template.result(binding)
  end

  def readme_as_wiki
    `markdown2confluence README.md`
  end

  def template_as_text
    IO.read 'Rakelib/buddycloud-plugin-wiki-page.erb'
  end
end
