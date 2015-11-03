<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<style>
		html {
			font-size: 10px;
		}


		.cont {
			padding: 10px;
			border-radius: 5px;
			border: 1px solid #999;
			margin-top: 10px;
		}

		.btn {
			-webkit-tap-highlight-color: transparent;
			display: inline-block;
			font-size: 12px;
			background-color: #399;
			color: #FFF;
			border-radius: 3px;
			text-decoration: none;
			padding: 7px 30px;
		}
		.btn:hover {
			background-color: #388;
		}

		/**
		 * em demo
		 */
		/*body {
			font-size: 62.5%;
		}
		.cont {
			font-size: 1.2em;
			color: #999;
		}
		.cont2 {
			font-size: 1.2em;
			color: #999;
		}
		.txt {
			/*font-size: 1.2em;*/
		}*/
	</style>
</head>
<body>

	<a href="#" class="btn">链接</a>
	
	<div class="cont">
		测试字体
	</div>
	
	<div class="cont2">
		当前容器定义字体大小
		<p class="txt">内部容器</p>
	</div>


	<script>
		window.onclick = function() {
			return false;
		}
	</script>
</body>
</html>