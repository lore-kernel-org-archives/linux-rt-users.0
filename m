From: Helmut Buchsbaum <helmut.buchsbaum@gmail.com>
Subject: Re: Resend: 3.10.32-rt31: problem with "rcu: Eliminate softirq
 processing from rcutree"
Date: Sat, 8 Mar 2014 20:08:35 +0100
Message-ID: <CAJAcJWJ=TB=6orb3BQMQ7BbFBjP7k7Vn52KrKJGdmJeTZ91A3g@mail.gmail.com>
References: <CAJAcJWKq1VsSVGWGtbx=-e-kW5kP5sQ9y4mvRbnM==U9BC2NpQ@mail.gmail.com>
	<20140307162145.GC18441@linutronix.de>
	<20140307170419.GI3334@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, rostedt@goodmis.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52212 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaCHTIh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Mar 2014 14:08:37 -0500
Received: by mail-lb0-f180.google.com with SMTP id 10so3627456lbg.39
        for <linux-rt-users@vger.kernel.org>; Sat, 08 Mar 2014 11:08:35 -0800 (PST)
In-Reply-To: <20140307170419.GI3334@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is the correct point to tweak the system, I was not yet aware of!
Thanks a lot for the hint. I just enabled RCU_BOOST with its default
settings and the system runs smooth and stable again even in heavy
load situations. Maybe the default for RCU_BOOST should be set to Y on
systems using PREEMPT_RT_FULL ?

Again, many thanx,
Helmut

2014-03-07 18:04 GMT+01:00 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> On Fri, Mar 07, 2014 at 05:21:45PM +0100, Sebastian Andrzej Siewior wrote:
>> + paulmck
>>
>> * Helmut Buchsbaum | 2014-03-06 20:05:13 [+0100]:
>>
>> >I am working with a 3.10-rt based kernel on a custom device based on
>> >Xilinx Zynq Z-7010 (dual Cortex-A9) with 64MB DDR2 RAM.
>> >Today I rebased my work (3.10-rt mainly enhanced by Xilinx drivers,
>> >but otherwise unchanged) from 3.10.32-rt30 to 3.10.32-rt31. There I
>> >ran a dohell derivate (from
>> >http://git.xenomai.org/xenomai-2.6.git/plain/src/testsuite/xeno-test/dohell?id=v2.6.3,
>> >just using customized hackbench call and cyclictest as the only test)
>> >when the OOM killer struck, which definitely did not happen with
>> >3.10.32-rt30. Bisecting I detected
>> >8cf5b0e982cba4fd0e469989a420a15c8a378fa2 "rcu: Eliminate softirq
>> >processing from rcutree" as the change which introduced the unwanted
>> >behavior:
>> >
>> >[   73.865213] ls invoked oom-killer: gfp_mask=0x2000d0, order=0, oom_score_adj=0
>> >[   73.877229] CPU: 1 PID: 623 Comm: ls Not tainted 3.10.32-rt30+ #1
>> >[   73.877280] [<c0013c80>] (unwind_backtrace+0x0/0x138) from [<c0011d14>] (show_stack+0x10/0x14)
>> >[   73.877310] [<c0011d14>] (show_stack+0x10/0x14) from [<c0394d88>] (dump_header.isra.12+0x6c/0xa8)
>> >[   73.877334] [<c0394d88>] (dump_header.isra.12+0x6c/0xa8) from [<c0394e10>] (oom_kill_process.part.14+0x4c/0x384)
>> >[   73.877357] [<c0394e10>] (oom_kill_process.part.14+0x4c/0x384) from [<c007301c>] (out_of_memory+0x128/0x1c8)
>> >[   73.877380] [<c007301c>] (out_of_memory+0x128/0x1c8) from >[<c0076f10>] (__alloc_pages_nodemask+0x6f4/0x71c)
>> >[   73.877406] [<c0076f10>] (__alloc_pages_nodemask+0x6f4/0x71c) from [<c009fe9c>] (allocate_slab+0xe4/0xfc)
>> >[   73.877426] [<c009fe9c>] (allocate_slab+0xe4/0xfc) from [<c009fee4>] (new_slab+0x30/0x154)
>> >[   73.877447] [<c009fee4>] (new_slab+0x30/0x154) from [<c0396608>] (__slab_alloc.isra.52.constprop.54+0x2f0/0x3c4)
>> >[   73.877467] [<c0396608>] (__slab_alloc.isra.52.constprop.54+0x2f0/0x3c4) from [<c00a0614>] (kmem_cache_alloc+0x130/0x138)
>> >[   73.877489] [<c00a0614>] (kmem_cache_alloc+0x130/0x138) from [<c00a5d84>] (get_empty_filp+0x6c/0x1f4)
>> >[   73.877509] [<c00a5d84>] (get_empty_filp+0x6c/0x1f4) from [<c00b18b8>] (path_openat+0x2c/0x43c)
>> >[   73.877527] [<c00b18b8>] (path_openat+0x2c/0x43c) from [<c00b1f80>] (do_filp_open+0x2c/0x80)
>> >[   73.877544] [<c00b1f80>] (do_filp_open+0x2c/0x80) from [<c00a40a4>] (do_sys_open+0xe8/0x174)
>> >[   73.877564] [<c00a40a4>] (do_sys_open+0xe8/0x174) from [<c000e9c0>] (ret_fast_syscall+0x0/0x30)
>> >[   73.877574] Mem-info:
>> >[   73.877582] Normal per-cpu:
>> >[   73.877593] CPU    0: hi:    6, btch:   1 usd:   0
>> >[   73.877603] CPU    1: hi:    6, btch:   1 usd:   0
>> >[   73.877625] active_anon:1827 inactive_anon:5 isolated_anon:0
>> >[   73.877625]  active_file:174 inactive_file:1158 isolated_file:0
>> >[   73.877625]  unevictable:2493 dirty:1 writeback:1160 unstable:0
>> >[   73.877625]  free:3978 slab_reclaimable:1161 slab_unreclaimable:1345
>> >[   73.877625]  mapped:440 shmem:512 pagetables:526 bounce:0
>> >[   73.877625]  free_cma:3833
>> >[   73.877669] Normal free:15912kB min:824kB low:1028kB high:1236kB active_anon:7308kB inactive_anon:20kB active_file:696kB inacs
>> >[   73.877679] lowmem_reserve[]: 0 0
>> >[   73.877695] Normal: 234*4kB (ERC) 208*8kB (URC) 200*16kB (C) 189*32kB (RC) 61*64kB (RC) 1*128kB (R) 0*256kB 0*512kB 0*1024kB B
>> >[   73.877769] 2196 total pagecache pages
>> >[   73.877780] 0 pages in swap cache
>> >[   73.877789] Swap cache stats: add 0, delete 0, find 0/0
>> >[   73.877796] Free swap  = 0kB
>> >[   73.877804] Total swap = 0kB
>> >[   73.884950] 16384 pages of RAM
>> >[   73.884966] 5008 free pages
>> >[   73.884975] 1558 reserved pages
>> >[   73.884983] 1674 slab pages
>> >[   73.884990] 532633 pages shared
>> >[   73.884998] 0 pages swap cached
>> >[   73.885007] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_score_adj name
>> >[   73.908257] [  502]     0   502      723      119       5        0           0 klogd
>> >[   73.936201] [  504]     0   504      723      112       5        0           0 syslogd
>> >[   73.980352] [  506]     0   506      723       76       5        0           0 telnetd
>> >[   74.028534] [  566]     0   566      724      166       5        0           0 ash
>> >[   74.053796] [  606]     0   606      723       57       4        0           0 udhcpc
>> >[   74.081419] [  607]     0   607      724      161       5        0           0 dohell
>> >[   74.090873] [  609]     0   609      724       68       5        0           0 dohell
>> >[   74.106407] [  610]     0   610      724       61       5        0           0 dohell
>> >[   74.118017] [  611]     0   611      724       58       5        0           0 dohell
>> >[   74.128390] [  612]     0   612      723      110       5        0           0 nc
>> >[   74.198260] [  613]     0   613      724       61       5        0           0 dohell
>> >[   74.214133] [  614]     0   614      724       60       5        0           0 dohell
>> >[   74.227782] [  615]     0   615      724       60       5        0           0 dohell
>> >[   74.240921] [  616]     0   616      723      104       4        0           0 dd
>> >[   74.264528] [  617]     0   617      941      360       4        0           0 dd
>> >[   74.284988] [  618]     0   618      724       60       5        0           0 dohell
>> >[   74.312808] [  620]     0   620     2523     2494       9        0           0 cyclictest
>> >[   74.333122] [  623]     0   623      724      174       5        0           0 ls
>> >[   74.361071] [ 1623]     0  1623      690       95       4        0           0 sleep
>> >[   74.382116] [ 2008]     0  2008      448      133       5        0           0 hackbench
>> >[   74.402224] [ 2011]     0  2011      448       54       5        0           0 hackbench
>> >[   74.426216] [ 2012]     0  2012      448       54       5        0           0 hackbench
>> >[   74.452513] [ 2013]     0  2013      448       54       5        0           0 hackbench
>> >[   74.468437] [ 2014]     0  2014      448       54       5        0           0 hackbench
>> >[   74.481603] [ 2015]     0  2015      448       54       5        0           0 hackbench
>> >[   74.495083] [ 2016]     0  2016      448       54       5        0           0 hackbench
>> >[   74.528757] [ 2017]     0  2017      448       54       5        0           0 hackbench
>> >[   74.542685] [ 2019]     0  2019      448       54       5        0           0 hackbench
>> >[   74.561320] [ 2020]     0  2020      448       54       5        0           0 hackbench
>> >[   74.576906] [ 2021]     0  2021      448       54       5        0           0 hackbench
>> >[   74.586537] [ 2022]     0  2022      448       54       5        0           0 hackbench
>> >[   74.610881] [ 2023]     0  2023      448       54       5        0           0 hackbench
>> >[   74.696010] [ 2026]     0  2026      448       59       5        0           0 hackbench
>> >[   74.746412] [ 2032]     0  2032      448       64       5        0           0 hackbench
>> >[   74.781200] [ 2095]     0  2095      689       36       3        0           0 cat
>> >[   74.795979] [ 2098]     0  2098      246        1       2        0           0 ps
>> >[   74.815133] [ 2099]     0  2099      448      133       4        0           0 hackbench
>> >[   74.829415] [ 2100]     0  2100      690       98       4        0           0 cat
>> >[   74.844691] [ 2101]     0  2101      448       54       4        0           0 hackbench
>> >[   74.855449] [ 2102]     0  2102      448       54       4        0           0 hackbench
>> >[   74.876889] [ 2103]     0  2103      448       54       4        0           0 hackbench
>> >[   74.893808] [ 2104]     0  2104      448       54       4        0           0 hackbench
>> >[   74.915100] [ 2105]     0  2105      448       54       4        0           0 hackbench
>> >[   74.932730] [ 2106]     0  2106      448       54       4        0           0 hackbench
>> >[   74.965216] [ 2107]     0  2107      448       54       4        0           0 hackbench
>> >[   75.027941] [ 2108]     0  2108      448       54       4        0           0 hackbench
>> >[   75.046197] [ 2109]     0  2109      448       54       4        0           0 hackbench
>> >[   75.063038] [ 2110]     0  2110      448       54       4        0           0 hackbench
>> >[   75.079646] [ 2111]     0  2111      448       55       4        0           0 hackbench
>> >[   75.115715] [ 2112]     0  2112      448       55       4        0           0 hackbench
>> >[   75.125629] [ 2113]     0  2113      448       55       4        0           0 hackbench
>> >[   75.136509] [ 2114]     0  2114      448       55       4        0           0 hackbench
>> >[   75.146358] [ 2115]     0  2115      448       55       4        0           0 hackbench
>> >[   75.157808] [ 2116]     0  2116      448       55       4        0           0 hackbench
>> >[   75.167646] [ 2117]     0  2117      448       55       4        0           0 hackbench
>> >[   75.177705] [ 2118]     0  2118      448       55       4        0           0 hackbench
>> >[   75.187688] [ 2119]     0  2119      448       55       4        0           0 hackbench
>> >[   75.202440] [ 2120]     0  2120      448       55       4        0           0 hackbench
>> >[   75.226442] [ 2121]     0  2121      448       54       4        0           0 hackbench
>> >[   75.299323] [ 2190]     0  2190      724      152       5        0           0 ps
>> >[   75.309857] [ 2191]     0  2191      392       31       3        0           0 cat
>> >[   75.320704] [ 2192]     0  2192      116       33       3        0           0 hackbench
>> >[   75.331584] [ 2193]     0  2193      246        1       2        0           0 ps
>> >[   75.341056] Out of memory: Kill process 620 (cyclictest) score 163 or sacrifice child
>> >[   75.350899] Killed process 620 (cyclictest) total-vm:10092kB, anon-rss:8544kB, file-rss:1432kB
>> >
>> >Unfortunately I'm rather busy at the moment, so I couldn't investigate
>> >this issue at all, I'm sorry.
>> >Steven, probably this issue also concerns 3.8.13.14-rt28-rc1 (I just
>> >discovered your post on the list).
>> >
>> >Regards,
>> >Helmut
>> >
>> >PS: running this test with hackbench alone (no dohell), I get nearly
>> >the same result with kmem_cache_alloc() failing.
>> >PPS: I had to resend this post since I didn't get through to the list.
>> >Sorry about any noise!
>>
>> Do you have RCU_BOOST enabled? My guess here is that you *something* is
>> running at a higher priority not allowing rcuc/ to run and do its job.
>
> The major effect of that commit is to move processing from softirq to
> kthread.  If your workload has quite a few interrupts, it is possible
> that the softirq version would -usually- make progress, but the kthread
> version not.  (You could still get this to happen with softirq should
> ksoftirqd kick in.)
>
> Sebastian's suggestion of RCU_BOOST makes sense, and you will also need to
> set CONFIG_RCU_BOOST_PRIO to be higher priority than your highest-priority
> CPU-bound thread.
>
>                                                         Thanx, Paul
>
