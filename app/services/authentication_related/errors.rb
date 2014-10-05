class Authentication::Errors
  attr_reader :list
  delegate :empty?, to: :list

  def initialize(*args)
    @list = args.map { |error_sym| build_error_class_from error_sym }
  end

  def to_s
    list.map(&:to_s).join(' ')
  end

  def remove(selector)
    list.reject! { |e| e.name.end_with? selector.to_s.classify }
  end

  def add(error_sym)
    list << build_error_class_from(error_sym)
  end

private

  def build_error_class_from(error_sym)
    self.class.const_get error_sym.to_s.classify
  end

  class UnperformedAuthentication < StandardError
    def self.to_s
      "Hasn't been triggered."
    end
  end

  class WrongCredential < StandardError
    def self.to_s
      "Input credentials do not match."
    end
  end

  class UnexpectedError < StandardError
    def self.to_s
      "Something unexpected happended. Please try again."
    end
  end
end