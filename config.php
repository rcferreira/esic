<?php
define( 'ABSPATH', dirname( __FILE__ ) );
define( 'UP_ABSPATH', ABSPATH . '/views/_uploads' );

define( 'HOME_URI', 'http://localhost/esic');
// Nome do host da base de dados
define( 'HOSTNAME', 'localhost' );
define( 'DB_NAME', 'db_esic' );
define( 'DB_USER', 'root' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_CHARSET', 'utf8' );
define( 'DEBUG', false );
require_once ABSPATH . '/loader.php';
?>