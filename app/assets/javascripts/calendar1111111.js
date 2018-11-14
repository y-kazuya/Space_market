$(document).on('turbolinks:load', function(){

  var now_reses = []
  var total_price = 0
  function set_cost_price(cost){
    total_price = cost
    $(".cost_pay").empty()
    var html = `<div class="cost_pay__date">¥${cost}</div>`

    $(".cost_pay").append(html);
  }

  function set_plan(plan_id) {
    $.ajax({
      url: '/events/plan.json',
      type: "GET",
      data: {plan_id: plan_id},
      dataType: 'json',
    })
    .done(function(plan){
      $(".res").remove()
      $(".res_date").remove()
      $(".option_check").find("input").prop("checked", false)
      $(".total_date").text("0")
      $(".p--n").text(`${plan.name}`)
      $(".p--p").text(`${plan.name} (¥${plan.day_price})`)

      if (!(plan.cost == null)){
        set_cost_price(plan.cost)
        $(".total_date").text(`${plan.cost}`)
      }
      else{
        set_cost_price(0)
      }

    })
    .fail(function() {
    });


  }

  function create_reserve(day){
    var count = $(".res").length + 1
    var html = `<div class="${day} res">
        <input type="hidden" value="${day}" name="reserve[reserve_dates_attributes][${count}][start_date]" id="reserve_reserve_dates_attributes_${count}_start_date">
        <input type="hidden" value="true" name="reserve[reserve_dates_attributes][${count}][day]" id="reserve_reserve_dates_attributes_${count}_day">
        <input type="hidden" value="0" name="reserve[reserve_dates_attributes][${count}][start_time]" id="reserve_reserve_dates_attributes_${count}_start_time">
        <input type="hidden" value="24" name="reserve[reserve_dates_attributes][${count}][end_time]" id="reserve_reserve_dates_attributes_${count}_end_time">
      </div>`

    return html
  }

  function create_reserve_day(day, br){
    var count = $(".res").length + 1
    if (count % br == 0){
      var set = "<br>"
    }
    else{
      var set = "、"
    }
    var re = /-/g;
    var result = day.replace(re, "/");
    var html3 = `<span class="${day} res_date">${result}${set}</span>`

    return html3

  }


  function select_day(event, jsEvent, view){ //イベントクリックの際の挙動
    // change the border color just for fun
    $(this).css('border-color', 'red');
    $(".d-s").css("display", "block")
    var day = event.start._i
    var day_s = String(day)
    $(".need_re").css("display", "block")
    var target = $(`[data-date=${day_s}]`)
    var pay = event.title.match(/\d+/)[0]
    $(".okioki").css("display", "none")

    $(".vm").css("display", "block")
    $(".vm").find("span").text("利用者区分を選択してください")


    if (!$(target[0]).hasClass("selected_day")){
      $(jsEvent.currentTarget).addClass("selected_day")
      $(target[0]).addClass("selected_day")
      var target = $(".reserve_dates");
      var html = create_reserve(day)
      var html2 = create_reserve_day(day, 2)
      var html3 = create_reserve_day(day, 4)
      target.prepend(html);
      $(".long_date").append(html2)
      $(".long_date_2").append(html3)
      now_reses.push(day)
      gtotal_price(pay)


    }
    else{
      $(target[0]).removeClass("selected_day")
      $(jsEvent.currentTarget).removeClass("selected_day")
      $(`.${day}`).remove()
      dtotal_price(pay)

      var idx = now_reses.indexOf(day);
      if(idx >= 0){
        now_reses.splice(idx, 1);
      }
    }


  }

  function over_day(calEvent, jsEvent, view){

    var day = calEvent.start._i
    var day = String(day)
    var target = $(`[data-date=${day}]`)
    if  (!$(target[0]).hasClass("selected_day")){
      $(jsEvent.currentTarget).addClass("m_over")
      $(target[0]).addClass("m_over")
    }
  }

  function out_day(calEvent, jsEvent, view){

    var day = calEvent.start._i
    var day = String(day)
    var target = $(`[data-date=${day}]`)
    $(jsEvent.currentTarget).removeClass("m_over")
    $(target[0]).removeClass("m_over")
  }





  function aaa(){
    $(document).on({
      "mouseenter": function(){

      },
      "mouseleave": function(){

      }
      }, ".can_reserve");

  }




  function yesyes(room_id, plan_id, day = 0) {$('#calendar').fullCalendar({ //カレンダーの表示

    events: { //貸し出せるひを取得

      url: '/events.json',
      type: 'GET',
      data: {
        room_id: room_id,
        plan_id: plan_id,
        day: day,

      },
      success: function(){

      },
      error: function() {
        alert('there was an error while fetching events!');
      },
    },

    eventRender: function (event, element, view) {

      if (view.title.length == 9) {
        var view_m = Number(view.title.slice(5, 8))
      }
      else{
        var view_m = Number(view.title.slice(5, 7))
      }

      if (event.title.match(/\d/) != null){
        var day = event.start._i
        var day = String(day)
        var target = $(`[data-date=${day}]`)

        $(target[0]).addClass("can_reserve_day")

        $(".fc-event-container").find("can_reserve")
        if(now_reses.indexOf(day) >= 0){
          $(event.currentTarget).addClass("selected_day")
          $(target[0]).addClass("selected_day")
          $(element[0]).addClass("selected_day")

        };
      }

      if (Number(event.start._i.slice(5, 7)) !=  view_m) {
         return false;
      }

    },


    header: {
      left: 'prev',
      center: 'title',
      right: 'next',
    },
    // selectable: true,
    // selectHelper: true,

    Boolean, default: true,
    showNonCurrentDates: true,
    fixedWeekCount: false,


    // select: function(data) { //日付がクリックされた時の日付データを取得
    //   var str = moment(data).format( 'YYYYMMDD' );
    //

    eventClick: function(calEvent, jsEvent, view) {
      select_day(calEvent, jsEvent, view)

    },

    eventMouseover: function(calEvent, jsEvent, view) {
      over_day(calEvent, jsEvent, view)

    },

    eventMouseout: function(calEvent, jsEvent, view) {
      out_day(calEvent, jsEvent, view)

    },

  })}

  if (location.pathname.includes('reservations')) { ///ページ遷移際の挙動


    var room_id =  $(".room_id").text()
    var plan_id = $("input[name='reserve[plan_id]']:checked").val()
    if ($(".day_pay_area").length + $(".time_pay_area").length == 2){  /// ページ遷移時＆＆プラン2個→貸しタイプ選択→ カレンダー
      set_plan(plan_id)
      $("input[name='reserve[day]']").on("click",function(){
        var day = $("input[name='reserve[day]']:checked").val()
        yesyes(room_id, plan_id, day)
        $(".step1").css("display", "block")
      })
    }
    else{
      $("input[name='reserve[day]']:eq(0)").prop('checked', true);  ///ページ遷移時＆＆プラン一個→カレンダー表示
      var day = $("input[name='reserve[day]']:checked").val()
      yesyes(room_id, plan_id, day)
      set_plan(plan_id)
      $(".step1").css("display", "block")
    }

  }

  $("input[name='reserve[plan_id]']").on("click", function(){ //プランの変更がされるたび
    $(".pay_area").empty()
    $(".d-s").css("display", "none")
    $(".okioki").css("display", "block")

    now_reses = []
    var room_id =  $(".room_id").text()
    var plan_id = $("input[name='reserve[plan_id]']:checked").val()

    var plan_time_price = $(`#plan${plan_id}`).find(".pre-time").text()
    var plan_day_price = $(`#plan${plan_id}`).find(".pre-day").text()


    //ラジオボタン差し込み///////////////////////////////////////////////////
    if(plan_time_price == ""){ //プランが時間選択・日選択できるか？ラジオボタン差し込み
      $(".time_pay_area").remove()

    }
    else{
      if($(".time_pay_area").length){
        $(".time_price").text(plan_time_price)
      }
      else{
        $(".pay_area").prepend(`<div class="reserve__next--type__wp--botan time_pay_area">
          <input type="radio" value="0" name="reserve[day]" id="reserve_day_0">
          <label for="reserve_day_0">時間価格
          <span class="time_price">
          ${plan_time_price}
          </span>
          </label></div>`)

      }
    }

    if(plan_day_price == ""){ //プランが時間選択・日選択できるか？ラジオボタン差し込み
      $(".day_pay_area").remove()

    }
    else{
      if($(".day_pay_area").length){
        $(".day_price").text(plan_day_price)
      }
      else{
        $(".pay_area").append(`<div class="reserve__next--type__wp--botan day_pay_area">
        <input type="radio" value="1" name="reserve[day]" id="reserve_day_1">
        <label for="reserve_day_1">一日価格
        <span class="day_price">
        ${plan_day_price}
        </span>
        </label></div>`)

      }
    }
    ////////////////////////////ラジオボタン差し込み（日でかすか時間か）/////////////////////




    if ($(".day_pay_area").length + $(".time_pay_area").length == 2){ //貸しタイプ２種類の時
      set_plan(plan_id)
      $(".step1").css("display", "none")
      $(".step2").css("display", "none")
      $("input[name='reserve[company]']").prop('checked', false)
      $(".calender_area").empty();
      $("input[name='reserve[day]']").prop('checked', false)
      $("input[name='reserve[day]']").on("click",function(){
        $(".okioki").css("display", "block")
        if ($("#calendar").length){
          $(".calender_area").empty();
          $(".calender_area").append(`<div id="calendar"></div>`)
          yesyes(room_id, plan_id, day)
          set_plan(plan_id)
          $(".step1").css("display", "block")
        }
        else{
          $(".calender_area").append(`<div id="calendar"></div>`)
        }
        var day = $("input[name='reserve[day]']:checked").val()
        yesyes(room_id, plan_id, day)
        set_plan(plan_id)
        $(".step1").css("display", "block")
      })
    }
    else{

      if ($("#calendar").length) {
        $("#calendar").remove()
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      else{
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      $("input[name='reserve[day]']:eq(0)").prop('checked', true);

      var day = $("input[name='reserve[day]']:checked").val()

      yesyes(room_id, plan_id, day)
      set_plan(plan_id)
      $(".step1").css("display", "block")
    }
  })

  if ($(".day_pay_area").length + $(".time_pay_area").length == 2){ //貸しタイプ２種類の時
    $(".calender_area").empty();
    $("input[name='reserve[day]']").prop('checked', false)
    plan_id = $("input[name='reserve[plan_id]']:checked").val()
    $(document).on("click","input[name='reserve[day]']",function(){
      now_reses = []
      var day = $("input[name='reserve[day]']:checked").val()
      if ($("#calendar").length){
        $(".calender_area").empty();
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      else{
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      yesyes(room_id, plan_id, day)
      $(".step1").css("display", "block")


    })
  }
  else{
    if ($("#calendar").length) {
      $("#calendar").remove()
      $(".calender_area").append(`<div id="calendar"></div>`)
    }
    else{
      $(".calender_area").append(`<div id="calendar"></div>`)
    }
    $("input[name='reserve[day]']:eq(0)").prop('checked', true);
    var day = $("input[name='reserve[day]']:checked").val()
    yesyes(room_id, plan_id, day)
    set_plan(plan_id)
    $(".step1").css("display", "block")
  }

    ///コード汚すぎいいいいいいいいいいいいいいい




    /////////合計金額計算/////////////////

    function gtotal_price(pay){ //金額あげる
      $(".total_date").empty()
      total_price = Number(total_price) + Number(pay)
      $(".total_date").append(`¥${total_price} <br> <span>(税込価格 ￥${Math.round(total_price * 1.08)})</span>`)
      var point = total_price * 0.05
      $(".poipoi").text(`${Math.round(point)}`)
    }

    function dtotal_price(pay){  //金額下げる
      $(".total_date").empty()
      total_price = Number(total_price) - Number(pay)
      if (total_price < 0 ){
        total_price = 0
      }
      $(".total_date").append(`¥${total_price} <br> <span>(税込価格 ￥${Math.round(total_price * 1.08)})</span>`)
      var point = total_price * 0.05
      $(".poipoi").text(`${Math.round(point)}`)
    }

    //オプション選択
    $(".opt").find("label").on("click", function(){

      var pay = $(this).parents(".opt").attr("id").match(/\d+/)[0]

      var op_id = $(this).prev(`input[name="reserve[option_ids][]"]:checked`).val()

      if ( op_id != undefined ){
        dtotal_price(pay)
      }
      else{
        gtotal_price(pay)
      }

    })



  $("#reserve_company_0").on("click", function(){
    $(".step2").css("display", "block")
    $(".step2-1").css("display", "none")
    $(".vm").find("span").text("決算方法を選択してください")
  })

  $("#reserve_company_1").on("click", function(){
    $(".step2").css("display", "block")
    $(".step2-1").css("display", "block")
    $(".vm").find("span").text("決算方法を選択してください")
  })

  $("input[name='reserve[payment]']").on("click", function(){
    $(".vm").css("display", "none")
  })

  var ooo = 0
  $("#nebiki").on("change", function(){
    var tota = $(".modal__sum--kikan--total").text().match(/\d+/)[0]
    var poi = $(".point_title").text().match(/\d+/)[0]
    var dpoi = Number($(this).val())



    if (dpoi > poi){
      $(this).val("");
      var pay = ooo
      ooo = 0
      gtotal_price(pay)
      // return false;
    }
    else{

      if (dpoi > ooo) {
        var pay = dpoi -ooo
        dtotal_price(pay)
      }
      else{
        var pay = ooo - dpoi
        gtotal_price(pay)
      }
    ooo = dpoi
    }
  })


//     $("#nebiki").on("keyup", function(){
//       var bbb = $(this).val()

// "
//       if (bbb > ooo) {
//         var pay = bbb -ooo
//         dtotal_price(pay)
//       }
//       else{
//         var pay = ooo - bbb
//         gtotal_price(pay)
//       }
//     })


});


