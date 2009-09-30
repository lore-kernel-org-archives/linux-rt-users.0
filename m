From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Problem with 2.6.31-rt11 + iptables on shutdown
Date: Wed, 30 Sep 2009 10:10:54 -0300
Message-ID: <20090930131054.GM3466@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:57545 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZI3NKq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Sep 2009 09:10:46 -0400
Received: by pxi32 with SMTP id 32so5431653pxi.4
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Sep 2009 06:10:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

This is apparently a new manifestation of the same issue I have been chasing
for quite a while and have been failing in a very shameful way to fix. In
the original issue, whenever I run deluge (bit torrent client) at
SCHED_FIFO, I got the error message below and system would freeze / panic
during shutdown:

  ================================================
  [ BUG: lock held when returning to user space! ]
  ------------------------------------------------
  deluged/3035 is leaving the kernel with locks still held!
  1 lock held by deluged/3035:
   #0:  (&lock->lock){......}, at: [<ffffffffa02ae965>] ipt_do_table+0x10c/0x5f3 [ip_tables]

Now I can reproduce it with netperf2 (I am using version 2.4.1) just like
this:

  [lclaudio@lab src]$ chrt -f 30  ./netserver
  Starting netserver at port 12865
  Starting netserver at hostname 0.0.0.0 port 12865 and family AF_UNSPEC

  [lclaudio@lab src]$ chrt -f 30  ./netperf -l 120
  TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to lab (127.0.0.1) port 0 AF_INET
  Recv   Send    Send                          
  Socket Socket  Message  Elapsed              
  Size   Size    Size     Time     Throughput  
  bytes  bytes   bytes    secs.    10^6bits/sec  

   87380  16384  16384    120.00   4736.77   


Whenever I try to shutdown or poweroff I get this panic:
----------------

BUG: unable to handle kernel paging request at 0000001e316060fe
IP: [<ffffffff811ff3e8>] plist_add+0x54/0xba
PGD 701ee067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/class/net/eth1/address
CPU 0 
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth rfkill lockd sunrpc nf_conntrack_netbios_ns ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 xt_state iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables ipv6 dm_multipath scsi_dh video output sbs sbshc battery ac lp sg sr_mod cdrom snd_hda_codec_analog snd_pcsp tg3 snd_seq_dummy snd_hda_intel snd_hda_codec snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss serio_raw snd_pcm pata_acpi shpchp i2c_i801 ata_generic snd_timer snd iTCO_wdt intel_agp button iTCO_vendor_support soundcore i2c_core 3c59x mii snd_page_alloc floppy parport_pc parport dm_snapshot dm_zero dm_mirror dm_region_hash dm_log dm_mod ata_piix libata sd_mod crc_t10dif scsi_mod ext3 jbd mbcache uhci_hcd ohci_h
 cd ehci_hcd [last unloaded: microcode]
Pid: 4470, comm: ip6tables Not tainted 2.6.31-rt11 #1 8810A56
RIP: 0010:[<ffffffff811ff3e8>]  [<ffffffff811ff3e8>] plist_add+0x54/0xba
RSP: 0018:ffff880078533b18  EFLAGS: 00010006
RAX: ffff880078533bf8 RBX: ffff880078533be0 RCX: ffff880078533bf8
RDX: ffff880078533bf8 RSI: 0000001e316060f6 RDI: ffff880078533be0
RBP: ffff880078533b38 R08: ffff880078533be8 R09: ffffffff81692060
R10: 0000000054bf364f R11: 0000000054bf364f R12: ffff88006b0a8ae8
R13: ffff880078533bb8 R14: ffff8800018cffa0 R15: ffff88006b0a84c0
FS:  00007fa1c418e6e0(0000) GS:ffff8800018a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001e316060fe CR3: 000000007846f000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process ip6tables (pid: 4470, threadinfo ffff880078532000, task ffff88007a4da0c0)
Stack:
 ffff880078533b38 0000000054bf364f ffff88006b0a8ae8 ffff88006b0a8ae0
<0> ffff880078533ba8 ffffffff8108a847 0000000000000246 00000000018cffa0
<0> ffff88007a4da0c0 ffff880078533be0 ffff880078533bb8 00000000ffffffff
Call Trace:
 [<ffffffff8108a847>] task_blocks_on_rt_mutex+0xfa/0x175
 [<ffffffff813e0a71>] rt_spin_lock_slowlock+0xa7/0x1b4
 [<ffffffff813e09ca>] ? rt_spin_lock_slowlock+0x0/0x1b4
 [<ffffffff81089fbe>] rt_spin_lock_fastlock+0x72/0x8e
 [<ffffffff813e10d9>] rt_spin_lock+0x23/0x39
 [<ffffffffa0360c17>] xt_info_wrlock+0x2f/0x45 [ip6_tables]
 [<ffffffffa0360ed0>] get_counters+0x3c/0xbb [ip6_tables]
 [<ffffffffa0360fb4>] alloc_counters+0x65/0x84 [ip6_tables]
 [<ffffffffa03610ef>] do_ip6t_get_ctl+0x11c/0x361 [ip6_tables]
 [<ffffffff81089e94>] ? rt_mutex_fastlock+0x46/0x7e
 [<ffffffff813e047f>] ? rt_mutex_unlock+0x34/0x65
 [<ffffffff813e1180>] ? _mutex_unlock+0x1c/0x32
 [<ffffffff81352c32>] ? nf_sockopt_find+0x1b7/0x1dd
 [<ffffffff81352e15>] nf_sockopt+0x60/0xa6
 [<ffffffff81352e81>] nf_getsockopt+0x26/0x3c
 [<ffffffffa0314d6b>] ipv6_getsockopt+0x8b/0xd7 [ipv6]
 [<ffffffffa031bdca>] rawv6_getsockopt+0x50/0x6d [ipv6]
 [<ffffffff8131b92c>] sock_common_getsockopt+0x22/0x38
 [<ffffffff81318bfb>] sys_getsockopt+0x8a/0xc0
 [<ffffffff8100c0ab>] system_call_fastpath+0x16/0x1b
Code: 11 be 52 00 00 00 48 c7 c7 d0 48 53 81 e8 36 94 e5 ff 49 8b 34 24 48 83 ee 08 eb 0f 8b 06 39 03 7c 19 48 8d 42 f8 74 5d 48 89 c6 <48> 8b 56 08 48 8d 46 08 4c 39 e0 0f 18 0a 75 e1 48 8d 46 08 48 
RIP  [<ffffffff811ff3e8>] plist_add+0x54/0xba
 RSP <ffff880078533b18>
CR2: 0000001e316060fe
---[ end trace 4e4cb9041acce30c ]---
Kernel panic - not syncing: Fatal exception

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

