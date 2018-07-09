module BigResources

  UNKNOWN = -1
  PNG = 1
  PDF = 2
  JPG = 3
  JPEG = 4
  BMP = 5

  class PictureFileType
    include Enumerable
    def each
      yield PNG
      yield PDF
      yield JPG
      yield JPEG
      yield BMP
    end

    def self.is_type(file_name,type)
      PictureFileType.each do | type |
        regexStr = "^[\w-]+(\.#{type})$"
        regex = Regex.create(regexStr)
        if regex =~ file_name
        end
      end
      # if file_name ~= /.*[.png]$/
      #   PNG
      # elsif file_name  ~= /.*[.pdf]$/
      #   PDF
      # elsif file_name  ~= /.*[.png]$/
      #   JPG
      # elsif file_name  ~= /$.jpeg/
      #   JPEG
      # elsif file_name  ~= /$.bmp/
      #   BMP
      # else
      #   UNKNOWN
      # end
    end

    def self.type_name(type)
      if type == PNG
        ".png"
      elsif type == PDF
        ".pdf"
      elsif type == JPG
        ".jpg"
      elsif type == JPEG
        ".jpeg"
      elsif type == BMP
        ".bmp"
      end
    end
  end
end
