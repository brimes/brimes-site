class Transacao
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
  field :transferencia, type: Integer # // 1 - Destino, 2 - Origem
  field :id_conta_transferencia, type: Integer
  field :id_pagador, type: Integer
  field :status, type: Integer
  field :saldo_acumulado, type: Float
  
  scope :do_usuario, ->(user) { where(:usuario => user) }
  
  def self.save_dados (j_transacoes, id_usuario)
    transacoes_salvas = [];
    JSON[j_transacoes].each do |o_transacao|
      transacao = Transacao.do_usuario(id_usuario).where(:p_id => o_transacao["p_id"]).first()
      if !transacao
        transacao = Transacao.new
      end

      transacao.usuario = id_usuario
      transacao.attributes = o_transacao;
      if transacao.save
        transacoes_salvas.push(o_transacao["p_id"])
      end
    end
    return transacoes_salvas
  end
  
  
end
