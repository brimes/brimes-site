$(document).ready(function() {
    $('#mudarSenha').click(function () {
        if ($('#nova_senha').val() != $('#confirmacao').val()) {
            alert('A nova senha não está igual a confirmação.');
        }
        $.ajax({
            type: "post",
            url: url_mudar_senha,
            data: {
                senha_atual: $('#senha_atual').val(),
                nova_senha: $('#nova_senha').val()
            },
            success: function(data) {
                if (data.status == "OK") {
                    alert('Senha alterada!');
                    $('#modalMudarSenha').modal('hide');
                }
            },
            error: function(xhr, textError, errorThrown) {
                alert('Ops! Deu ruim! Verifique se digitou a senha correta.');
            }
        });
    });
});