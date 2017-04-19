class zabbixagent::params {

$ensure=running 
$enable=true
$zserver='10.4.4.97'


    case $::osfamily {
	    Debian: {
		    $package_name 	= 'zabbix-agent'
		    $service_name 	= 'zabbix-agent'
		    $folder_log 	= '/var/log/zabbix'
		    $file_conf 	    = '/etc/zabbix/zabbix_agentd.conf' 
            $template       = 'zabbixagent/zabbix_agentd.conf.erb'
	    }
	    default: {
		    fail("this module does not support: ${::osfamily}")
	    }
    }

}
