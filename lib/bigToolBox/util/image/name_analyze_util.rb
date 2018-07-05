require 'json'
require 'bigToolBox/model/hierarchy_type'
require 'bigToolBox/model/file_model'
require 'bigToolBox/util/image/file_scan_util'

module BigToolBox
  class ImageAnalyzeUtil
    def self.get_duplicate_name_file_with_type(path, file_type)
      file_filter_dic = {}
      Dir.chdir(path) do
        `tree -J #{path} > fileHierarchy.json`
      end
      json_data = File.read("#{path}/fileHierarchy.json")
      result_array = JSON.parse(json_data)
      result_array.select do | dic |
        detect_file_by_name(dic, file_type, path, file_filter_dic)
      end
      array = get_duplicate_name_file(file_filter_dic)
      p array
    end
  end
end
