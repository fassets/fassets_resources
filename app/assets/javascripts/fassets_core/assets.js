$(document).ready(function(){
  $(".asset_content").mouseenter(function(event){
    $(".asset_actions").css("display","none");
    $(this).parent().find(".asset_actions").css("display","inline");
  });
  $(".asset_actions").mouseleave(function(event){
    $(this).parent().find(".asset_actions").css("display","none");
  });
  $(".asset").mouseleave(function(event){
    $(this).parent().find(".asset_actions").css("display","none");
  });  
});
