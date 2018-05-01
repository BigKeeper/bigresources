require "bigToolBox/version"
require "bigToolBox/command/image_command"
require 'gli'

include GLI::App

module BigToolBox
  # Your code goes here...
program_desc 'A collection of tools to improve iOS development efficiency.'

flag %i[p path], default_value: './'
flag %i[v ver], default_value: 'Version in Bigkeeper file'

image_resource_command

desc 'Show version of bigToolBox'
command :version do |version|
  version.action do |global_options, options, args|
    p "bigToolBox (#{VERSION})"
  end
end

exit run(ARGV)
end
