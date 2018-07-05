require 'chunky_png'

module BigToolBox
  class AnalyzeUtil
    def self.image_diff_analyze(path,compare_path)

      images = [
        ChunkyPNG::Image.from_file(path),
        ChunkyPNG::Image.from_file(compare_path)
      ]

      diff = []
      p images.first.height
      p images.first.width
      p images.last.height
      p images.last.width

      return false unless images.first.height == images.last.height
      return false unless images.first.width == images.last.width

      images.first.height.times do | y |
        images.first.row(y).each_with_index do | pixel, x |
          diff << [x, y] unless pixel == images.last[x, y]
        end
      end
      # puts "pixels (total):     #{images.first.pixels.length}"
      # puts "pixels changed:     #{diff.length}"
      # puts "pixels changed (%): #{(diff.length.to_f / images.first.pixels.length) * 100}%"
      diff.length == 0
    end
  end
end
