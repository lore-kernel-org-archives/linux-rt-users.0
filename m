From: Feng Feng24 Liu <liufeng24@lenovo.com>
Subject: All process has been hanged after a kernel WARNING in kernel 4.4.x
Date: Wed, 23 Aug 2017 12:40:36 +0000
Message-ID: <2B18E8E1DDAE074A82D1060396451DAE26407871@CNMAILEX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Tong Tong3 Li <litong3@lenovo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear experts
	I install kernel 4.4.70-rt83 in my environment, and run QEMU-KVM & OVS-DPDK on my server.
	After a kernel warning, I found that all of the process, such as sshd, has no response. The monitor cannot displayed. All process looks like has been hanged. But the server could be ping. 
	Following is the log of the kernel warning
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 854 <3>Aug 18 11:40:36 node-15 kernel: [222633.430875] kvm [2042203]: vcpu0 unhandled rdmsr: 0x606                                                                                          
 855 <3>Aug 18 11:40:36 node-15 kernel: [222633.494780] kvm [2042203]: vcpu0 unhandled rdmsr: 0x34                                                                                           
 856 <3>Aug 18 11:41:22 node-15 kernel: [222679.084867] kvm [2042166]: vcpu0 unhandled rdmsr: 0x606                                                                                          
 857 <3>Aug 18 11:41:22 node-15 kernel: [222679.148727] kvm [2042166]: vcpu0 unhandled rdmsr: 0x34                                                                                           
 858 <4>Aug 22 13:44:21 node-15 kernel: [575621.666498] ------------[ cut here ]------------                                                                                                 
 859 <4>Aug 22 13:44:21 node-15 kernel: [575621.666518] WARNING: CPU: 34 PID: 1419064 at mm/page_counter.c:26 page_counter_cancel+0x34/0x40()                                                
 860 <4>Aug 22 13:44:21 node-15 kernel: [575621.666521] Modules linked in: xt_set ip_set_hash_net ip_set xt_mac xt_physdev ip6table_raw ip6table_mangle iptable_nat nf_nat_ipv4 nf_nat xt_con     nmark iptable_mangle 8021q garp mrp ebtable_filter ebtables ip6table_filter ip6_tables vhost_net vhost macvtap macvlan xt_tcpudp xt_conntrack iptable_raw xt_CT xt_comment iptable_filte     r xt_multiport igb_uio(O) uio openvswitch intel_rapl iosf_mbi intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64      glue_helper lrw ablk_helper cryptd input_leds led_class joydev mei_me mei lpc_ich sb_edac mfd_core edac_core shpchp ipmi_devintf ipmi_si ipmi_msghandler tpm_tis acpi_pad nf_conntrack_     ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 n
 f_defrag_ipv4 ip_tables x_tables raid1 mpt3sas raid_class scsi_transport_sas                                                                     
 861 <4>Aug 22 13:44:21 node-15 kernel: [575621.666579] CPU: 34 PID: 1419064 Comm: ruby-mri Tainted: G           O    4.4.70-thinkcloud-nfv #1                                               
 862 <4>Aug 22 13:44:21 node-15 kernel: [575621.666581] Hardware name: ZTE R5300 G3/SGLMA, BIOS UBF09.01.09_SVN65700 12/14/2016                                                              
 863 <4>Aug 22 13:44:21 node-15 kernel: [575621.666585]  0000000000000000 ffff8801341f3b90 ffffffff814093de 0000000000000000                                                                 
 864 <4>Aug 22 13:44:21 node-15 kernel: [575621.666587]  ffffffff81caec1c ffff8801341f3bc8 ffffffff810615d6 ffff8801897acce0                                                                 
 865 <4>Aug 22 13:44:21 node-15 kernel: [575621.666589]  000000000000000a ffff8801897acc00 ffff883fc6fcb8e0 ffff883fc6fcb800                                                                 
 866 <4>Aug 22 13:44:21 node-15 kernel: [575621.666590] Call Trace:                                                                                                                          
 867 <4>Aug 22 13:44:21 node-15 kernel: [575621.666601]  [<ffffffff814093de>] dump_stack+0x65/0x87                                                                                           
 868 <4>Aug 22 13:44:21 node-15 kernel: [575621.666609]  [<ffffffff810615d6>] warn_slowpath_common+0x86/0xe0                                                                                 
 869 <4>Aug 22 13:44:21 node-15 kernel: [575621.666612]  [<ffffffff810616ea>] warn_slowpath_null+0x1a/0x30                                                                                   
 870 <4>Aug 22 13:44:21 node-15 kernel: [575621.666616]  [<ffffffff811a15c4>] page_counter_cancel+0x34/0x40                                                                                  
 871 <4>Aug 22 13:44:21 node-15 kernel: [575621.666619]  [<ffffffff811a16c2>] page_counter_uncharge+0x22/0x30                                                                                
 872 <4>Aug 22 13:44:21 node-15 kernel: [575621.666622]  [<ffffffff811a35db>] drain_stock.isra.39+0x3b/0xe0                                                                                  
 873 <4>Aug 22 13:44:21 node-15 kernel: [575621.666624]  [<ffffffff811a3bea>] try_charge+0x3ca/0x720                                                                                         
 874 <4>Aug 22 13:44:21 node-15 kernel: [575621.666629]  [<ffffffff81085687>] ? preempt_count_add+0x47/0xc0                                                                                  
 875 <4>Aug 22 13:44:21 node-15 kernel: [575621.666634]  [<ffffffff811a7ba3>] mem_cgroup_try_charge+0x63/0x100                                                                               
 876 <4>Aug 22 13:44:21 node-15 kernel: [575621.666640]  [<ffffffff8117477b>] wp_page_copy.isra.63+0x14b/0x500                                                                               
 877 <4>Aug 22 13:44:21 node-15 kernel: [575621.666643]  [<ffffffff811760fe>] do_wp_page+0x8e/0x450                                                                                          
 878 <4>Aug 22 13:44:21 node-15 kernel: [575621.666647]  [<ffffffff8117814b>] handle_mm_fault+0xd7b/0x1380                                                                                   
 879 <4>Aug 22 13:44:21 node-15 kernel: [575621.666656]  [<ffffffff81a98c2a>] ? _raw_spin_lock_irqsave+0x2a/0x50                                                                             
 880 <4>Aug 22 13:44:21 node-15 kernel: [575621.666661]  [<ffffffff810a2d88>] ? __try_to_take_rt_mutex+0x108/0x160                                                                           
 881 <4>Aug 22 13:44:21 node-15 kernel: [575621.666664]  [<ffffffff81a98c70>] ? _raw_spin_unlock_irqrestore+0x20/0x60                                                                        
 882 <4>Aug 22 13:44:21 node-15 kernel: [575621.666667]  [<ffffffff81a975e0>] ? rt_mutex_trylock+0x80/0xc0                                                                                   
 883 <4>Aug 22 13:44:21 node-15 kernel: [575621.666673]  [<ffffffff8104efaf>] __do_page_fault+0x16f/0x4d0                                                                                    
 884 <4>Aug 22 13:44:21 node-15 kernel: [575621.666676]  [<ffffffff8104f342>] do_page_fault+0x32/0x90                                                                                        
 885 <4>Aug 22 13:44:21 node-15 kernel: [575621.666681]  [<ffffffff811463cd>] ? context_tracking_exit+0x1d/0x30                                                                              
 886 <4>Aug 22 13:44:21 node-15 kernel: [575621.666685]  [<ffffffff81a9b298>] page_fault+0x28/0x30                                                                                           
 887 <4>Aug 22 13:44:21 node-15 kernel: [575621.666688] ---[ end trace 0000000000000002 ]---                                                                                                 
 888 <7>Aug 22 13:52:14 node-15 kernel: [576094.285955] kvm: zapping shadow pages for mmio generation wraparound                                                                             
 889 <7>Aug 22 13:52:14 node-15 kernel: [576094.362130] kvm: zapping shadow pages for mmio generation wraparound                                                                             
 890 <3>Aug 22 13:52:21 node-15 kernel: [576101.551233] kvm [1424015]: vcpu3 unhandled rdmsr: 0x606               
	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	I find there is a discuss at:
	https://lkml.org/lkml/2015/12/3/460
	Whether it is the same problem as above?  Is it a known issue , which has not been fixed in kernel 4.4.x?


Thanks
Feng
