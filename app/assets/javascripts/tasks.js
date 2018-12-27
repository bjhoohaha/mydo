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
  // You can use something like...
  // $('[data-palette]').paletteColorPicker();
});
