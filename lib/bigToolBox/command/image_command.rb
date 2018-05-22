require 'bigToolBox/util/image/name_analyze_util'
require 'bigToolBox/util/image/diff_analyze_util'

module BigToolBox

  def self.image_resource_command
    desc "Detect image resource"
      command :image do | c |
        c.desc "Detect duplicate name image resources."
        c.command :name do | name |
          name.action do | global_options, options, args |
            path = File.expand_path(global_options[:path])
            ImageAnalyzeUtil.get_duplicate_name_file_with_type(path, ".png")
          end
        end

      c.desc "Detect duplicate content image resources."
      c.command :content do | content |
        content.action do | global_options, options, args |
          path = File.expand_path(global_options[:path])
          #test file name
          file_path1 = '/Users/serena_rui/Downloads/111/image_close_bapin@4x.png'
          file_path2 = '/Users/serena_rui/Downloads/111/image_close_bapin@3x.png'
          AnalyzeUtil.image_diff_analyze(file_path1,file_path1)
        end
      end
    end
  end
end
