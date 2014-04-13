class Sincronizacao
  include Mongoid::Document
  field :hash, type: String
  field :data_hora_inicio, type: String
  field :data_hora_fim, type: String
  field :usuario, type: Object
  
  def self.start(user)
    time = Time.new
    sinc = self.new
    sinc.hash = "123"
    sinc.data_hora_inicio = time.strftime("%Y-%m-%d %H:%M:%S")
    sinc.usuario = user
    if sinc.save
      return sinc
    else
      return false
    end
  end
  
end
