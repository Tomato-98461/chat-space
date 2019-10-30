$(function(){
  let now = new Date();
  let two_hour_ago = new Date();
  two_hour_ago.setHours(now.getHours() -2);

  let getTime = $(".contents__messages__box__date").last().text().replace(/\r?\n/g, '').
                                                                  replace('年',"/").
                                                                  replace('月',"/").
                                                                  replace('日',"/").
                                                                  replace('時',":").
                                                                  replace('分',":").
                                                                  replace('秒',"");
  let lastPostTime = new Date(getTime);
  if (lastPostTime > two_hour_ago) {
    $(".contents__messages__box:last").css({'animation-name': 'fadein',  'animation-duration': '2s'});
  }
});