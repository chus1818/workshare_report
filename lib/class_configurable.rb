module ClassConfigurable
  extend ActiveSupport::Concern

  def config
    @config = self.class.config
  end

  module ClassMethods
    def config(schema = nil)
      @config = OpenStruct.new(schema) and after_config.try(:call) if schema
      @config
    end

    def after_config(&block)
      @after_config = block if block_given?
      @after_config
    end
  end
end