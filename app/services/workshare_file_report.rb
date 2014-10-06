class WorkshareFileReport
  attr_reader :files, :grouper, :weighter

  def initialize(files, options = {})
    @files = files
    @grouper  = options.fetch :grouper
    @weighter = options.fetch :weighter
  end

  def groups
    grouper.new files, by: :type
  end

  def total_weight
    weighing_scale.total_weight
  end

  def additional_gravity
    weighing_scale.additional_gravity
  end

private
  
  def weighing_scale
    weighter.new files
  end
end