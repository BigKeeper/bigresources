require 'json'
require 'bigToolBox/util/image_analyze_util'
require 'bigToolBox/model/tree_model'

module BigToolBox
  class ImageAnalyzeUtil
    def self.get_duplicate_name_file(path, file_type)
      Dir.chdir(path) do
        `tree -J #{path} > test.txt`
      end
      json_data = File.read("#{path}/test.txt")
      array = JSON.parse(json_data)
      array.select do | dic |
        detect_file(dic, file_type)
      end
    end

    def self.detect_file(dic, file_type)
      if TreeHierarchyType.type(dic["type"]) == DIRECTORY
        dic["contents"].collect do | contents_dic |
          detect_file(contents_dic, file_type)
        end
      elsif TreeHierarchyType.type(dic["type"]) == FILE
        if dic["contents"] == nil
          p dic["name"] if dic["name"] != nil && dic["name"].include?(file_type)
        else
          dic["contents"].collect do | contents_dic |
            detect_file(contents_dic, file_type)
          end
        end
      end
    end
  end
end
