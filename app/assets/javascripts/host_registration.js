$(document).on('turbolinks:load',function(){

// 画面1
  error_message_blank('#kanji_last_name_unique','#warning_hr_11');
  error_message_blank('#kanji_first_name_unique','#warning_hr_12');
  error_message_blank('#kana_last_name_unique','#warning_hr_13');
  error_message_blank('#kana_first_name_unique','#warning_hr_14');
  error_message_blank('#birth_year_unique','#warning_hr_15');
  error_message_blank('#birth_month_unique','#warning_hr_16');
  error_message_blank('#birth_day_unique','#warning_hr_17');
  error_message_blank('#phone_no_unique','#warning_hr_18');

// 画面2
  error_message_blank('#postal_cd_unique','#warning_hr_21');
  error_message_doublebyte('#postal_cd_unique','#warning_hr_22');
  error_message_blank('#ward_unique','#warning_hr_23');
  error_message_blank('#block_unique','#warning_hr_24');
  error_message_blank('#block_kana_unique','#warning_hr_25');
  error_message_blank('#street_unique','#warning_hr_26');
  error_message_blank('#street_kana_unique','#warning_hr_27');
// 画面3
  error_message_blank('#bank_nm_unique','#warning_hr_31');
  error_message_blank('#bank_cd_unique','#warning_hr_32');
  error_message_blank('#branch_nm_unique','#warning_hr_33');
  error_message_blank('#branch_cd_unique','#warning_hr_34');
  error_message_blank('#account_no_unique','#warning_hr_35');
  error_message_blank('#account_holder_name_unique','#warning_hr_36');

  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $('#add_button_unique').on('change', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#photo_wrap1_unique");
        t = this;
    var name = $('#add_button_unique')[0].files[0].name;
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

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
      };
    })(file);

    reader.readAsDataURL(file);
  });

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

});
