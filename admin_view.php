<html>
<head>
<title>CI Teguh21</title>
<script type="text/javascript" language="javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>


<script type="text/javascript">
$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("test_view.txt #p1");
  });
});  
</script>
</head>
<body>
<div id="div1"><h2>Let jQuery AJAX Change This Text</h2></div>
<button>Get External Content</button>

	
</body>
</html>