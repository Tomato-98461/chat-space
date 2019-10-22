$(function(){
  function buildMessage(message) {
    var image = "";
    if(message.image.url != null){
      image = `<div class="contents__messages__box__image">
                <img src="${message.image.url}">
              </div>`
    };
    var html = `<div class="contents__messages__box">
                  <div class="contents__messages__box__user">
                    ${message.user}
                  </div>
                  <div class="contents__messages__box__date">
                    ${message.created_at}
                  </div>
                  <div class="contents__messages__box__text">
                    ${message.message}
                  </div>
                    ${image}
                </div>`
    return html;
  }
  $('.new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      var html = buildMessage(message);
      $('.contents__messages').append(html);
      $('html').animate({scrollTop: $('.contents__messages')[0].scrollHeight},"fast");
      $('.new_message')[0].reset();
    })
    .fail(function(){
      alert("メッセージの投稿に失敗しました。")
    })
    .always(function(){
      $('.contents__post__input--submit').removeAttr("disabled");
    });
  })
})