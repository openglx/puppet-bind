# Class: bind::params
#
# This class defines default parameters used by the main module class bind
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to bind class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class bind::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'bind9',
    default                   => 'bind',
  }

  $service = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => 'named',
    default                     => 'bind9',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'named',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => 'named',
    default                     => 'bind',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => '/var/named',
    default                     => '/etc/bind',
  }

  $config_file = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => '/etc/named.conf',
    default                     => '/etc/bind/named.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => 'named',
    default                     => 'bind',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:centos|redhat|fedora)/ => 'named',
    default                     => 'bind',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/    => '/etc/default/bind9',
    /(?i:centos|redhat|fedora)/  => '/etc/sysconfig/named',
    default                      => '/etc/sysconfig/bind',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/    => '/var/run/named/named.pid',
    /(?i:centos|redhat|fedora)/  => '/var/run/named.pid',
    default                      => '/var/run/bind.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/cache/bind',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/bind',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/syslog',
  }

  $port = '53'
  $protocol = 'udp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'bind/named.conf-header.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
