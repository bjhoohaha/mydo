function make_id_sortable (id) {
  document.addEventListener("turbolinks:load", function () {

    $(id).sortable(
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
  });
};

make_id_sortable("#tasks");
make_id_sortable("#tasks-2");
make_id_sortable("#tasks-3");

$(document).on("turbolinks:load", function(){
  $(".color_picker").paletteColorPicker(

  );
  $('.datepicker').datepicker({
                    locale: 'ru',
                    dateFormat: "yy-mm-dd"
                });
  // You can use something like...
  // $('[data-palette]').paletteColorPicker();
});

$(document).on("turbolinks:load", function(){
  //show alert for task deleted
  $("a.link-delete").on( "ajax:success", function (event){
    alert("Task deleted.");
  });

  //change color
  $("a.bookmark").click(function (){
      var row = $(this).parent().parent();
      var current_color = row.css("background-color");
      //lert(current_color);
      if(current_color !==  "rgb(255, 255, 255)") {
        row.css("background-color", "rgb(255, 255, 255)");
      } else{
        row.css("background-color", "rgb(255, 214, 98)");
      }
  });
  $("a.bookmark").on( "ajax:success", function (event) {
    console.log("color is changed to " + $(this).parent().parent().css("background-color"));
  });
  //display message for success
});
