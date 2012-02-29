$(document).ready(function(){ 
  $('#tray ol').sortable({
    items: 'li',
    connectWith: "ul",
    update: function(ev, ui){
      $.ajax({
        type: 'put',
        data: $('.sortable_tray').sortable('serialize')+"&asset_id="+$(ui.item).attr("asset_id"),
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
    var user_id = $(event.target).attr("user_id");
    var tp_id = $(event.target).attr("tp_id");
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
