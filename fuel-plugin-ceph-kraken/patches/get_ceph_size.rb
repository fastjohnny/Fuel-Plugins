#require 'facter'
module Puppet::Parser::Functions
newfunction(:get_ceph_size, :type => :rvalue, :doc => <<-EOS
Return a size of ceph disks ith reservation.
example:
  get_ceph_size($array_of_ceph_block_device)
EOS
) do |vals|
     bluestore = Array.new
     sysfs_block_directory = '/sys/block/'

     vals[0].each { |singledisk| 
        sysfs_device_directory = sysfs_block_directory + singledisk.to_s + "/device"
        sizefile = sysfs_block_directory + singledisk + "/size"
        bluestore.push(IO.read(sizefile).strip.to_i * 512 - 700000000)
     }
  return bluestore.min
  end
end
