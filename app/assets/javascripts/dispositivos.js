
$(document).ready(function () {
    $('.btnDesbloquear').click(function () {
        var oThis = this;
        $.ajax({
            type: "post",
            url: url_desbloquear,
            data: {
                uuid: $(this).attr("uuid"),
                status: $(this).attr("status"),
            },
            success: function(data) {
                if (data.status == "OK") {
                    $(oThis).attr("status", data.bloqueio);
                    if (data.bloqueio == 'LIBERADO') {
                        $(oThis).html('Bloquear');
                    } else {
                        $(oThis).html('Desbloquear');
                    }
                    
                    var card = $(oThis).parent().parent().parent();
                    card.find('.labelStatus').html(data.bloqueio);
                    card.find('.box-header').removeClass('liberado').removeClass('bloqueado').addClass(data.bloqueio.toLowerCase());
                }
            },
            error: function(xhr, textError, errorThrown) {
                alert('Deu algum problema. Agora chora!! rs');
            }
        });
        
    });
});
