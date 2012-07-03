$(document).ready(function(){
  $(".asset").live("mouseenter",function(event){
    $(this).find(".asset_actions").fadeIn(150);
  });
  $(".asset").live("mouseleave",function(event){
    $(this).find(".asset_actions").fadeOut(100);
  });
  $(".put_on_tray_button").live("click", function(event){
    event.preventDefault();
    var user_id = $(event.target).data("user-id");
    var asset_id = $(event.target).data("asset-id");
    data = {tray_position: {asset_id: asset_id, user_id: user_id}};
    $.post("/users/"+user_id+"/tray_positions",data, function(){
      $("#tray").load("/users/"+user_id+"/tray_positions/", function() {
        $('#tray .drop_button').click(function(event){
          event.preventDefault();
          var user_id = $(event.target).data("user-id");
          var tp_id = $(event.target).data("tp-id");
          $.ajax({
            type: 'DELETE',
            cache	: false,
            url		: "/users/"+user_id+"/tray_positions/"+tp_id,
            success: function(data) {
              $("#tray").load("/users/"+user_id+"/tray_positions/");
            }
          });
        });
      });
    });
  });
});
