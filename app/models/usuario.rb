class Usuario
  include Mongoid::Document
  field :nome, type: String
  field :senha, type: String
  field :email, type: String
  field :ultimo_acesso, type: String
  field :token_email, type: String
  
  class_attribute :api_auth
  
  embeds_many :dispositivos
  
  accepts_nested_attributes_for :dispositivos
  
  STATUS_JA_CADASTRADO = 0
  STATUS_AGUARDANDO_CONFIRMACAO = 1
  STATUS_CADASTRADO_COM_SUCESSO = 2
  STATUS_ERRO_AO_CADASTRAR = 3
  STATUS_NAO_CADASTRADO = 4
  STATUS_TOKEN_REGERADO = 5
  
  def email_confirmacao_cadastro
    if !self.token_email.nil? && !self.token_email.empty?
      SendEmail.confirmacao_cadastro(self).deliver
      return true
    else
      return false
    end
  end
  
  def email_novo_token
    if !self.token_email.nil? && !self.token_email.empty?
      SendEmail.reset_senha(self).deliver
      return true
    else
      return false
    end
  end

  def validate ()
    user = Usuario.where(:email => self.email).first();
    if user
      if user.senha.nil? || user.senha == ""
        return false
      end
      if !self.api_auth
        if self.senha != user.senha
          return false;
        else
          user.ultimo_acesso = Time.new.strftime("%Y-%m-%d %H:%M:%S")
          user.save()
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
  
  def change_password(senha_atual, nova_senha)
    if self.senha == senha_atual
      self.senha = nova_senha
      return self.save
    else
      return false
    end
  end
  
  def get_token
    token = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    token << self.email
    token << self.nome
    token << rand(10)
    token = Digest::MD5.hexdigest(token)
    return token
  end

  def self.reset(email)
    user = Usuario.where(:email => email).first();
    if user
      if user.token_email.nil? || user.token_email.empty?
        user.token_email = user.get_token
        if user.save
          return self::STATUS_TOKEN_REGERADO
        else
          return self::STATUS_ERRO_AO_CADASTRAR
        end
      else
        return self::STATUS_AGUARDANDO_CONFIRMACAO
      end
    else
      return self::STATUS_NAO_CADASTRADO
    end
  end

  def self.register (dados_usuario)
    user = Usuario.where(:email => dados_usuario[:email]).first();
    if user
      if user.token_email.nil? || user.token_email.empty?
        return self::STATUS_JA_CADASTRADO
      else
        return self::STATUS_AGUARDANDO_CONFIRMACAO
      end
    else
      new_user = Usuario.new
      new_user.nome = dados_usuario[:nome]
      new_user.email = dados_usuario[:email]
      new_user.token_email = new_user.get_token
      if new_user.save
        return STATUS_CADASTRADO_COM_SUCESSO
      else
        return STATUS_ERRO_AO_CADASTRAR
      end
    end
  end

  def self.load (params)
    return self.find_by(:email => params[:email])
  end

  
end
