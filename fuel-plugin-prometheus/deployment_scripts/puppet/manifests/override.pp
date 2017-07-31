$plugin_name     = 'fuel-plugin-prometheus'
$plugin_hash = hiera_hash("${plugin_name}", {})
$hiera_dir              = '/etc/hiera/plugins'
notice('MODULAR: fuel-plugin-prometheus/override.pp')

$prometheus_ceilometer = $plugin_hash['fp-prometheus-ceilometer']
$prometheus_ceilometer_port = pick($plugin_hash['fp-prometheus-ceilometer_port'],'')

$prometheus_ceph = $plugin_hash['fp-prometheus-ceph']
$prometheus_ceph_port = pick($plugin_hash['fp-prometheus-ceph_port'],'')

$prometheus_haproxy = $plugin_hash['fp-prometheus-haproxy']
$prometheus_haproxy_port = pick($plugin_hash['fp-prometheus-haproxy_port'],'')

$prometheus_mysql = $plugin_hash['fp-prometheus-mysql']
$prometheus_mysql_port = pick($plugin_hash['fp-prometheus-mysql_port'],'')

$prometheus_node = $plugin_hash['fp-prometheus-node']
$prometheus_node_port = pick($plugin_hash['fp-prometheus-node_port'],'')

$prometheus_openstack = $plugin_hash['fp-prometheus-openstack']
$prometheus_openstack_port = pick($plugin_hash['fp-prometheus-openstack_port'],'')

$prometheus_rabbitmq = $plugin_hash['fp-prometheus-rabbitmq']
$prometheus_rabbitmq_port = pick($plugin_hash['fp-prometheus-rabbitmq_port'],'')

$network_scheme   = hiera_hash('network_scheme')
$network_metadata = hiera_hash('network_metadata')
prepare_network_config($network_scheme)

$hiera_file = '/etc/hiera/plugins/fuel-plugin-prometheus.yaml'
$prometheus_listen_address = get_network_role_property('prometheus_vip', 'ipaddr')
$prometheus_vip = $network_metadata['vips']['prometheus']['ipaddr']

$prometheus_leader = get_nodes_hash_by_roles($network_metadata, ['primary-prometheus'])
$leader_ip_addresses = values(get_node_to_ipaddr_map_by_network_role($prometheus_leader, 'prometheus_vip'))
$leader_ip_address = $leader_ip_addresses[0]

$prometheus_others = get_nodes_hash_by_roles($network_metadata, ['prometheus'])
$others_ip_addresses = sort(values(get_node_to_ipaddr_map_by_network_role($prometheus_others, 'prometheus_vip')))

$calculated_content = inline_template('
---
prometheus_ceilometer: <%= @prometheus_ceilometer %>
prometheus_ceilometer_port: <%= @prometheus_ceilometer %>
prometheus_ceph: <%= @prometheus_ceph %>
prometheus_ceph_port: <%= @prometheus_ceph_port %>
prometheus_haproxy: <%= @prometheus_haproxy %>
prometheus_haproxy_port: <%= @prometheus_haproxy_port %>
prometheus_mysql: <%= @prometheus_mysql %>
prometheus_mysql_port: <%= @prometheus_mysql_port %>
prometheus_node: <%= @prometheus_node %>
prometheus_node_port: <%= @prometheus_node_port %>
prometheus_openstack: <%= @prometheus_openstack %>
prometheus_openstack_port: <%= @prometheus_openstack_port %>
prometheus_rabbitmq: <%= @prometheus_rabbitmq %>
prometheus_rabbitmq_port: <%= @prometheus_rabbitmq_port %>

corosync_roles: ["prometheus","primary-prometheus"]
colocate_haproxy: false

prometheus::raft_leader: <%= @leader_ip_address == @prometheus_listen_address ? "true" : "false" %>
prometheus::raft_nodes: # The first node is the leader
    - "<%= @leader_ip_address %>"
<% @others_ip_addresses.each do |x| -%>
    - "<%= x %>"
<% end -%>
prometheus::vip: <%= @prometheus_vip %>
')

  file { "${hiera_dir}/${plugin_name}.yaml":
    ensure  => file,
    content => "${calculated_content}\n",
  }
