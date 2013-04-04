From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: MAX_LOCKDEP_ENTRIES too low!
Date: Thu, 04 Apr 2013 12:24:15 +0200
Message-ID: <2490203.uLrt7BxRl5@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758165Ab3DDKYW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 06:24:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

booting a 3.8.5 patched with 3.8.4-rt2 I get something like this dmesg'ed: 
...
[  105.901078] BUG: MAX_LOCKDEP_ENTRIES too low!
[  105.901079] turning off the locking correctness validator.
[  105.901083] Pid: 3213, comm: mysqld Not tainted 3.8.5-rt2+ #3
[  105.901084] Call Trace:
[  105.901094]  [<ffffffff8107d1b6>] 
add_lock_to_list.isra.22.constprop.37+0x45/0x9d
[  105.901098]  [<ffffffff8107f1a3>] __lock_acquire+0xc55/0xde2
[  105.901104]  [<ffffffff814c993f>] ? _raw_spin_unlock+0x61/0x6e
[  105.901107]  [<ffffffff814c8ac1>] ? rt_spin_lock_slowlock+0x8a/0x27c
[  105.901110]  [<ffffffff814c9911>] ? _raw_spin_unlock+0x33/0x6e
[  105.901113]  [<ffffffff814c9911>] ? _raw_spin_unlock+0x33/0x6e
[  105.901117]  [<ffffffff810dd01f>] ? __local_lock+0x28/0x77
[  105.901121]  [<ffffffff8107f7a4>] lock_acquire+0xc4/0x112
[  105.901124]  [<ffffffff810dd01f>] ? __local_lock+0x28/0x77
[  105.901127]  [<ffffffff814c90fa>] rt_spin_lock+0x39/0x40
[  105.901130]  [<ffffffff810dd01f>] ? __local_lock+0x28/0x77
[  105.901135]  [<ffffffff81062741>] ? migrate_disable+0xeb/0xf9
[  105.901138]  [<ffffffff810dd01f>] __local_lock+0x28/0x77
[  105.901142]  [<ffffffff810de1e5>] lru_add_drain+0x2e/0x5a
[  105.901145]  [<ffffffff810de224>] __pagevec_release+0x13/0x2e
[  105.901149]  [<ffffffff810de2b0>] pagevec_release+0xe/0x10
[  105.901153]  [<ffffffff810de7e5>] truncate_inode_pages_range+0x12a/0x347
[  105.901156]  [<ffffffff814c9911>] ? _raw_spin_unlock+0x33/0x6e
[  105.901158]  [<ffffffff814c8d60>] ? rt_spin_lock_slowunlock+0x47/0x66
[  105.901163]  [<ffffffff810b7140>] ? trace_preempt_on+0x1e/0x3b
[  105.901167]  [<ffffffff810625dc>] ? migrate_enable+0x156/0x1d0
[  105.901170]  [<ffffffff810625dc>] ? migrate_enable+0x156/0x1d0
[  105.901175]  [<ffffffff81169456>] ? __dquot_initialize+0x25/0x11d
[  105.901179]  [<ffffffff810dea73>] truncate_inode_pages+0x12/0x14
[  105.901182]  [<ffffffff811b0eda>] ext4_evict_inode+0xf3/0x333
[  105.901186]  [<ffffffff811305b7>] evict+0xaa/0x16e
[  105.901189]  [<ffffffff81130eb5>] iput+0x144/0x14d
[  105.901192]  [<ffffffff81126316>] do_unlinkat+0x14a/0x1e4
[  105.901197]  [<ffffffff8107fbfb>] ? trace_hardirqs_on_caller+0x12d/0x164
[  105.901200]  [<ffffffff81263a3e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[  105.901203]  [<ffffffff81127e27>] sys_unlink+0x16/0x18
[  105.901207]  [<ffffffff814d0119>] system_call_fastpath+0x16/0x1b
...
It's repeatable in the sense of showing up at system start. It points mostly  
at a different program for causing the problem. Common seems to be something 
filesystem related as reported here:
[  105.901182]  [<ffffffff811b0eda>] ext4_evict_inode+0xf3/0x333

Digging a little bit I found this thread as an example:
http://www.kernelhub.org/?p=2&msg=147179
showing that there may be real bugs hidden behind such messages.

My questions:
1.) Does it make sense to dig a little big deeper?
(I'am not a experienced kernelhacker, last -rt was a 3.6.5-rt11)
2.) If 1.) : How to proceed?

Thanks in advance!

Bernhard

