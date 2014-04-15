class Categoria
  include Mongoid::Document
  field :usuario, type: Object
  field :p_id, type: Integer
  field :descricao, type: String
  field :total_transacoes, type: Integer
  field :ultima_transacao, type: String
  field :planejado, type: Float
  
  def self.save_dados (j_categorias, id_usuario)
    categorias_salvas = [];
    JSON[j_categorias].each do |o_cat|
      cat = Categoria.new
      cat.usuario = id_usuario
      cat.attributes = o_cat
      if cat.save
        categorias_salvas.push(o_cat["p_id"])
      end
    end
    return categorias_salvas
  end
end
