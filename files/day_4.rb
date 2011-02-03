# Solução do exercício 1
#
# Primeiro, verificamos se a constante existe.
# Em caso positivo, verificamos se o valor dela foi alterado.
# Se o valor foi alterado, então removemos a constante existente e adicionamos a nova.
# Se o valor foi mantido, retornamos false.
#
def set_constant(name, value)
  const_name = name.to_s.upcase
  const_defined = Object.const_defined?(const_name)

  return false if const_defined && Object.const_get(const_name) == value

  Object.class_eval { remove_const const_name } if const_defined
  Object.const_set(const_name, value)
end

# Solução do exercício 2
#
# O hook method_missing é executado toda vez que um método não é
# encontrado. A palavra-chave super garantirá que o erro NoMethodError
# será lançado caso sua implementação não intercepte o método.
#
# Da mesma forma, precisamos sobrescrever o método respond_to?, adicionando
# nossa implementação.
#
module Color
  COLORS = {
    :red => "ff0000",
    :blue => "0000ff",
    :green => "00ff00",
    :black => "000000",
    :white => "ffffff"
  }

  def self.method_missing(name, *args)
    return COLORS[name] if COLORS.key?(name)
    super
  end

  def self.respond_to?(method, include_private = false)
    return true if COLORS.key?(method)
    super
  end
end

# Solução do exercício 3
#
# O hook inherited é executado toda vez que uma classe é herdada.
#
class Monster
  def self.ugly_monsters
    @ugly_monsters ||= []
  end

  def self.inherited(child)
    ugly_monsters << child.name unless ugly_monsters.include?(child.name)
  end
end

# Solução do exercício 4
#
# O hook method_added é executado toda vez que um método é executado.
# Se este método tiver "fuck" em seu nome, uma exceção será lançada.
#
class Monster
  class NoBadWordsError < StandardError; end

  def self.method_added(method)
    raise NoBadWordsError, "you can't use #{method} as a method name" if method =~ /fuck/
  end
end

# Solução do exercício 5
#
# O método Car#initialize executa um bloco no contexto da instância
# somente se um bloco foi passado.
#
# O método method_missing é responsável por criar os atributos em tempo de execução. Primeiro,
# removemos o "=", caso estejamos usando um writer pela primeira vez. Depois, adicionamos o writer
# e o método que agirá tanto como um getter quanto como setter.
#
# Este método só irá atribuir o valor se 1 argumento for passado.
#
class Car
  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def method_missing(name, *args)
    name = name.to_s.gsub(/=$/, "")

    self.class.class_eval <<-RUBY, __FILE__, __LINE__
      attr_writer :#{name}

      def #{name}(*args)
        @#{name} = args.first unless args.empty?
        @#{name}
      end
    RUBY

    send(name, *args)
  end
end
