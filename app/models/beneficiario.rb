class Beneficiario
  include Mongoid::Document
  field :usuario, type: Object
  field :p_id, type: Integer
  field :descricao, type: String
  field :total_transacoes, type: Integer
  field :ultima_transacao, type: String
  field :id_ultima_categoria, type: Integer
  
  def self.save_dados (j_beneficiarios, id_usuario)
    JSON[j_beneficiarios].each do |o_beneficiario|
      beneficiario = Beneficiario.new
      beneficiario.usuario = id_usuario
      beneficiario.p_id = o_beneficiario["id"]
      beneficiario.descricao = o_beneficiario["descricao"]
      beneficiario.total_transacoes = o_beneficiario["total_transacoes"]
      beneficiario.ultima_transacao = o_beneficiario["ultima_transacao"]
      beneficiario.id_ultima_categoria = o_beneficiario["id_ultima_categoria"]
      beneficiario.save
    end 
  end
  
end
