class ApiController < ApplicationController
  before_action :validate_api
  skip_before_action :verify_authenticity_token # Permitindo cross-site
  
  def start
    sinc = Sincronizacao.start(@user, params[:device])
    if sinc[:status] == "OK"
      render json: {:status => "OK", :id_api => sinc[:id]}
    else
      render json: {:status => sinc[:status]}
    end
  end
  
  def contas
    contas_salvas = Conta.save_dados(params[:dados], @user._id)
    render json: {:status => "OK", :ids => contas_salvas}
  end

  def beneficiarios
    beneficiarios_salvos = Beneficiario.save_dados(params[:dados], @user._id)
    render json: {:status => "OK", :ids => beneficiarios_salvos}
  end

  def categorias
    categorias_salvas = Categoria.save_dados(params[:dados], @user._id)
    render json: {:status => "OK", :ids => categorias_salvas}
  end

  def recorrentes
    recorrentes_salvas = Recorrente.save_dados(params[:dados], @user._id)
    render json: {:status => "OK", :ids => recorrentes_salvas}
  end

  def transacoes
    transacoes_salvas = Transacao.save_dados(params[:dados], @user._id)
    render json: {:status => "OK", :ids => transacoes_salvas}
  end

  def get_contas
    j_contas = [];
    Conta.do_usuario(@user._id).each do |conta|
      j_contas.push(conta)
    end
    render json: {:status => "OK", :resp => j_contas}
  end

  def get_beneficiarios
    j_dados = [];
    Beneficiario.do_usuario(@user._id).each do |info|
      j_dados.push(info)
    end
    render json: {:status => "OK", :resp => j_dados}
  end
  
  def get_categorias
    j_dados = [];
    Categoria.do_usuario(@user._id).each do |info|
      j_dados.push(info)
    end
    render json: {:status => "OK", :resp => j_dados}
  end
  
  def get_recorrentes
    j_dados = [];
    Recorrente.do_usuario(@user._id).each do |info|
      j_dados.push(info)
    end
    render json: {:status => "OK", :resp => j_dados}
  end
  
  def get_transacoes
    j_dados = [];
    Transacao.do_usuario(@user._id).each do |info|
      j_dados.push(info)
    end
    render json: {:status => "OK", :resp => j_dados}
  end
  
  
  def stop
    time = Time.new
    @sinc.data_hora_fim = time.strftime("%Y-%m-%d %H:%M:%S")
    if @sinc.save
      render json: {:status => "OK"}
    else 
      render json: {:status => "ERROR"}, :status => 500
    end
  end
  
  private 
  def validate_api
    @user = Usuario.load(params[:user])
    if !@user
      render json: {:error => "Usuario nao localizado", :status => 401, :params => params[:user]}, :status => :unauthorized
    end
      
    if !@user.validate()
      render json: {:error => "Acesso nao autorizado", :status => 401}, :status => :unauthorized
    end
    
    if params[:user][:keyApi]
      @sinc = Sincronizacao.find(params[:user][:keyApi])
    end
    
  end
end
