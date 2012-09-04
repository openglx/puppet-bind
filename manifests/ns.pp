# = Define: bind::ns
#
# Create a NS DNS record.
# See bind::record for more informations
#
# There is no need of host parameters for NS entry.
# Target default value is $name.
#
define bind::ns (
  $view         = 'all',
  $zone,
  $target       = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = ''
  ) {

  bind::record { "NS-$name":
    view         => $view,
    zone         => $zone,
    target       => $target,
    host         => '',
    record_type  => 'NS',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
  }
}
