$(document).ready(function(){
  $('#tray ol').sortable({
    items: 'li',
    connectWith: "ul",
    update: function(ev, ui){
      $.ajax({
        type: 'put',
        data: $('.sortable_tray').sortable('serialize')+"&asset_id="+$(ui.item).data("asset-id"),
             dataType: 'script',
             complete: function(request){
               window.location.reload();
               $('#tray').effect('highlight',{},2000);
             },
             url: "/" + $('.sortable_tray').attr('id').replace(/\./g,"/")})
    },
  });
  $('#tray .drop_button').live("click",function(event){
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
