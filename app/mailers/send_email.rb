# encoding: utf-8
class SendEmail < ActionMailer::Base
  default from: "no-reply@brimes.com.br"

  def confirmacao_cadastro (user)
    @data = {"email" => user.email, "token" => user.token_email}
    mail to: user.email, subject: "[Brimes] - Confirmação de cadastro"
  end  

  def reset_senha (user)
    @data = {"email" => user.email, "token" => user.token_email}
    mail to: user.email, subject: "[Brimes] - Solicitação de nova senha"
  end  
  
end
