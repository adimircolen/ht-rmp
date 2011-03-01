class Object
  singleton_class
  def metaclass
    singleton_class
  end
end

module App
  class << self
    attr_accessor :description
    self
  end
end
