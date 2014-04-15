class Conta
  include Mongoid::Document
  field :usuario, type: Object
  field :p_id, type: Integer
  field :descricao, type: String
  field :saldo, type: Float
  field :saldo_inicial, type: Float
  field :tipo, type: Integer
  field :data_fechamento, type: String
  field :dia_vencimento, type: Integer
  field :limite, type: Float
  field :status, type: Integer
  field :ult_atualizacao, type: String
  
  def self.save_dados (j_contas, id_usuario)
    contas_salvas = [];
    JSON[j_contas].each do |o_conta|
      conta = Conta.new
      conta.usuario = id_usuario
      conta.attributes = o_conta
      if conta.save
        contas_salvas.push(o_conta["p_id"]);
      end
    end
    return contas_salvas
  end
  
end
