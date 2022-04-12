<body onload="OnLoad();">

<div id="container">
<!--
	<div class="header">
		<?php include("plugins/header/index.php"); ?>
	</div>
	<div class="navigation">
		<?php include("plugins/navigation/index.php"); ?>
	</div>
-->

	<div id="clientarea">
		<div id="help" class="help"></div>

		<div id="plugin_html" style="display: block;">
			<?php include("plugins/loading/index.php"); ?>
		</div>
	</div>

<!--
	<div class="navigation_wrapper animated" onclick="mNavigation.Hide();">
		<img class="loading_spinner" src="resources/images/loading.gif" alt="Loading..."/>
	</div>
-->
</div>

<script>
  Initialize();

  mGlobals.Admin = false;
  mGlobals.Debug = false;

  <?php include("includes/parseParameters.php"); ?>
</script>

</body>

