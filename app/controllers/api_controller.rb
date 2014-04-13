class ApiController < ApplicationController
  before_action :validate_api
  skip_before_action :verify_authenticity_token # Permitindo cross-site
  
  def index
  end
  
  def start
    @sinc = Sincronizacao.start(@user._id)
    respond_to do |format|
      format.json { render action: 'start', location: @sinc }
    end
  end
  
  def contas
    contas_salvas = Conta.save_dados(params[:contas], @user._id)
    render json: {:status => "OK", :ids => contas_salvas}
  end

  def beneficiarios
    Beneficiario.save_dados(params[:beneficiarios], @user._id)
    render json: {:status => "OK"}
  end

  def categorias
    Conta.save_dados(params[:contas], @user._id)
    render json: {:status => "OK"}
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