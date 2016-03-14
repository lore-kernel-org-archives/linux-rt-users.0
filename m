From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Mon, 14 Mar 2016 18:00:58 -0300
Message-ID: <20160314210058.GE29798@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36312 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307AbcCNVBD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 17:01:03 -0400
Received: by mail-qg0-f43.google.com with SMTP id u110so165326799qge.3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Mar 2016 14:01:02 -0700 (PDT)
Received: from lclaudio.dyndns.org (179.176.232.10.dynamic.adsl.gvt.net.br. [179.176.232.10])
        by smtp.gmail.com with ESMTPSA id 139sm11112644qho.2.2016.03.14.14.01.01
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 14:01:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I just started using 4.4.4-rt11 this afternoon and saw the lockdep splat below.
Is this something new or did I miss a patch floating on the list?

[67547.917898] =============================================
[67547.917898] [ INFO: possible recursive locking detected ]
[67547.917900] 4.4.4-rt11 #4 Not tainted
[67547.917900] ---------------------------------------------
[67547.917901] kswapd0/59 is trying to acquire lock:
[67547.917908]  (&h->lock#2){+.+.-.}, at: [<ffffffff812934dc>] mb_cache_shrink_scan+0xac/0x220
[67547.917908] 
               but task is already holding lock:
[67547.917910]  (&h->lock#2){+.+.-.}, at: [<ffffffff812934ca>] mb_cache_shrink_scan+0x9a/0x220
[67547.917911] 
               other info that might help us debug this:
[67547.917911]  Possible unsafe locking scenario:

[67547.917911]        CPU0
[67547.917911]        ----
[67547.917912]   lock(&h->lock#2);
[67547.917913]   lock(&h->lock#2);
[67547.917913] 
                *** DEADLOCK ***

[67547.917913]  May be due to missing lock nesting notation

[67547.917914] 2 locks held by kswapd0/59:
[67547.917917]  #0:  (shrinker_rwsem){+.+...}, at: [<ffffffff810e77d2>] rt_down_read_trylock+0x22/0x30
[67547.917919]  #1:  (&h->lock#2){+.+.-.}, at: [<ffffffff812934ca>] mb_cache_shrink_scan+0x9a/0x220
[67547.917920] 
               stack backtrace:
[67547.917921] CPU: 0 PID: 59 Comm: kswapd0 Not tainted 4.4.4-rt11 #4
[67547.917922] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[67547.917923]  0000000000000086 000000005fca2e71 ffff88018a9fba10 ffffffff813d5412
[67547.917925]  ffffffff828ede50 ffff88018a9f4000 ffff88018a9fbb00 ffffffff810e0d66
[67547.917926]  ffff88018a9fbb08 000000000000008a ffffffff828e58a0 ffffffff81c0bf18
[67547.917926] Call Trace:
[67547.917929]  [<ffffffff813d5412>] dump_stack+0x67/0x95
[67547.917931]  [<ffffffff810e0d66>] __lock_acquire+0x1cf6/0x1d30
[67547.917934]  [<ffffffff813f55d7>] ? debug_smp_processor_id+0x17/0x20
[67547.917936]  [<ffffffff810deb49>] ? mark_held_locks+0x79/0xa0
[67547.917940]  [<ffffffff817dc0cc>] ? _raw_spin_unlock_irqrestore+0x6c/0x80
[67547.917941]  [<ffffffff810e1907>] lock_acquire+0xf7/0x240
[67547.917942]  [<ffffffff812934dc>] ? mb_cache_shrink_scan+0xac/0x220
[67547.917944]  [<ffffffff817dbb11>] _raw_spin_lock+0x41/0x80
[67547.917945]  [<ffffffff812934dc>] ? mb_cache_shrink_scan+0xac/0x220
[67547.917946]  [<ffffffff812934dc>] mb_cache_shrink_scan+0xac/0x220
[67547.917949]  [<ffffffff811bfaaa>] shrink_slab.part.41+0x24a/0x600
[67547.917951]  [<ffffffff811c479a>] shrink_zone+0x2ca/0x2e0
[67547.917953]  [<ffffffff811c5ee1>] kswapd+0x581/0xbc0
[67547.917955]  [<ffffffff811c5960>] ? mem_cgroup_shrink_node_zone+0x3c0/0x3c0
[67547.917957]  [<ffffffff810a9b71>] kthread+0x101/0x120
[67547.917959]  [<ffffffff810a9a70>] ? kthread_create_on_node+0x250/0x250
[67547.917960]  [<ffffffff817dcfff>] ret_from_fork+0x3f/0x70
[67547.917962]  [<ffffffff810a9a70>] ? kthread_create_on_node+0x250/0x250
 
Best regards,
Luis
