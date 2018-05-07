
module BigToolBox
  class FileInfoModel
    attr_accessor :file_path, :file_name, :total_count
    def initialize(file_name)
      @file_path = []
      @total_count = 0
      @file_name = file_name
    end

    def add_file_path(file_path)
      if file_path.length > 0
        @file_path << file_path
        @total_count += 1
      end
    end
  end
end
