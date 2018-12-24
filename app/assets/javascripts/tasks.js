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

document.addEventListener("turbolinks:load", function () {

  $("#tasks-2").sortable(
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

document.addEventListener("turbolinks:load", function () {

  $("#tasks-3").sortable(
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

$(".alert").alert()
// $(function() {
//   $('.sortable').railsSortable();
// });
