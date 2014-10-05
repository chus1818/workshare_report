class Hash
  def normalize
    inject ({}) do |sum, (key, value)|
      sum.merge key.to_s.underscore.to_sym => value.normalize
    end
  end
end