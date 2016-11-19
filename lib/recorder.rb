module Standup
  class Recorder
    def initialize(filepath, data)
      @data = data
      File.open(filepath, 'w') { |file| file.write(formatted_data) }
    end

    def formatted_data
      return 'Nothing!' if @data.nil?

      @data.map { |d| "- #{d}\n" }.join(' ')
    end
  end
end
