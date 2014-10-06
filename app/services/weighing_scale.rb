class WeighingScale
  attr_reader :files

  def initialize(input)
    @files = Array(input)
  end

  def total_weight
    files.map(&:weight).reduce(&:+)
  end

  def total_size
    files.map(&:size).reduce(&:+)
  end

  def additional_gravity
    total_weight - total_size
  end
end