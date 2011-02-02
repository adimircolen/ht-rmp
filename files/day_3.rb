# Solução do exercício 1
#
# O método class_eval permite passar dois argumentos adicionais
# que irão definir o arquivo e linha onde este método foi criado.
#
# Esta técnica só funciona se o class_eval receber uma string.
#
module Helper
  class_eval <<-RUBY, __FILE__, __LINE__
    def upcase(string)
      string.to_s.upcase
    end
  RUBY
end

# Solução do exercício 2
#
# O método extend permite estender QUALQUER objeto com um módulo.
# Os métodos deste módulo serão adicionados no contexto deste objeto.
#
def extend_object(object, mod)
  object.extend(mod)
end

# Solução do exercício 3
#
# O método extend permite estender QUALQUER objeto com um módulo.
# Os métodos deste módulo serão adicionados no contexto deste objeto.
#
module Helper
  class << self
    def downcase(string)
      string.to_s.downcase
    end
  end
end

# Solução do exercício 4
#
# O método instance_eval permite executar um bloco no contexto de qualquer objeto.
# O & define que o bloco será atribuído à variável block, mas apenas quando for definindo.
#
# Esta definição é feita quando você passa um bloco para um método na sintaxe
#
#   some_method {  }
#
# ou
#
#   some_method do
#   end
#
def execute_block(object, block)
  object.instance_eval(&block)
end

# Solução do exercício 5
#
# Como os métodos class_eval e instance_eval alteram o contexto do bloco para self,
# é possível fazer qualquer coisa que você faria se estivesse naquele contexto,
# como executar métodos privados e acessar variáveis de instância.
#
def execute_private
  Tools.class_eval { prepare }
end

# Solução do exercício 6
#
# O objetivo deste exercício é utilizar o conceito de Mixins,
# que são módulos que pode ser injetados em diversos objetos
# diferentes para compartilhar comportamento.
#
module Multiplier
  def multiply(multiplier)
    collect {|n| n * multiplier}
  end
end
