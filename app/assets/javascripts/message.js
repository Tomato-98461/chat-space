$(function(){
  function buildMessage(message) {
    let image = "";
    if(message.image.url != null){
      image = `<div class="contents__messages__box__image">
                <img src="${message.image.url}">
              </div>`
    };
    let html = `<div class="contents__messages__box" data-id="${message.id}">
                  <div class="contents__messages__box__user">
                    ${message.user_name}
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
    let formData = new FormData(this);
    let url = $(this).attr('action')
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

  function  appendUser(user){
    let html = `
              <div class="chat-group-user clearfix">
                <p class="chat-group-user__name">${user.user_name}</p>
                <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.user_name}">追加</div>
              </div>
              `
    $("#user-search-result").append(html);
  };

  function  userZero(msg){
    let html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${msg}</p>
                </div>`
    $("#user-search-result").append(html);
  };

  function  addGroupUser(name,user_id){
    let html = `
            <div class='chat-group-user'>
              <input name='group[user_ids][]' type='hidden' value='${user_id}'>
              <div class='chat-group-user__name'>${name}</div>
              <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
            </div>
            `
    $('#user-select-list').append(html)
  };

  
  $("#user-search-field").on("keyup", function() {
    let select_ids = [];
    let input = $("#user-search-field").val();
    $('input[name="group[user_ids][]"]').each(function(){
      select_ids.push($(this).prop('value'));
    });
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input, user_ids: select_ids},
      dataType: 'json'
    })
    .done(function(users) {
      $("#user-search-result").empty();
      if (users.length !== 0 && input.length != 0) {
        users.forEach(function(user){
          appendUser(user);
        });
      }
      else{
        userZero("ユーザーが見つかりません");
      }
    })
    .fail(function() {
      alert("ユーザー検索に失敗しました");
    })
  })

  $("#user-search-result").on("click", '.chat-group-user__btn--add', function() {
    let id = $(this).attr('data-user-id');
    let name = $(this).siblings('.chat-group-user__name').text();
    addGroupUser(name, id);
    $(this).parent().remove();
  })
  $("#user-select-list").on("click", '.js-remove-btn', function() {
    $(this).parent().remove();
  })

  let reloadMessages = function() {
    let last_message_id = $(".contents__messages__box:last").data('id');
    if ($(".contents__messages").length !== 0) {
      $.ajax({
        url: 'api/messages',
        type: 'get',
        dataType: 'json',
        data: {id: last_message_id}
      })
      .done(function(messages){
        let insertHTML = "";
        $.each(messages, function(i,message) {
          insertHTML = buildMessage(message);
          $('.contents__messages').append(insertHTML);
          $('html').animate({ scrollTop: $('.contents__messages')[0].scrollHeight },"fast");
        });
      })
      .fail(function() {
        alert('自動更新が行われませんでした。');
      });
    }
  };

  setInterval(reloadMessages, 5000);
});
