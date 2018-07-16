require 'json'
require 'big_resources/model/hierarchy_type'
require 'big_resources/model/file_model'
require 'big_resources/util/image/file_scan_util'

module BigResources
  class ImageAnalyzeUtil
    def self.get_duplicate_name_file_with_type(path, file_type)
      file_filter_dic = {}
      Dir.chdir(path) do
        `tree -J #{path} > fileHierarchy.json`
      end
      json_data = File.read("#{path}/fileHierarchy.json")
      result_array = JSON.parse(json_data)
      result_array.select do | dic |
        FileScanUtil.detect_file_by_name(dic, PictureFileType.type_name(file_type), path, file_filter_dic)
      end
      array = FileScanUtil.get_duplicate_name_file(file_filter_dic)
      puts JSON.pretty_generate(array)
    end

    def self.get_duplicate_content_file_with_type(path, file_type)
      file_filter_dic = {}
      Dir.chdir(path) do
        `tree -J #{path} > fileHierarchy.json`
      end
      json_data = File.read("#{path}/fileHierarchy.json")
      result_array = JSON.parse(json_data)

      result_array.select do | dic |
        FileScanUtil.detect_file_by_size(dic, PictureFileType.type_name(file_type), path, file_filter_dic)
      end
      array = FileScanUtil.get_same_file(file_filter_dic)
      puts JSON.pretty_generate(array)
    end
  end
end
