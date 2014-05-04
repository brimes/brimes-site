class Usuario
  include Mongoid::Document
  field :nome, type: String
  field :senha, type: String
  field :email, type: String
  
  class_attribute :api_auth
  
  def validate ()
    user = Usuario.where(:email => self.email).first();
    if user
      if !self.api_auth
        if self.senha != user.senha
          return false;
        end
      end
      self._id = user._id
      self.nome = user.nome
      return true
    else
      return false
    end
  end
  
  def email_hash
    return Digest::MD5.hexdigest(self.email.strip.downcase)
  end
  
  
  def self.load (params)
    return self.find_by(:email => params[:email])
  end
  
end
