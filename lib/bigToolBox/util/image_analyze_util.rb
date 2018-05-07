require 'json'
require 'bigToolBox/util/image_analyze_util'
require 'bigToolBox/model/file_type'
require 'bigToolBox/model/file_model'

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
        detect_file(dic, file_type, path, file_filter_dic)
      end
      array = get_duplicate_name_file(file_filter_dic)
      p array
    end

    def self.detect_file(dic, file_type, last_path, result_dic)
      current_path = get_current_path(last_path,dic["name"])
      if TreeHierarchyType.type(dic["type"]) == DIRECTORY
        dic["contents"].collect do | contents_dic |
          detect_file(contents_dic, file_type, current_path, result_dic)
        end
      elsif TreeHierarchyType.type(dic["type"]) == FILE
        if dic["contents"] == nil
          if  dic["name"] != nil && dic["name"].include?(file_type)
            if result_dic[dic["name"]] == nil
              result_dic[dic["name"]] = {:count => 1, :path => [current_path]}
            else
              result_dic[dic["name"]][:count] += 1
              result_dic[dic["name"]][:path] << current_path
            end
          end

        else
          dic["contents"].collect do | contents_dic |
            detect_file(contents_dic, file_type, current_path, result_dic)
          end
        end
      end
    end

      def self.get_duplicate_name_file(dic)
        duplicate = []
        dic.keys.select do | file_name_key |
          if dic[file_name_key][:count] > 1
            duplicate << {"file_name" => file_name_key,
                              "count" => dic[file_name_key][:count],
                              "path" => dic[file_name_key][:path]}
          end
        end
        duplicate
      end

    def self.get_current_path(last_path,file_name)
      "#{last_path}/#{file_name}"
    end
  end
end
