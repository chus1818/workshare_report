class FileRetrieval::File < SimpleDelegator
  delegate :config, to: FileRetrieval

  def initialize(file_data)
    super OpenStruct.new(file_data)
  end

  def weight
    @weight ||= instance_eval(weight_operation).round size_norm[:round]
  end

  def size
    @size ||= (super / Float(size_norm[:divide])).round size_norm[:round]
  end

  def type
    @type ||= begin 
      config.types.detect { |_, val| val.include? extension }.try(:[], 0) || :other 
    end
  end

private

  def size_norm
    config.size_normalization
  end

  def weight_operation
    config.gravity[:weight][type]
  end
end