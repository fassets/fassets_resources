$(document).ready(function(){
  $(".asset").mouseenter(function(event){
    $(this).find(".asset_actions").show("slide", { direction: "left" }, 300);
  });
  $(".asset").mouseleave(function(event){
    $(this).find(".asset_actions").hide("slide", { direction: "left" }, 300);
  });  
});
