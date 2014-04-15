class Beneficiario
  include Mongoid::Document
  field :usuario, type: Object
  field :p_id, type: Integer
  field :descricao, type: String
  field :total_transacoes, type: Integer
  field :ultima_transacao, type: String
  field :id_ultima_categoria, type: Integer
  
  def self.save_dados (j_beneficiarios, id_usuario)
    beneficiarios_salvos = [];
    JSON[j_beneficiarios].each do |o_beneficiario|
      beneficiario = Beneficiario.new
      beneficiario.usuario = id_usuario
      beneficiario.attributes = o_beneficiario
      if beneficiario.save
        beneficiarios_salvos.push(o_beneficiario["p_id"])
      end
    end
    return beneficiarios_salvos
  end
  
end
