
module BigResources
  FILE = 1
  DIRECTORY = 2
  class TreeHierarchyType
    include Enumerable
    def each
      yield 'file'
      yield 'directory'
    end

    def self.type(file_name)
      if file_name == "file"
        FILE
      elsif file_name == "directory"
        DIRECTORY
      end
    end

    def self.file_type_name(file_name)
      if file_name == "file"
        "file"
      elsif file_name == "directory"
        "directory"
      end
    end
  end

end
