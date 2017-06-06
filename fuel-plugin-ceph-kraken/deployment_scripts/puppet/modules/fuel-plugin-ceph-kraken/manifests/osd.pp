class fuel-plugin-ceph-kraken::osd {

 Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' }
 $node_volumes = hiera('node_volumes', [])
 $dev = get_target_disk($node_volumes, 'ceph')
 $plugin_settings = hiera('fuel-plugin-ceph-kraken')
 $bluestore = $plugin_settings['bluestore']
 $file_osd_id_exists = inline_template("<% if File.exist?('/var/log/lost+found/osd_create.lock') -%>true<% end -%>")

 define process_osd {

   $part = "partitions_${name}"
   $target_part = inline_template("<%= scope.lookupvar(part) %>")
   $target_part_arr = split($target_part,",")
   $arr_len=size($target_part_arr)

   if $bluestore == true {
   exec { "Prepare OSD $name": 
             command => "ceph-deploy --ceph-conf /root/ceph.conf --bluestore osd prepare localhost:$name$arr_len" 
        }
   ->
   exec { "Activate OSD $name": 
             command => "ceph-deploy --ceph-conf /root/ceph.conf --bluestore osd activate localhost:$name$arr_len",
             tries => 2,
        }
   }
   if $bluestore != true {
   exec { "Prepare OSD $name":
             command => "ceph-deploy --ceph-conf /root/ceph.conf osd prepare localhost:$name$arr_len"
        }
   ->
   exec { "Activate OSD $name":
             command => "ceph-deploy --ceph-conf /root/ceph.conf osd activate localhost:$name$arr_len",
             tries => 2,
        }
   }

}
if $file_osd_id_exists == ''
{
   process_osd { $dev : }
}

}
