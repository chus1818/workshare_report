class GroupedFiles
  include Enumerable
  attr_reader :files, :grouper
  delegate :each, to: :collapsed_files

  def initialize(input, options = {})
    @files         = Array(input)
    @grouper       = options.fetch :by
  end

private

  def collapsed_files
    @collapsed_files ||= files.group_by(&grouper).map do |key, group|
      {grouper => key}.merge collapsed(group)
    end
  end

  def collapsed(file_group)
    file_group.map(&:to_collapsable_h).inject(Hash.new 0) do |sum, file|
      sum.merge(file) { |k, old_v, new_v| old_v + new_v } 
    end
  end
end