$(document).ready(function() {
  $('form').on('submit', function(event){
     event.preventDefault();
     
   
     var url = "/tweet";
     var data = $(this).serialize();
     
     $.post(url,data,function(response){
     // console.log(response)
     $.get("/status/"+ response,function(job_status){
        console.log(job_status)
        setTimeout(function(){
          if(job_status.status == true){
            alert("Your tweet went through");
          }else if(job_status.status == false){
            alert("false");
          }
        },10000);


     },"json");
     // $(this).append(response);
     


     })
  });
});


