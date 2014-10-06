class WorkshareFileReport
  attr_reader :files

  def initialize(files)
    @files = files
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

  def grouper
    GroupedFiles
  end

  def weighter
    WeighingScale
  end
end