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

Awesome = Class.new

def new_class
  Class.new(Person)
end

def new_method(instance)
  #eu queria usar define_method junto com o instance_eval
  # pra ficar mais claro o codigo tem como ?
  instance.instance_eval do
    def hello
      "Hello from HOWTO instance"
    end
  end
end
