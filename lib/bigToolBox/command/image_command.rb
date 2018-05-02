require 'bigToolBox/util/image_analyze_util'

module BigToolBox

  def self.image_resource_command
    desc "Detect image resource"
      command :image do |c|
        c.desc "Detect image resource whether is duplicated."
        c.command :detect do |detect|
          detect.action do |global_options, options, args|
            path = File.expand_path(global_options[:path])
            ImageAnalyzeUtil.get_duplicate_name_file_with_type(path, ".png")
          end
        end
      end
  end
end
