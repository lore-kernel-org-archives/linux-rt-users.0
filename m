From: Feng Feng24 Liu <liufeng24@lenovo.com>
Subject: RE: BUG: unable to handle kernel NULL pointer dereference at
 0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Tue, 27 Jun 2017 04:52:01 +0000
Message-ID: <2B18E8E1DDAE074A82D1060396451DAE263CC19D@CNMAILEX04.lenovo.com>
References: <2B18E8E1DDAE074A82D1060396451DAE263CBBD6@CNMAILEX04.lenovo.com>
 <20170626102418.310bb1ce@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        "Mike Galbraith" <efault@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.17]:7963 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751460AbdF0EwT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jun 2017 00:52:19 -0400
In-Reply-To: <20170626102418.310bb1ce@gandalf.local.home>
Content-Language: zh-CN
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

HI steve
	I have installed the openstack on the server, and create & destroy some virtual machines. 
	Then I left it to run for about 2 days without do nothing. The problem happened
	I don't know what proc file it read by now, since when I found the problem on Monday, the kernel have already been hang-up.

Thanks
Feng

>-----Original Message-----
>From: Steven Rostedt [mailto:rostedt@goodmis.org]
>Sent: Monday, June 26, 2017 10:24 PM
>To: Feng Feng24 Liu
>Cc: Sebastian Andrzej Siewior; Mike Galbraith; linux-kernel@vger.kernel.org;
>linux-rt-users@vger.kernel.org; tmac@hp.com
>Subject: Re: BUG: unable to handle kernel NULL pointer dereference at
>0000000000000038 !//RE: kernel BUG at kernel/locking/rtmutex.c:1027
>
>On Mon, 26 Jun 2017 06:33:29 +0000
>Feng Feng24 Liu <liufeng24@lenovo.com> wrote:
>
>> Hi, dear RT experts
>> 	Thanks a lot!
>> 	I update our kernel to 4.4.70-rt83 as your suggestion. The incorrect deadlock
>detection problem has been fixed in this version.
>>
>> 	But I found there is another BUG in 4.4.70-rt83, which can cause the system
>hang-up
>> 	The BUG is:  "BUG: unable to handle kernel NULL pointer dereference at
>0000000000000038"
>> 	Following is the kernel log
>> ----------------------------------------------------------------------
>> ---------------------------------------------------------
>> <4>Jun 23 21:54:53 node-1 kernel: [ 1377.160768] handler405 (21385)
>> used greatest stack depth: 11336 bytes left <4>Jun 23 21:54:53 node-1
>> kernel: [ 1377.161073] handler403 (21383) used greatest stack depth:
>> 11000 bytes left <1>Jun 24 10:01:19 node-1 kernel: [44959.446196] BUG:
>> unable to handle kernel NULL pointer dereference at 0000000000000038
>> <1>Jun 24 10:01:19 node-1 kernel: [44959.446203] IP:
>> [<ffffffff810a2cb4>] __try_to_take_rt_mutex+0x34/0x160 <4>Jun 24
>> 10:01:19 node-1 kernel: [44959.446205] PGD 1ea8056067 PUD 1e71e4a067
>> PMD 0 <4>Jun 24 10:01:19 node-1 kernel: [44959.446206] Oops: 0000 [#1]
>> PREEMPT SMP <4>Jun 24 10:01:19 node-1 kernel: [44959.446230] Modules
>> linked in: xt_nat xt_REDIRECT nf_nat_redirect xt_mark ip6table_raw
>> ip6table_mangle ip6table_filter ip6_tables xt_CHECKSUM xt_connmar k
>> iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat
>> nf_nat_ipv4 nf_nat veth 8021q garp mrp xt_tcpudp xt_conntrack
>> iptable_raw xt_CT xt_comment iptable_filter xt_multiport ope nvswitch
>> intel_rapl iosf_mbi intel_powerclamp coretemp kvm_intel kvm irqbypass
>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
>> aes_x86_64 glue_helper lrw ablk_helper cryptd in put_leds led_class
>> sb_edac edac_core lpc_ich mfd_core mei_me ioatdma mei dca shpchp
>> ipmi_devintf ipmi_si ipmi_msghandler mxm_wmi wmi acpi_pad
>> acpi_power_meter tpm_tis nf_conntrack_ipv6 nf_d
>> efrag_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables x_tables raid1
>> megaraid_sas <4>Jun 24 10:01:19 node-1 kernel: [44959.446233] CPU: 17
>> PID: 1738811 Comm: ip Not tainted 4.4.70-thinkcloud-nfv #1 <4>Jun 24
>> 10:01:19 node-1 kernel: [44959.446234] Hardware name: LENOVO System
>> x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016 <4>Jun
>> 24 10:01:19 node-1 kernel: [44959.446235] task: ffff881cda2c27c0 ti:
>> ffff881ea0538000 task.ti: ffff881ea0538000 <4>Jun 24 10:01:19 node-1
>> kernel: [44959.446236] RIP: 0010:[<ffffffff810a2cb4>]
>> [<ffffffff810a2cb4>] __try_to_take_rt_mutex+0x34/0x160 <4>Jun 24
>> 10:01:19 node-1 kernel: [44959.446237] RSP: 0018:ffff881ea053bb50
>> EFLAGS: 00010082 <4>Jun 24 10:01:19 node-1 kernel: [44959.446238] RAX:
>> 0000000000000000 RBX: ffff881f805416a8 RCX: 0000000000000000 <4>Jun 24
>> 10:01:19 node-1 kernel: [44959.446238] RDX: ffff881ea053bb98 RSI:
>> ffff881cda2c27c0 RDI: ffff881f805416a8 <4>Jun 24 10:01:19 node-1
>> kernel: [44959.446239] RBP: ffff881ea053bb60 R08: 0000000000000001
>> R09: 0000000000000002 <4>Jun 24 10:01:19 node-1 kernel: [44959.446239]
>> R10: 0000000000000a01 R11: 0000000000000001 R12: ffff881cda2c27c0 <4>Jun 24
>10:01:19 node-1 kernel: [44959.446240] R13: ffff881cda2c27c0 R14:
>0000000000000202 R15: ffff881f6b0c27c0 <4>Jun 24 10:01:19 node-1 kernel:
>[44959.446240] FS:  00007f28be315740(0000) GS:ffff88205f8c0000(0000)
>knlGS:0000000000000000 <4>Jun 24 10:01:19 node-1 kernel: [44959.446241] CS:
>0010 DS: 0000 ES: 0000 CR0: 0000000080050033 <4>Jun 24 10:01:19 node-1 kernel:
>[44959.446241] CR2: 0000000000000038 CR3: 0000001e9e479000 CR4:
>00000000003406e0 <4>Jun 24 10:01:19 node-1 kernel: [44959.446242] DR0:
>0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 <4>Jun 24
>10:01:19 node-1 kernel: [44959.446242] DR3: 0000000000000000 DR6:
>00000000fffe0ff0 DR7: 0000000000000400 <4>Jun 24 10:01:19 node-1 kernel:
>[44959.446243] Stack:
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446244]  ffff881f805416a8
>> ffff881ea053bb98 ffff881ea053bc28 ffffffff81a8f03d <4>Jun 24 10:01:19
>> node-1 kernel: [44959.446245]  ffff881ea053c000 01ff881ea053bb90
>> ffff881cda2c27c0 ffff881f6b0c27c1 <4>Jun 24 10:01:19 node-1 kernel:
>[44959.446246]  ffff881cda2c2eb0 0000000000000001 0000000000000000
>0000000000000000 <4>Jun 24 10:01:19 node-1 kernel: [44959.446246] Call Trace:
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446252]  [<ffffffff81a8f03d>]
>> rt_spin_lock_slowlock+0x13d/0x390 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446255]  [<ffffffff81a903bf>] rt_spin_lock+0x1f/0x30 <4>Jun 24
>> 10:01:19 node-1 kernel: [44959.446260]  [<ffffffff8141757f>]
>> lockref_get_not_dead+0xf/0x50 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446263]  [<ffffffff811e0a01>] ns_get_path+0x61/0x1d0
>
>Hmm, this is in the filesystem code. What were you doing when this happened?
>
>
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446268]  [<ffffffff8121eea9>]
>> proc_ns_follow_link+0x89/0xa0
>
>Do you know what proc file it was reading?
>
>-- Steve
>
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446273]  [<ffffffff811c93a3>]
>> ? touch_atime+0x23/0xa0 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446277]  [<ffffffff811b89d8>] trailing_symlink+0x208/0x270
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446279]  [<ffffffff811bb267>]
>> path_openat+0x2b7/0x12b0 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446286]  [<ffffffff811a1c75>] ?
>> mem_cgroup_end_page_stat+0x25/0x50
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446287]  [<ffffffff811bd2ce>]
>> do_filp_open+0x7e/0xd0 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446288]  [<ffffffff81a90453>] ? rt_spin_unlock+0x13/0x20 <4>Jun
>> 24 10:01:19 node-1 kernel: [44959.446290]  [<ffffffff811ca9d5>] ?
>> __alloc_fd+0xc5/0x180 <4>Jun 24 10:01:19 node-1 kernel: [44959.446292]
>> [<ffffffff811ac9a8>] do_sys_open+0x128/0x210 <4>Jun 24 10:01:19 node-1
>> kernel: [44959.446296]  [<ffffffff811460ea>] ?
>> __context_tracking_enter+0x8a/0x160
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446297]  [<ffffffff811acaae>]
>> SyS_open+0x1e/0x20 <4>Jun 24 10:01:19 node-1 kernel: [44959.446298]
>> [<ffffffff81a9086e>] entry_SYSCALL_64_fastpath+0x12/0x71
>> <4>Jun 24 10:01:19 node-1 kernel: [44959.446308] Code: 89 e5 41 54 53
>> 48 83 4f 18 01 48 89 fb 4c 8b 47 18 49 f7 c0 fe ff ff ff 74 05 5b 41
>> 5c 5d c3 48 85 d2 49 89 f4 74 1d 48 8b 4f 10 <48> 3b 79 38 0f 85 0c 01
>> 00 00 48 39 ca 75 e0 48 89 d6 e8 75 fd <1>Jun 24 10:01:19 node-1
>> kernel: [44959.446309] RIP  [<ffffffff810a2cb4>]
>> __try_to_take_rt_mutex+0x34/0x160 <4>Jun 24 10:01:19 node-1 kernel:
>> [44959.446310]  RSP <ffff881ea053bb50> <4>Jun 24 10:01:19 node-1 kernel:
>[44959.446310] CR2: 0000000000000038 <4>Jun 24 10:01:19 node-1 kernel:
>[44963.688055] ---[ end trace 0000000000000002 ]--- <3>Jun 24 10:12:32 node-1
>kernel: [45615.758301] INFO: rcu_preempt detected stalls on CPUs/tasks:
>> <3>Jun 24 10:12:32 node-1 kernel: [45615.758308]        4-...: (1 GPs behind)
>idle=c77/140000000000000/0 softirq=0/0 fqs=200736
>> <3>Jun 24 10:12:32 node-1 kernel: [45615.758311]        (detected by 27,
>t=651052 jiffies, g=9051323, c=9051322, q=514190)
>> <4>Jun 24 10:12:32 node-1 kernel: [45615.758320]  ffff881e9b82bce8
>> ffff881e9b82bd08 ffffffff810856e3 ffff881e9b078a38 <4>Jun 24 10:12:32
>> node-1 kernel: [45615.758321]  ffff881e9b82bd20 ffffffff810856e3
>> ffff881f805416a8 ffff881e9b82bd40 <4>Jun 24 10:12:32 node-1 kernel:
>[45615.758322]  ffffffff81a900bb ffff881f805416a8 ffff881e9b82bd78
>ffff881e9b82be08 <4>Jun 24 10:12:32 node-1 kernel: [45615.758322] Call Trace:
>> <4>Jun 24 10:12:32 node-1 kernel: [45615.758332]  [<ffffffff810856e3>]
>> ? preempt_count_add+0xa3/0xc0 <4>Jun 24 10:12:32 node-1 kernel:
>> [45615.758333]  [<ffffffff810856e3>] ? preempt_count_add+0xa3/0xc0
>> <4>Jun 24 10:12:32 node-1 kernel: [45615.758338]  [<ffffffff81a900bb>]
>> ? _raw_spin_lock_irqsave+0x4b/0x50 <4>Jun 24 10:12:32 node-1 kernel:
>> [45615.758339]  [<ffffffff81a8ef5f>] ?
>> rt_spin_lock_slowlock+0x5f/0x390 <4>Jun 24 10:12:32 node-1 kernel:
>> [45615.758341]  [<ffffffff81a903bf>] ? rt_spin_lock+0x1f/0x30 <4>Jun
>> 24 10:12:32 node-1 kernel: [45615.758347]  [<ffffffff811c42ce>] ?
>> dput+0xce/0x270 <4>Jun 24 10:12:32 node-1 kernel: [45615.758349]
>> [<ffffffff811af00a>] ? __fput+0x16a/0x1e0 <4>Jun 24 10:12:32 node-1
>> kernel: [45615.758350]  [<ffffffff811af0be>] ? ____fput+0xe/0x10
>> <4>Jun 24 10:12:32 node-1 kernel: [45615.758352]  [<ffffffff8107e7e6>]
>> ? task_work_run+0x86/0xb0 <4>Jun 24 10:12:32 node-1 kernel:
>> [45615.758355]  [<ffffffff8105c784>] ? exit_to_usermode_loop+0xa2/0xd7
>> <4>Jun 24 10:12:32 node-1 kernel: [45615.758358]  [<ffffffff81001b1a>]
>> ? syscall_return_slowpath+0x8a/0xb0 <4>Jun 24 10:12:32 node-1 kernel:
>> [45615.758359]  [<ffffffff81a909cc>] ? int_ret_from_sys_call+0x25/0x8f
>> <5>Jun 24 10:12:32 node-1 kernel: [45633.758592] megaraid_sas
>> 0000:10:00.0: [ 0]waiting for 2 commands to complete for scsi0
