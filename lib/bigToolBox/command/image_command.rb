
module BigToolBox
  def self.image_resource_command
    desc "Detect image resource"
      command :image do |c|
        c.desc "Detect image resource whether is duplicated."
        c.command :unique do |unique|
          unique.action do |global_options, options, args|
            path = File.expand_path(global_options[:path])
            version = global_options[:ver]
            # user = global_options[:user].gsub(/[^0-9A-Za-z]/, '').downcase
            p path
            p version
            # p user
          end
        end
      end
  end
end
