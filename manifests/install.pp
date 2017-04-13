class zabbixagent::install {

    package { $::zabbixagent::package_name:
        ensure  => present,
    }

    file { $::zabbixagent::folder_log:
        ensure  => directory,
        owner   => "zabbix",
        group   => "zabbix",
        #source  => "puppet:///files/var/log/zabbix",
        require => Package[$::zabbixagent::package_name]
    }

    file { '/etc/zabbix/zabbix_agentd.d':
        ensure  => directory,
        owner   => "zabbix",
        group   => "zabbix",
        #source  => "puppet:///files/var/log/zabbix",
        require => Package[$::zabbixagent::package_name]
    }

    file { $::zabbixagent::file_conf:
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        content => template($::zabbixagent::template),
        require => Package[$::zabbixagent::package_name],
        notify => Service[$::zabbixagent::service_name],
    }

    service { $::zabbixagent::service_name:
        ensure  => $::zabbixagent::ensure,
        enable  => $::zabbixagent::enable,
        hasstatus   => true,
        hasrestart => true,
        require => Package[$::zabbixagent::package_name],
    }

}
