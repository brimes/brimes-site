json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :nome, :senha, :email
  json.url usuario_url(usuario, format: :json)
end
