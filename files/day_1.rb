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

# Person = Class.new() #funcionou para o primeiro it do #3
Person = Class.new do
end
# esse codigo eh mais bonito mais o d cima da ideia de evolucao no test
# class Person
# end

