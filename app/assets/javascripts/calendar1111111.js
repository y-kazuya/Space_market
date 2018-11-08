$(document).on('turbolinks:load', function(){

  function total_price(pay){

  }

  function set_cost_price(cost){
    $(".cost_pay").empty()
    var html = `<div class="cost_pay__title">管理維持ひ</div><div class="cost_pay__date">${cost}</div>`

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
      console.log(plan.cost == null)

      if (!(plan.cost == null)){
        set_cost_price(plan.cost)
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
    console.log($(".res").length)
    return html
  }

  function create_reserve_day(day){
    var re = /-/g;
    var result = day.replace(re, "/");
    var html2 = `<div class="${day}" class="res_date">${result}</div>`

    return html2

  }


  function select_day(event, jsEvent, view){ //イベントクリックの際の挙動
    // change the border color just for fun
    $(this).css('border-color', 'red');
    var day = event.start._i
    var day_s = String(day)
    $(".need_re").css("display", "block")
    var target = $(`[data-date=${day_s}]`)

    if (!$(target[0]).hasClass("selected_day")){
      $(jsEvent.currentTarget).addClass("selected_day")
      $(target[0]).addClass("selected_day")
      var target = $(".reserve_dates");
      var html = create_reserve(day)
      var html2 = create_reserve_day(day)
      target.prepend(html);
      $(".long_date").append(html2)

    }
    else{
      $(target[0]).removeClass("selected_day")
      $(jsEvent.currentTarget).removeClass("selected_day")
      $(`.${day}`).remove()
      console.log("aaaaaaaa")
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
    console.log(view)
    var day = calEvent.start._i
    var day = String(day)
    var target = $(`[data-date=${day}]`)
    $(jsEvent.currentTarget).removeClass("m_over")
    $(target[0]).removeClass("m_over")
  }





  function aaa(){
    $(document).on({
      "mouseenter": function(){
        console.log(this)
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
    //   console.log(str);},

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
      $("input[name='reserve[day]']").on("click",function(){
        var day = $("input[name='reserve[day]']:checked").val()
        yesyes(room_id, plan_id, day)
        set_plan(plan_id)
      })
    }
    else{
      $("input[name='reserve[day]']:eq(0)").prop('checked', true);  ///ページ遷移時＆＆プラン一個→カレンダー表示
      var day = $("input[name='reserve[day]']:checked").val()
      yesyes(room_id, plan_id, day)
      set_plan(plan_id)
    }

  }

  $("input[name='reserve[plan_id]']").on("click", function(){ //プランの変更がされるたび
    var room_id =  $(".room_id").text()
    var plan_id = $("input[name='reserve[plan_id]']:checked").val()

    var plan_time_price = $(`#plan${plan_id}`).find(".preview_time_price").text()
    var plan_day_price = $(`#plan${plan_id}`).find(".preview_day_price").text()


    //ラジオボタン差し込み///////////////////////////////////////////////////
    if(plan_time_price == "\n\n"){ //プランが時間選択・日選択できるか？ラジオボタン差し込み
      $(".time_pay_area").remove()
    }
    else{
      if($(".time_pay_area").length){
        $(".time_price").text(plan_time_price)
      }
      else{
        $(".pay_area").prepend(`<div class="time_pay_area">
          <div class="pay_type_time">
          時間貸し
          <input type="radio" value="0" name="reserve[day]" id="reserve_day_0">
          </div>
          <div class="time_price">
          ${plan_time_price}
          </div>
          </div>`)

      }
    }

    if(plan_day_price == "\n\n"){ //プランが時間選択・日選択できるか？ラジオボタン差し込み
      $(".day_pay_area").remove()
    }
    else{
      if($(".day_pay_area").length){
        $(".day_price").text(plan_day_price)
      }
      else{
        $(".pay_area").append(`<div class="day_pay_area">
          <div class="pay_type_day">
          日貸し
          <input type="radio" value="1" name="reserve[day]" id="reserve_day_1">
          </div>
          <div class="day_price">
          ${plan_day_price}
          </div>
          </div>`)

      }
    }
    ////////////////////////////ラジオボタン差し込み（日でかすか時間か）/////////////////////




    if ($(".day_pay_area").length + $(".time_pay_area").length == 2){ //貸しタイプ２種類の時
      $(".calender_area").empty();
      $("input[name='reserve[day]']").prop('checked', false)
      $("input[name='reserve[day]']").on("click",function(){
        if ($("#calendar").length){
          $(".calender_area").empty();
          $(".calender_area").append(`<div id="calendar"></div>`)
          yesyes(room_id, plan_id, day)
          set_plan(plan_id)
        }
        else{
          $(".calender_area").append(`<div id="calendar"></div>`)
        }
        var day = $("input[name='reserve[day]']:checked").val()
        yesyes(room_id, plan_id, day)
        set_plan(plan_id)
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
    }
  })

  if ($(".day_pay_area").length + $(".time_pay_area").length == 2){ //貸しタイプ２種類の時
    $(".calender_area").empty();
    $("input[name='reserve[day]']").prop('checked', false)
    $(document).on("click","input[name='reserve[day]']",function(){
      var day = $("input[name='reserve[day]']:checked").val()
      if ($("#calendar").length){
        $(".calender_area").empty();
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      else{
        $(".calender_area").append(`<div id="calendar"></div>`)
      }
      yesyes(room_id, plan_id, day)
      set_plan(plan_id)
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
  }

    ///コード汚すぎいいいいいいいいいいいいいいい


});


