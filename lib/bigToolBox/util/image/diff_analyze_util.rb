require 'chunky_png'

module BigToolBox
  class AnalyzeUtil
    def self.image_diff_analyze(path,compare_path)

      images = [
        ChunkyPNG::Image.from_file(path),
        ChunkyPNG::Image.from_file(compare_path)
      ]

      diff = []
      #size compare
      return false unless images.first.height == images.last.height
      return false unless images.first.width == images.last.width

      #pixel compare
      images.first.height.times do | y |
        images.first.row(y).each_with_index do | pixel, x |
          diff << [x, y] unless pixel == images.last[x, y]
        end
      end
      diff.length.zero?
    end
  end
end
