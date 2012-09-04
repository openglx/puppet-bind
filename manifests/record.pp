# = Define: bind::record
#
# If no [*tag_export*] is specify we will used the zone name.
#
# == Parameters:
#
# [*view*]
#   View context for this zone. (Like "Internal" for your servers, "External" for others)
##
# [*zone*]
#   Name of the zone. (Like google.com)
#
# [*target*]
#   Record target.
#
# [*host*]
#   Name of the host to add. (Like www, www.example.com, ...)
#   (Default: $name)
#
# [*record_type*]
#   Record record_type.
#   (Default: 'A')
#
# [*record_class*]
#   Record class
#   (Default: 'IN')
#
# [*record_priority*]
#   The record priority for MX or SRV entry.
#
# [*export_tag*]
#   Used tag for exported ressource
#   (Default: $zone_name)
#
# [*absent*]
#   Set to 'true' to remove zone.
#   (Default: 'false')
#
# [*template*]
#   Used template file.
#   (Default: 'bind/record.erb')
#
# == Example:
#
# * Create A record. www -> 192.168.0.10
#
#   bind::record { 'www.example.com.':
#     zone   => 'example.com.',
#     target => '192.168.0.10',
#   }
#
define bind::record (
  $view            = 'all',
  $zone,
  $target,
  $host            = $name,
  $record_type     = 'A',
  $record_class    = 'IN',
  $record_priority = '',
  $export_tag      = $zone,
  $absent          = false,
  $template        = 'bind/record.erb',
  $ttl             = ''
  ) {

  if $absent == false {
    @@concat::fragment { "bind-zone-${view}-${zone}-${host}-${target}":
      tag     => "bind-zone-$export_tag",
      content => template($template),
    }
  }

}
