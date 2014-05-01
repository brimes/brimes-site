class Usuario
  include Mongoid::Document
  field :nome, type: String
  field :senha, type: String
  field :email, type: String
  
  def validate ()
    if (self.email == "brunodelima@gmail.com")
      return true
    else
      return false
    end
  end
  
  def self.load (params)
    return self.find_by(:email => params[:email])
  end
  
end
