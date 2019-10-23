<?php
echo "Send MAIL test";
$msg = 'BandaLab Email testing is cool locally';
mail('kiokkio@banda.box', 'Test email', $msg);
exit;
?>