class WorkshareFileRetrieval
  def self.files(session)
    files = Workshare::Client.files(session)
    raise InvalidSessionError if files.has_error_code?
    
    files.map { |file| File.new file }
  end

  class File < SimpleDelegator
    include ClassConfigurable

    def initialize(file_data)
      super OpenStruct.new(file_data)
    end

    def weight
      @weight ||= instance_eval weight_operation
    end

    def size
      @size ||= super / BigDecimal(config.size_normalization[:divide])
    end

    def type
      @type ||= begin
        type_tuple = config.types.detect { |_, val| val.include? extension }
        type_tuple.try(:[], 0) || :other 
      end
    end

    def to_collapsable_h
      { weight: weight, size: size, amount: 1 }
    end
  
  private

    def weight_operation
      config.weights[type]
    end
  end

  class InvalidSessionError < StandardError
  end
end
