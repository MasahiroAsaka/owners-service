$(document).on('turbolinks:load',function(){

  var form = $("#getTokenForm"),
      number = form.find('input[name="cardno"]'),
      cvc = form.find('input[name="securitycode"]'),
      exp_month = form.find('select[name="expire_month"]'),
      exp_year = form.find('select[name="expire_year"]');

  $("#getTokenForm").submit(function(e) {
    e.preventDefault();
    Payjp.setPublicKey('pk_test_d7d23b2f6cc64e5d374505eb');

    form.find("button[type=submit]").prop("disabled", true);

    var card = {
        number: number[0].value,
        cvc: cvc[0].value,
        exp_month: exp_month[0].value,
        exp_year: exp_year[0].value
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }
      else{
        $.ajax({
          url: "/plans/pay",
          type: "GET",
          data: {token: response.id,
                 number: card.number,
                 cvc: card.cvc,
                 exp_month: card.exp_month,
                 exp_year: card.exp_year},
          datatype: "json",
          success: function(data){
            //成功時の処理
            console.log('Success!');
            $("#cardno").removeAttr("name");
            $("#securitycode").removeAttr("name");
            $("#expire_month").removeAttr("name");
            $("#expire_year").removeAttr("name");
            window.location.href = '/orders/purchase/confirming/118';
          },
          error: function(data){
            //失敗時の処理
            console.log('Error');
          }
        })
      }
    });
  });
});
