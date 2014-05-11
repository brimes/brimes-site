$(document).ready(function() {
    $('#mudarSenha').click(function () {
        $.ajax({
            type: "post",
            url: url_mudar_senha,
            data: {
                senha_atual: $('#senha_atual').val(),
                nova_senha: $('#nova_senha').val()
            },
            success: function(data) {
                alert(data);
            },
            error: function(xhr, textError, errorThrown) {
                alert('Error');
            }
        });
    });
});