class DispositivosController < ApplicationController
  def index
  end
  
  def desbloquear
    dispo = current_user.dispositivos.where(:uuid => params[:uuid]).first();
    if dispo.unlock(params[:status])
      render json: {status: "OK", bloqueio: dispo.status}
    else
      render json: {status: "ERROR"}
    end
  end
end
