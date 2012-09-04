# = Define: bind::cname
#
# Create a CNAME DNS record.
# See bind::record for more informations
#
define bind::cname (
  $view         = 'all',
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = ''
  ) {

  bind::record { "CNAME-$name":
    view        => $view,
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'CNAME',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
  }
}
