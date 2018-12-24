
document.addEventListener("turbolinks:load", function () {

  $("#tasks").sortable(
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



// $(function() {
//   $('.sortable').railsSortable();
// });
