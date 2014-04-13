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
      conta.p_id = o_conta["id"]
      conta.descricao = o_conta["descricao"]
      conta.saldo = o_conta["saldo"]
      conta.saldo_inicial = o_conta["saldo_inicial"]
      conta.tipo = o_conta["tipo"]
      conta.data_fechamento = o_conta["data_fechamento"]
      conta.dia_vencimento = o_conta["dia_vencimento"]
      conta.limite = o_conta["limite"]
      conta.status = o_conta["status"]
      conta.ult_atualizacao = o_conta["ult_atualizacao"]
      if conta.save
        contas_salvas.push(o_conta["id"]);
      end
    end
    return contas_salvas
  end
  
end
