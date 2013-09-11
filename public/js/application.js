$(document).ready(function() {
  $('form').on('submit', function(event){
     event.preventDefault();
     
   
     var url = "/tweet";
     var data = $(this).serialize();
      console.log();
     $.post(url,data,function(response){
     $(this).append(response);
     


     })
  });
});
