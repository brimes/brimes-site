class Dispositivo
  include Mongoid::Document
  field :uuid, type: String
  field :name, type: String
  field :platform, type: String
  field :framework, type: String
  field :versao, type: String
  field :model, type: String
  field :ultima_sincronizacao, type: String
  field :status, type: String
  
  embedded_in :usuario
    
  def unlock(status)
    if status == "LIBERADO"
      self.status = "BLOQUEADO"
    else
      self.status = "LIBERADO"
    end
    return self.save
  end
  
end
