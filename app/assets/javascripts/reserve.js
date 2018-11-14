
$(document).on('turbolinks:load', function(){
  var setBoxId = '.sp';      // スクロールさせる要素
  var initOffsetTop = null;   // 要素の初期位置
  var maxHeight= $(".reserve--wp").outerHeight(true) - $(".reserve__left").outerHeight();

  initOffsetTop = $(setBoxId).offset().top;
  var minHeight = initOffsetTop  + 5

  $(document).on("click", function(){
     maxHeight = $(".reserve--wp").outerHeight(true) - $(".reserve__left").outerHeight();
  })

  $(window).scroll(function() {
    scrollbox(maxHeight);
  });


  function scrollbox(mh){
    // 初期位置が取れていなければ処理を抜ける

    if(initOffsetTop == null) return;

    // 現在のスクロール位置を取得
    var scrollTop = $(document).scrollTop();


    if(initOffsetTop < scrollTop) {

      if (scrollTop > mh){ //範囲を超えたスクローrる

        $(setBoxId).addClass('fix')
        $(setBoxId).removeClass('start')
      }
      else if(scrollTop < minHeight){
        $(setBoxId).removeClass('start')
        $(setBoxId).removeClass('fix')
      }
      else{
        $(setBoxId).addClass('start')
        $(setBoxId).removeClass('fix')
      }
    }
  }



  $(".modalOpen").click(function(){
    console.log("aaa")
    var navClass = $(this).attr("class"),
    href = $(this).attr("href");

    $(href).fadeIn();
    $(this).addClass("open");
    //cssアニメーションの記述を追加する
    $(href).children(".inner").css("animation","modal 0.5s forwards");
    $("body").css("overflow", "hidden")
    return false;

});

$(".modalClose").click(function(){

      $(this).parents(".modal").fadeOut();
      $(".modalOpen").removeClass("open");
     //cssアニメーションの記述を追加する
      $(this).parents(".modal").children(".inner").css("animation","modalClose 0.5s forwards");
      $("body").css("overflow", "scroll")
      return false;

});


})
