# encoding: utf-8
class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  
  def login
    if request.post?
      if params[:commit] == "Acessar"
        user = Usuario.new
        user.email = params[:email]
        user.senha = params[:senha]
        user.api_auth = false
        if user.validate()
          session[:user_id] = user._id
          redirect_to home_path
          return true
        else
          flash.now[:danger] = "Usuário ou senha inválidos"
        end
      else
        flash.now[:danger] = "Parametros inválidos!"
      end
    else
      if session[:user_id]
        redirect_to home_path
        return true
      end
    end
    render :action => "login", :layout => "blank"
  end

  def logout
    session.destroy
    redirect_to root_path
  end

  def register
    @registrado = false
    if request.post?
      status_registro = Usuario.register(params);
      if status_registro == Usuario::STATUS_JA_CADASTRADO
        link = view_context.link_to "aqui", login_path
        flash.now[:info] = "Usuário já cadastrado, para entrar clique #{link}"
      elsif status_registro == Usuario::STATUS_AGUARDANDO_CONFIRMACAO
        link = view_context.link_to "aqui", register_path("email" => params[:email])
        flash.now[:info] = "Já existe uma solicitação para esse usuário. Verifique o seu email. Ou clique #{link} para reenviar o email"
      elsif status_registro == Usuario::STATUS_ERRO_AO_CADASTRAR
        flash.now[:danger] = "Erro ao cadastrar usuário"
      elsif status_registro == Usuario::STATUS_CADASTRADO_COM_SUCESSO
        user = Usuario.load(params)
        if user.email_confirmacao_cadastro
          @registrado = true
        end
      end
    elsif request.get?
      if params[:email]
        user = Usuario.load(params)
        if user.email_confirmacao_cadastro
          flash.now[:info] = "Email de confirmação de cadastro enviado para o seu email"
        else
          flash.now[:warning] = "Não foi possivel enviar o email de confirmação de cadastro. Você não possui confirmação pendente."
        end
      end
    end
    render :action => "register", :layout => "blank"
  end
  
  def confirmacao_cadastro
    @dados = {"email" => params[:email], "token" => params[:token]}
    if request.post?
      user = Usuario.load({:email => params[:email]})
      if user.token_email == params[:token]
        user.senha = params[:senha]
        user.token_email = nil
        if user.save
          session[:user_id] = user._id
          redirect_to home_path
          return true
        else
          flash.now[:danger] = "Erro ao confirmar usuario. Tente mais tarde."
        end
      else
        flash.now[:danger] = "Token inválido."
      end
    end
    render :action => "confirmacao_cadastro", :layout => "blank"
  end

  def profile
    
  end
  
  def mudar_senha_ajax
    render json: {status: "OK"}
  end
  
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario was successfully created.' }
        format.json { render action: 'show', status: :created, location: @usuario }
      else
        format.html { render action: 'new' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_usuario
    @usuario = Usuario.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def usuario_params
    params.require(:usuario).permit(:nome, :senha, :email)
  end
end
