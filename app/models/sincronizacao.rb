class Sincronizacao
  include Mongoid::Document
  field :hash, type: String
  field :data_hora_inicio, type: String
  field :data_hora_fim, type: String
  field :usuario, type: Object
  field :uuid, type: String
  field :status, type: String
  
  def self.start(user, device)
    time = Time.new
    sinc = self.new
    sinc.uuid = device[:uuid]
    sinc.data_hora_inicio = time.strftime("%Y-%m-%d %H:%M:%S")
    sinc.usuario = user._id

    dispo = user.dispositivos.where(:uuid => device[:uuid]).first();
    if !dispo
      dispo = user.dispositivos.new
      dispo.uuid = device[:uuid]
      dispo.name = device[:name]
      dispo.platform = device[:platform]
      dispo.framework = device[:framework]
      dispo.model = device[:model]
      dispo.versao = device[:versao]
      dispo.status = "BLOQUEADO";
      dispo.save
      sinc.status = "BLOQUEADO"
    else
      if dispo.status == "LIBERADO"
        sinc.status = "LIBERADO"
      else
        sinc.status = "BLOQUEADO"
      end
    end
    
    if sinc.save
      if sinc.status == "LIBERADO"
        return {:status => 'OK', :id => sinc._id}
      else
        return {:status => 'BLOQUEADO'}
      end
      
    else
      return {:status => 'ERROR'}
    end
  end
  
end
