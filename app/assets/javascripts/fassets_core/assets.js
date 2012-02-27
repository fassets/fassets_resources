$(document).ready(function(){
  $(".asset").mouseenter(function(event){
    $(this).find(".asset_actions").fadeIn(150);
  });
  $(".asset").mouseleave(function(event){
    $(this).find(".asset_actions").fadeOut(100);
  });  
});
