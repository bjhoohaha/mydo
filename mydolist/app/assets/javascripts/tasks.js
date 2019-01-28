document.addEventListener("turbolinks:load", function () {

  function make_id_sortable(id) {
    $("#" + id).sortable(
      {
      update: function(e, ui) {
        //console.log($(this).sortable('serialize'));
        Rails.ajax({
          url: $(this).data("url"),
          type: "PATCH",
          data: $(this).sortable('serialize'),
        });
      }
      }
    );
  }

  //make ids sortable in active tasks page
  const sortable_ids = ["sortable-in-progress", "sortable-awaiting-reply", "sortable-pending"];
  for(let i = 0; i < sortable_ids.length; i = i + 1){
    make_id_sortable(sortable_ids[i]);
  }

});

$(document).on("turbolinks:load", function(){
  console.log("Page is loaded");

  $(".datepicker").datepicker({
    locale: 'ru',
    dateFormat: "yy-mm-dd"
  });

  $(".color_picker").paletteColorPicker(

  );
  $('.datepicker').datepicker({
    locale: 'ru',
    dateFormat: "yy-mm-dd"
  });

  function load_alerts () {

    function display_success_alert(id, msg) {
      if($("#" + id).children().length === 0) {
        $("#" + id).append("<div class = alert_container><div class = alert-my>" + msg + "</div></div>");
      } else {

      }
    }

    function display_no_tasks_due() {
      if($("#time-alert").children().length === 0) {
        $("#time-alert").append("<h1>No Tasks Due</h1><br></br>");
        $("#time-alert").append("<div class = alert_container><div class = alert-w>There are no <strong>Active Tasks Due</strong></div></div>");
      } else {

      }
    }

    function display_warning_alert(id, msg) {
      if($("#" + id).find(".row").length === 0) {
        $("#" + id).append("<div class = alert_container><div class = alert-w>" + msg + "</div></div>");
      } else {

      }
    }
    display_success_alert("sortable-in-progress", "There are no tasks <strong>In Progress</strong>");
    display_success_alert("sortable-awaiting-reply", "There are no tasks <strong>Awaiting Reply</strong>");
    display_success_alert("sortable-pending", "There are no tasks <strong>Pending</strong>");
    display_no_tasks_due();
    display_warning_alert("completed-page", "There are no <strong>Completed</strong> tasks");
    display_warning_alert("all-task", "There are no <strong>Tasks</strong>");
  };
  load_alerts();

  //change color
  $("a.bookmark").click(function (){
      var row = $(this).parent().parent();
      var current_color = row.css("background-color");
      //alert(current_color);
      if(current_color !==  "rgb(255, 255, 255)") {
        row.css("background-color", "rgb(255, 255, 255)");
      } else{
        row.css("background-color", "rgb(255, 214, 98)");
      }
  });

  //log color change success!
  $("a.bookmark").on( "ajax:success", function (event) {
    console.log("color is changed to " + $(this).parent().parent().css("background-color"));
  });

  //delete
  $("a.link-delete").on( "ajax:success", function (event){
    alert("Task deleted.");
    $(this).closest(".row").remove();
    load_alerts();
  });

  function remove_time() {
     function remove_id(id){
       if($("#" + id).children().length === 5) {
         $("#" + id).remove();
       } else{

       }
     }

    const time_array = ["overdue", "today", "tomorrow", "week", "month", "upcoming", "no-deadlines"];
    for(let i = 0; i < time_array.length; i = i + 1) {
      remove_id(time_array[i]);
    }
  }

  $("#time-button").on("ajax:success",function (){
    if($(".show-time").css("display") === "none") {
      $(".show-time").show();
    } else{
      $(".show-time").css("display", "none");
    }
  });

  $("button.close").click(function () {
    $('.alert_container').remove();
  });
});

var addalert = "<div class = 'alert_container'><div class = 'alert alert-danger'><p><strong>Error: </strong>No tasks selected<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></p></div></div>";

document.addEventListener("change",function () {

  var url = location.pathname;
  if(url === "/tasks/destroy_multiple" || url === "/tasks/delete_tasks") {
    if($('input[name="t[]"]:checked').length === 0) {
      $('#no-checkbox-error').prepend(addalert);
    } else{
      $('.alert_container').remove();
    }
  } else{

  }
});
