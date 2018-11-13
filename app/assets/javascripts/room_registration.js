$(document).on('turbolinks:load',function(){


// 画面1
  error_message_blank('#postal_cd_unique','#warning11');
  error_message_doublebyte('#postal_cd_unique','#warning12');
  error_message_blank('#ward_unique','#warning13');
  error_message_blank('#street_unique','#warning14');
  error_message_blank('#access_unique','#warning15');
  error_message_blank('#phone_no_unique','#warning16');
// 画面2
  error_message_blank('#capacity_unique','#warning21');
  error_message_blank('#area_unique','#warning22');
// 画面3
  error_message_blank('#space_title_unique','#warning31');
  error_message_blank('#space_explanation_unique','#warning32');
  error_message_blank('#facility_unique','#warning33');
// 画面4
  // $('#add_button_unique').on('click',function(){
  //   $('#photo_wrap1_unique').append("=render '/tmp/photo.html.haml'");
  // });
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('.add_button_unique').on('change', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".photo_wrap1_unique");
        t = this;
    console.log('in');
    var name = $('.add_button_unique')[0].files[0].name;
    console.log(name);
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // $("#add_button_unique").val("aaa")


    // ファイル読み込みが完了した際のイベント登録



    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();


        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  width: "150px",
                  class: "preview",
                  title: file.name
              }));


        $(".photo_wrap1").append(`<div class="photo_memo">
        <input class="input_area memo" placeholder="閑静なオフィス街にあるビル内の施設です。" type="text" name="picture[about]">
        </div>`);

      };
    })(file);

    reader.readAsDataURL(file);
  });


// 画面5

  error_message_blank('#plan_name_unique','#warning51');

  $('#price_hour_unique').on('keyup',function(){
    if($(this).val().length===0 || $('#price_day_unique').val()===0){
      $('#warning52').css('display', 'block');
    } else {
      $('#warning52').css('display', 'none');
    }
  });
  $('#price_day_unique').on('keyup',function(){
    if($(this).val().length===0 || $('#price_hour_unique').val()===0){
      $('#warning52').css('display', 'block');
    } else {
      $('#warning52').css('display', 'none');
    }
  });

  $('#price_hour_unique').on('keyup',function(){
    if($(this).val().match(/^\d+$/) && $('#price_day_unique').val().match(/^\d+$/)){
      $('#warning53').css('display', 'none');
    } else {
      $('#warning53').css('display', 'block');
    }
  });

  $('#price_day_unique').on('keyup',function(){
    if($(this).val().match(/^\d+$/) && $('#price_hour_unique').val().match(/^\d+$/)){
      $('#warning53').css('display', 'none');
    } else {
      $('#warning53').css('display', 'block');
    }
  });

  slidebar_controll('#slide_hour_price');
  slidebar_controll('.slide');

  show_hide('.set_all.fas.fa-angle-down','.set_all_view')

// 共通


// 表示・非表示
  function show_hide(s,m){
    $(s).on('click',function(){
      if($(m).css('display')=='block'){
        $(m).css('display', 'none');
      } else {
        $(m).css('display', 'block');
      }
    });
  }

  //入力チェック
  function error_message_blank(s,m){
    $(s).on('keyup',function(){
      if($(this).val().length===0){
        $(m).css('display', 'block');
      } else {
        $(m).css('display', 'none');
      }
    });
  }

  //半角数字チェック
  function error_message_doublebyte(s,m){
    $(s).on('keyup',function(){
      if($(this).val().match(/^\d+$/)){
        $(m).css('display', 'none');
      } else {
        $(m).css('display', 'block');
      }
    });
  }

  //スライドバーのコントロール
  function slidebar_controll(s){
    $(s).change(function(){
      if($(this).find('.slide_value').val()=='0'){
        $(this).find('.slide_name').css('color', '#60df52');
        $(this).find('.slide_name').text('設定中');
      } else {
        $(this).find('.slide_value').toggleClass('.slide_value_g');
        $(this).find('.slide_name').css('color','gray');
        $(this).find('.slide_name').text('未設定');
      }
    });
  }

  $('house').on('click',function(){
    drawMap();
  });


  ///////////////法人の入力出したり消したり///////////
  if (location.pathname.includes('settings/host_profiles')) { ///ページ遷移際の挙動
    var target = $("input[name='host_profile[company]']:checked")[0].value
    console.log(target)

    if (target == "true") {
      $(".y-com-wp").css("display", "block")
    }
   }

   $("input[name='host_profile[company]']").on("click", function(){ //法人のの変更がされるたび
    var target = $(this)[0].value
    console.log(String(target))

    if (target == "true") {
      $(".y-com-wp").css("display", "block")
    }
    else{
      $(".y-com-wp").css("display", "none")
    }

   })






});
