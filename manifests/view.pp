# = Define: bind::view
#
# This class adds a DNS view.
# This class also subscribes to @concat::fragment with tag specified by
# tag option. So, if you want to add a specific zones or configurations into
# this view just add the same tag as this view into bind::record and bind::zone
# directives.
#
# If [*export_tag*] is not specify we will used the view name.
#
# == Parameters:
#
# [*view_name*]
#   a word that describes this view
#   (Default: 'all')
#
# [*match_clients*]
#   configuration that lists which clients will match into this view
#   (Default: '0.0.0.0/0' which means everybody)
# 
# [*absent*]
#   Set to 'true' to remove view.
#   (Default: 'false')
#
# [*template*]
#   Header template used for view.
#   It contains default configuration.
#   (Default: 'bind/view-view.erb')
#
# [*export_tag*]
#   Used tag for exported ressource
#   (Default: $view_name)
#
# == Example:
#
# * Creates a view for our clients at 192.168.0.0/16 and uses a different
#   template than the default.
#
#   class { "bind": }
#   bind::view { 'Internal':
#     template => 'bind/view-internal.erb',
#   }
#
#
define bind::view(
  $view_name      = $name,
  $match_clients  = '0.0.0.0/0',
  $absent         = false,
  $template       = 'bind/view-header.erb',
  $export_tag     = ''
  ) {

  $bool_absent = any2bool($absent)

  if $export_tag == '' {
    $real_export_tag = $view_name
  } else {
    $real_export_tag = $export_tag
  }

  include bind
  include concat::setup

  $view_config_file = "$bind::config_dir/view.${view_name}.conf"

  if $bool_absent == false {
    # This inserts the view into named.conf
    concat::fragment {"bind-include-view-${view_name}":
      target  => $bind::config_file,
      content => template( 'bind/named.conf-view.erb' ),
      order   => 30,
    }

    # Create where the zones will be inserted into.
	concat { "$view_config_file":
             mode  => $bind::config_file_mode,
             owner => $bind::config_file_owner,
             group => $bind::config_file_group,
    }

    Concat::Fragment <<| tag == "bind-view-$real_export_tag" |>> {
        target => "$view_config_file",
        notify => $bind::manage_service_autorestart,
        order  => 30,
    }

	# Header for external file
    concat::fragment{"bind-view-${view_name}-header":
      target  => "$view_config_file",
      content => template($template),
      order   => 01,
    }

  } else {
    file{"view-$view_name":
      ensure => absent,
      path   => "$view_config_file",
    }
  } # if $bool_absent
}
