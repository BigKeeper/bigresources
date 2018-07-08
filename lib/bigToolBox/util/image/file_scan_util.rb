require 'json'
require 'bigToolBox/model/file_type'
require 'bigToolBox/util/image/diff_analyze_util'

module BigToolBox
  class FileScanUtil

    def self.file_with_type(name, type)
      PictureFileType.is_type(name, type)
    end

    #分析同名文件
    def self.detect_file_by_name(dic, file_type, last_path, result_dic)
      current_path = get_current_path(last_path,dic["name"])
      current_path = last_path if last_path == dic["name"]
      if TreeHierarchyType.type(dic["type"]) == DIRECTORY
        dic["contents"].collect do | contents_dic |
          detect_file_by_name(contents_dic, file_type, current_path, result_dic)
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
            detect_file_by_name(contents_dic, file_type, current_path, result_dic)
          end
        end
      end
    end

    #分析图片文件大小
    def self.detect_file_by_size(dic, file_type, last_path, result_dic)
      current_path = get_current_path(last_path,dic["name"])
      current_path = last_path if last_path == dic["name"]
      if TreeHierarchyType.type(dic["type"]) == DIRECTORY
        dic["contents"].collect do | contents_dic |
          detect_file_by_size(contents_dic, file_type, current_path, result_dic)
        end
      elsif TreeHierarchyType.type(dic["type"]) == FILE
        if dic["contents"] == nil
          if  dic["name"] != nil && dic["name"].include?(file_type)
            file_size = File.size(current_path)
            if file_size && result_dic["#{file_size} kb"] == nil
              result_dic["#{file_size} kb"] = {:count => 1, :path => [current_path]}
            else
              result_dic["#{file_size} kb"][:count] += 1
              result_dic["#{file_size} kb"][:path] << current_path
            end
          end

        else
          dic["contents"].collect do | contents_dic |
            detect_file_by_size(contents_dic, file_type, current_path, result_dic)
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

      def self.get_same_file(dic)
        duplicate = []
        dic.keys.select do | file_size |
          if dic[file_size][:count] > 1
            dic[file_size][:path].each do | file_path |
              is_all_same = false
              dic[file_size][:path].each do | afile_path |
                  next if file_path.eql?(afile_path)
                  is_same = AnalyzeUtil.image_diff_analyze(file_path,afile_path)
                  if is_same
                    duplicate << {:file_size => file_size,
                                  :count => dic[file_size][:count],
                                  :path => dic[file_size][:path]
                                 }
                  end
              end
            end
          end
        end
        duplicate
      end

    def self.get_current_path(last_path,file_name)
      "#{last_path}/#{file_name}"
    end
  end
end
