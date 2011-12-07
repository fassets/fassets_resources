$(document).ready(function(){
  $(".asset_content").mouseenter(function(event){
    $(".asset_actions").css("display","none");
    $(this).parent().find(".asset_actions").show("slide", { direction: "left" }, 300);
  });
  $(".asset_actions").mouseleave(function(event){
    $(this).find(".asset_actions").hide("slide", { direction: "left" }, 300);
  });
  $(".asset").mouseleave(function(event){
    $(this).find(".asset_actions").hide("slide", { direction: "left" }, 300);
  });  
});
