class FileRetrieval
  include ClassConfigurable
  
  def files
    @files ||= Workshare::Client.files.map { |file| File.new file }
  end

  def collapsed_files
    files.group_by(&:type).map do |type, content|
      {type: type}.merge collapsed(content)
    end
  end

  def report
    { 
      groups:             collapsed_files,
      total_weight:       total_weight, 
      additional_gravity: additional_gravity 
    }
  end

  def total_weight
    files.map(&:weight).reduce(&:+).round round_value
  end

  def total_size
    files.map(&:size).reduce(&:+).round round_value
  end

  def additional_gravity
    (total_weight - total_size).round round_value
  end

private
  
  def collapsed(files)
    files.inject(Hash.new 0) do |sum, file|
      sum.merge weight: (sum[:weight] + file.weight), amount: sum[:amount] + 1 
    end
  end

  def round_value
    config.size_normalization[:round]
  end
end

require_dependency './file_retrieval_related/file'