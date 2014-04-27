class Recorrente
  include Mongoid::Document
  field :usuario, type: Object
  field :p_id, type: Integer
  field :data, type: String
  field :valor, type: Float
  field :id_beneficiario, type: Integer
  field :id_categoria, type: Integer
  field :parcela, type: Integer
  field :total_parcelas, type: Integer
  field :id_conta, type: Integer
  field :tipo, type: String
  field :valor_fixo, type: Integer
  field :excluido, type: Integer
  
  scope :do_usuario, ->(user) { where(:usuario => user) }
  
  def self.save_dados (j_recorrentes, id_usuario)
    recorrentes_salvas = [];
    JSON[j_recorrentes].each do |o_recorrente|
      recorrente = Recorrente.do_usuario(id_usuario).where(:p_id => o_recorrente["p_id"]).first()
      if recorrente
        recorrente = Recorrente.new
      end
      
      recorrente.usuario = id_usuario
      recorrente.attributes = o_recorrente;
      if recorrente.save
        recorrentes_salvas.push(o_recorrente["p_id"])
      end
    end
    return recorrentes_salvas
  end
end
