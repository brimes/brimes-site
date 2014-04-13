class ApiController < ApplicationController
  before_action :validate_user
  skip_before_action :verify_authenticity_token # Permitindo cross-site
  
  def index
  end
  
  def start
    @sinc = Sincronizacao.start(@user._id)
    respond_to do |format|
        format.json { render action: 'start', location: @sinc }
    end
  end

  def stop
  end
  
  private 
    def validate_user
      @user = Usuario.load(params[:user])
      if !@user
        render json: {:error => "Usuario nao localizado", :status => 401, :params => params[:user]}, :status => :unauthorized
      end
      
      if !@user.validate()
        render json: {:error => "Acesso nao autorizado", :status => 401}, :status => :unauthorized
      end
    end
end
