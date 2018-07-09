require "big_resources/version"
require "big_resources/command/image_command"
require 'gli'

include GLI::App

module BigResources
  # Your code goes here...
program_desc 'A collection of tools to improve iOS development efficiency.'

flag %i[p path], default_value: './'
flag %i[v ver], default_value: 'Version in Bigkeeper file'

image_resource_command

desc 'Show version of BigResources'
command :version do |version|
  version.action do |global_options, options, args|
    p "BigResources (#{VERSION})"
  end
end

exit run(ARGV)
end
