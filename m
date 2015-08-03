From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Mon, 3 Aug 2015 08:19:59 +0200
Message-ID: <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
	<20150714150016.GC21820@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36680 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbHCGUB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Aug 2015 02:20:01 -0400
Received: by lbbud7 with SMTP id ud7so68336177lbb.3
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Aug 2015 23:19:59 -0700 (PDT)
In-Reply-To: <20150714150016.GC21820@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> This seems to be always cgroup_mutex mutex it blocks on. SysRq d (show
> all locks) should be able to show you who has the lock.

I could reproduce the lockup with cgroup stuff again, this time I with
information about locks.

[14406.842236] INFO: task kswork:69 blocked for more than 120 seconds.
[14406.842240]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14406.842241] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14406.842243] kswork          D ffff8803fbf1c500     0    69      2 0x00000000
[14406.842247]  ffff8804015e3c18 0000000000000092 00000000015e3c18
ffff8804015e3fd8
[14406.842248]  ffff8804015e3fd8 ffff8804015e3fd8 ffff8804015e3fd8
ffff8804015e3ce0
[14406.842249]  ffff880401928000 ffff8804015d8000 ffff8804015e3c38
ffff8804015d8000
[14406.842250] Call Trace:
[14406.842256]  [<ffffffff81732694>] schedule+0x34/0xa0
[14406.842257]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14406.842258]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14406.842259]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14406.842260]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14406.842263]  [<ffffffff810e3d4f>] ? css_release_work_fn+0x2f/0xd0
[14406.842265]  [<ffffffff810e3d4f>] css_release_work_fn+0x2f/0xd0
[14406.842268]  [<ffffffff81092a7a>] swork_kthread+0xfa/0x150
[14406.842269]  [<ffffffff81092980>] ? swork_readable+0x40/0x40
[14406.842272]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14406.842273]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14406.842275]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14406.842276]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14406.842278]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14406.842279] 1 lock held by kswork/69:
[14406.842283]  #0:  (cgroup_mutex){......}, at: [<ffffffff810e3d4f>]
css_release_work_fn+0x2f/0xd0
[14406.842324] INFO: task kworker/3:0:10502 blocked for more than 120 seconds.
[14406.842326]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14406.842326] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14406.842327] kworker/3:0     D ffff8803a9426d40     0 10502      2 0x00000000
[14406.842331] Workqueue: cgroup_destroy css_killed_work_fn
[14406.842333]  ffff8803a947fb98 0000000000000096 00000000a947fb98
ffff8803a947ffd8
[14406.842334]  ffff8803a947ffd8 ffff8803a947ffd8 ffff8803a947ffd8
ffffffff81d25470
[14406.842334]  ffff8803dace0000 ffff8800995f2290 ffff8803a947fbb8
ffff8800995f2290
[14406.842336] Call Trace:
[14406.842338]  [<ffffffff81732694>] schedule+0x34/0xa0
[14406.842338]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14406.842339]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14406.842340]  [<ffffffff8173443e>] ? rt_spin_lock_slowlock+0x5e/0x2c0
[14406.842341]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14406.842342]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14406.842343]  [<ffffffff810e549f>] ? css_killed_work_fn+0x1f/0x170
[14406.842344]  [<ffffffff810e549f>] css_killed_work_fn+0x1f/0x170
[14406.842346]  [<ffffffff8106a92a>] process_one_work+0x1fa/0x5b0
[14406.842347]  [<ffffffff8106a88d>] ? process_one_work+0x15d/0x5b0
[14406.842348]  [<ffffffff8106ae4b>] worker_thread+0x16b/0x4c0
[14406.842349]  [<ffffffff8106ace0>] ? process_one_work+0x5b0/0x5b0
[14406.842350]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14406.842351]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14406.842353]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14406.842354]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14406.842355]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14406.842356] 3 locks held by kworker/3:0/10502:
[14406.842361]  #0:  ("cgroup_destroy"){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14406.842364]  #1:  ((&css->destroy_work)){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14406.842367]  #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>]
css_killed_work_fn+0x1f/0x170
[14406.842375] INFO: task lxc-start:21854 blocked for more than 120 seconds.
[14406.842376]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14406.842377] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14406.842377] lxc-start       D ffff8803a9422840     0 21854  21848 0x00000000
[14406.842380]  ffff880401b33c48 0000000000000096 0000000001b33c48
ffff880401b33fd8
[14406.842380]  ffff880401b33fd8 ffff880401b33fd8 ffff880401b33fd8
ffff880401b33d10
[14406.842381]  ffff880401940000 ffff8803a7f38000 ffff880401b33c68
ffff8803a7f38000
[14406.842382] Call Trace:
[14406.842384]  [<ffffffff81732694>] schedule+0x34/0xa0
[14406.842385]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14406.842386]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14406.842387]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14406.842387]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14406.842389]  [<ffffffff810ea122>] ? proc_cgroup_show+0x52/0x200
[14406.842390]  [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
[14406.842393]  [<ffffffff81215b64>] proc_single_show+0x54/0xa0
[14406.842395]  [<ffffffff811d082d>] seq_read+0xed/0x380
[14406.842397]  [<ffffffff811aa32f>] vfs_read+0x9f/0x180
[14406.842398]  [<ffffffff811aaea9>] SyS_read+0x49/0xb0
[14406.842399]  [<ffffffff81736936>] system_call_fastpath+0x16/0x1b
[14406.842399] 2 locks held by lxc-start/21854:
[14406.842403]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[14406.842406]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[14406.842409] INFO: task lxc-ls:21856 blocked for more than 120 seconds.
[14406.842410]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14406.842411] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14406.842411] lxc-ls          D ffff8803a9565640     0 21856  21855 0x00000000
[14406.842414]  ffff8803b1103c48 0000000000000096 00000000b1103c48
ffff8803b1103fd8
[14406.842415]  ffff8803b1103fd8 ffff8803b1103fd8 ffff8803b1103fd8
ffff8803b1103d10
[14406.842415]  ffff880401942290 ffff8803ad9e4520 ffff8803b1103c68
ffff8803ad9e4520
[14406.842417] Call Trace:
[14406.842418]  [<ffffffff81732694>] schedule+0x34/0xa0
[14406.842419]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14406.842420]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14406.842421]  [<ffffffff810ea103>] ? proc_cgroup_show+0x33/0x200
[14406.842422]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14406.842423]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14406.842424]  [<ffffffff810ea122>] ? proc_cgroup_show+0x52/0x200
[14406.842425]  [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
[14406.842426]  [<ffffffff81215b64>] proc_single_show+0x54/0xa0
[14406.842427]  [<ffffffff811d082d>] seq_read+0xed/0x380
[14406.842428]  [<ffffffff811aa32f>] vfs_read+0x9f/0x180
[14406.842429]  [<ffffffff811aaea9>] SyS_read+0x49/0xb0
[14406.842430]  [<ffffffff81736936>] system_call_fastpath+0x16/0x1b
[14406.842430] 2 locks held by lxc-ls/21856:
[14406.842435]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[14406.842437]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[14526.897563] INFO: task kswork:69 blocked for more than 120 seconds.
[14526.897570]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14526.897572] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14526.897575] kswork          D ffff8803fbf1c500     0    69      2 0x00000000
[14526.897583]  ffff8804015e3c18 0000000000000092 00000000015e3c18
ffff8804015e3fd8
[14526.897585]  ffff8804015e3fd8 ffff8804015e3fd8 ffff8804015e3fd8
ffff8804015e3ce0
[14526.897586]  ffff880401928000 ffff8804015d8000 ffff8804015e3c38
ffff8804015d8000
[14526.897590] Call Trace:
[14526.897611]  [<ffffffff81732694>] schedule+0x34/0xa0
[14526.897613]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14526.897614]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14526.897616]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14526.897617]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14526.897621]  [<ffffffff810e3d4f>] ? css_release_work_fn+0x2f/0xd0
[14526.897622]  [<ffffffff810e3d4f>] css_release_work_fn+0x2f/0xd0
[14526.897624]  [<ffffffff81092a7a>] swork_kthread+0xfa/0x150
[14526.897625]  [<ffffffff81092980>] ? swork_readable+0x40/0x40
[14526.897628]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14526.897629]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14526.897631]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14526.897632]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14526.897633]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14526.897634] 1 lock held by kswork/69:
[14526.897639]  #0:  (cgroup_mutex){......}, at: [<ffffffff810e3d4f>]
css_release_work_fn+0x2f/0xd0
[14526.897680] INFO: task kworker/3:0:10502 blocked for more than 120 seconds.
[14526.897682]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14526.897682] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14526.897683] kworker/3:0     D ffff8803a9426d40     0 10502      2 0x00000000
[14526.897687] Workqueue: cgroup_destroy css_killed_work_fn
[14526.897689]  ffff8803a947fb98 0000000000000096 00000000a947fb98
ffff8803a947ffd8
[14526.897690]  ffff8803a947ffd8 ffff8803a947ffd8 ffff8803a947ffd8
ffffffff81d25470
[14526.897690]  ffff8803dace0000 ffff8800995f2290 ffff8803a947fbb8
ffff8800995f2290
[14526.897692] Call Trace:
[14526.897694]  [<ffffffff81732694>] schedule+0x34/0xa0
[14526.897694]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14526.897695]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14526.897696]  [<ffffffff8173443e>] ? rt_spin_lock_slowlock+0x5e/0x2c0
[14526.897697]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14526.897698]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14526.897700]  [<ffffffff810e549f>] ? css_killed_work_fn+0x1f/0x170
[14526.897701]  [<ffffffff810e549f>] css_killed_work_fn+0x1f/0x170
[14526.897702]  [<ffffffff8106a92a>] process_one_work+0x1fa/0x5b0
[14526.897703]  [<ffffffff8106a88d>] ? process_one_work+0x15d/0x5b0
[14526.897705]  [<ffffffff8106ae4b>] worker_thread+0x16b/0x4c0
[14526.897706]  [<ffffffff8106ace0>] ? process_one_work+0x5b0/0x5b0
[14526.897707]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14526.897708]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14526.897710]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14526.897711]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14526.897712]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14526.897713] 3 locks held by kworker/3:0/10502:
[14526.897719]  #0:  ("cgroup_destroy"){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14526.897722]  #1:  ((&css->destroy_work)){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14526.897724]  #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>]
css_killed_work_fn+0x1f/0x170
[14526.897732] INFO: task lxc-start:21854 blocked for more than 120 seconds.
[14526.897733]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14526.897734] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14526.897735] lxc-start       D ffff8803a9422840     0 21854  21848 0x00000000
[14526.897737]  ffff880401b33c48 0000000000000096 0000000001b33c48
ffff880401b33fd8
[14526.897738]  ffff880401b33fd8 ffff880401b33fd8 ffff880401b33fd8
ffff880401b33d10
[14526.897739]  ffff880401940000 ffff8803a7f38000 ffff880401b33c68
ffff8803a7f38000
[14526.897740] Call Trace:
[14526.897742]  [<ffffffff81732694>] schedule+0x34/0xa0
[14526.897742]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14526.897743]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14526.897744]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14526.897745]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14526.897747]  [<ffffffff810ea122>] ? proc_cgroup_show+0x52/0x200
[14526.897748]  [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
[14526.897751]  [<ffffffff81215b64>] proc_single_show+0x54/0xa0
[14526.897753]  [<ffffffff811d082d>] seq_read+0xed/0x380
[14526.897754]  [<ffffffff811aa32f>] vfs_read+0x9f/0x180
[14526.897755]  [<ffffffff811aaea9>] SyS_read+0x49/0xb0
[14526.897756]  [<ffffffff81736936>] system_call_fastpath+0x16/0x1b
[14526.897757] 2 locks held by lxc-start/21854:
[14526.897761]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[14526.897764]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[14526.897767] INFO: task lxc-ls:21856 blocked for more than 120 seconds.
[14526.897768]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14526.897769] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14526.897770] lxc-ls          D ffff8803a9565640     0 21856  21855 0x00000000
[14526.897772]  ffff8803b1103c48 0000000000000096 00000000b1103c48
ffff8803b1103fd8
[14526.897773]  ffff8803b1103fd8 ffff8803b1103fd8 ffff8803b1103fd8
ffff8803b1103d10
[14526.897773]  ffff880401942290 ffff8803ad9e4520 ffff8803b1103c68
ffff8803ad9e4520
[14526.897775] Call Trace:
[14526.897777]  [<ffffffff81732694>] schedule+0x34/0xa0
[14526.897777]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14526.897778]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14526.897779]  [<ffffffff810ea103>] ? proc_cgroup_show+0x33/0x200
[14526.897780]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14526.897781]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14526.897782]  [<ffffffff810ea122>] ? proc_cgroup_show+0x52/0x200
[14526.897783]  [<ffffffff810ea122>] proc_cgroup_show+0x52/0x200
[14526.897785]  [<ffffffff81215b64>] proc_single_show+0x54/0xa0
[14526.897786]  [<ffffffff811d082d>] seq_read+0xed/0x380
[14526.897787]  [<ffffffff811aa32f>] vfs_read+0x9f/0x180
[14526.897788]  [<ffffffff811aaea9>] SyS_read+0x49/0xb0
[14526.897789]  [<ffffffff81736936>] system_call_fastpath+0x16/0x1b
[14526.897789] 2 locks held by lxc-ls/21856:
[14526.897793]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[14526.897796]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[14646.952905] INFO: task kswork:69 blocked for more than 120 seconds.
[14646.952912]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14646.952914] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14646.952917] kswork          D ffff8803fbf1c500     0    69      2 0x00000000
[14646.952925]  ffff8804015e3c18 0000000000000092 00000000015e3c18
ffff8804015e3fd8
[14646.952926]  ffff8804015e3fd8 ffff8804015e3fd8 ffff8804015e3fd8
ffff8804015e3ce0
[14646.952928]  ffff880401928000 ffff8804015d8000 ffff8804015e3c38
ffff8804015d8000
[14646.952932] Call Trace:
[14646.952941]  [<ffffffff81732694>] schedule+0x34/0xa0
[14646.952944]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14646.952946]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14646.952948]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14646.952951]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14646.952956]  [<ffffffff810e3d4f>] ? css_release_work_fn+0x2f/0xd0
[14646.952960]  [<ffffffff810e3d4f>] css_release_work_fn+0x2f/0xd0
[14646.952965]  [<ffffffff81092a7a>] swork_kthread+0xfa/0x150
[14646.952968]  [<ffffffff81092980>] ? swork_readable+0x40/0x40
[14646.952972]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14646.952976]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14646.952979]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14646.952982]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14646.952985]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14646.952987] 1 lock held by kswork/69:
[14646.952997]  #0:  (cgroup_mutex){......}, at: [<ffffffff810e3d4f>]
css_release_work_fn+0x2f/0xd0
[14646.953052] INFO: task kworker/3:0:10502 blocked for more than 120 seconds.
[14646.953054]       Tainted: G            E  3.18.17-realtime-2-rt14 #3
[14646.953054] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[14646.953055] kworker/3:0     D ffff8803a9426d40     0 10502      2 0x00000000
[14646.953059] Workqueue: cgroup_destroy css_killed_work_fn
[14646.953060]  ffff8803a947fb98 0000000000000096 00000000a947fb98
ffff8803a947ffd8
[14646.953061]  ffff8803a947ffd8 ffff8803a947ffd8 ffff8803a947ffd8
ffffffff81d25470
[14646.953062]  ffff8803dace0000 ffff8800995f2290 ffff8803a947fbb8
ffff8800995f2290
[14646.953063] Call Trace:
[14646.953065]  [<ffffffff81732694>] schedule+0x34/0xa0
[14646.953066]  [<ffffffff81733dd5>] __rt_mutex_slowlock+0x55/0x1c0
[14646.953067]  [<ffffffff81734045>] rt_mutex_slowlock+0x105/0x320
[14646.953067]  [<ffffffff8173443e>] ? rt_spin_lock_slowlock+0x5e/0x2c0
[14646.953068]  [<ffffffff8173427a>] rt_mutex_lock+0x1a/0x20
[14646.953069]  [<ffffffff81735f19>] _mutex_lock+0x39/0x40
[14646.953070]  [<ffffffff810e549f>] ? css_killed_work_fn+0x1f/0x170
[14646.953071]  [<ffffffff810e549f>] css_killed_work_fn+0x1f/0x170
[14646.953073]  [<ffffffff8106a92a>] process_one_work+0x1fa/0x5b0
[14646.953074]  [<ffffffff8106a88d>] ? process_one_work+0x15d/0x5b0
[14646.953075]  [<ffffffff8106ae4b>] worker_thread+0x16b/0x4c0
[14646.953076]  [<ffffffff8106ace0>] ? process_one_work+0x5b0/0x5b0
[14646.953077]  [<ffffffff81070036>] kthread+0xd6/0xf0
[14646.953078]  [<ffffffff8107581f>] ? finish_task_switch+0x3f/0x140
[14646.953080]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14646.953080]  [<ffffffff81736888>] ret_from_fork+0x58/0x90
[14646.953082]  [<ffffffff8106ff60>] ? kthread_create_on_node+0x220/0x220
[14646.953083] 3 locks held by kworker/3:0/10502:
[14646.953088]  #0:  ("cgroup_destroy"){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14646.953091]  #1:  ((&css->destroy_work)){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[14646.953094]  #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>]
css_killed_work_fn+0x1f/0x170



[16929.175280] SysRq : Show Locks Held
[16929.175286]
[16929.175286] Showing all locks held in the system:
[16929.175301] 1 lock held by kswork/69:
[16929.175302]  #0:  (cgroup_mutex){......}, at: [<ffffffff810e3d4f>]
css_release_work_fn+0x2f/0xd0
[16929.175316] 2 locks held by systemd-logind/583:
[16929.175317]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[16929.175321]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[16929.175327] 1 lock held by in:imklog/620:
[16929.175327]  #0:  (&f->f_pos_lock){......}, at:
[<ffffffff811ca69a>] __fdget_pos+0x4a/0x50
[16929.175334] 3 locks held by polkitd/913:
[16929.175334]  #0:  (&f->f_pos_lock){......}, at:
[<ffffffff811ca69a>] __fdget_pos+0x4a/0x50
[16929.175337]  #1:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[16929.175340]  #2:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[16929.175346] 2 locks held by getty/1095:
[16929.175347]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175351]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175355] 2 locks held by getty/1098:
[16929.175356]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175358]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175362] 2 locks held by getty/1106:
[16929.175363]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175365]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175368] 2 locks held by getty/1107:
[16929.175369]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175371]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175375] 2 locks held by getty/1110:
[16929.175375]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175378]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175384] 2 locks held by getty/1749:
[16929.175385]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175387]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175415] 1 lock held by rsyslogd/3299:
[16929.175415]  #0:  (&f->f_pos_lock){......}, at:
[<ffffffff811ca69a>] __fdget_pos+0x4a/0x50
[16929.175420] 2 locks held by getty/3445:
[16929.175421]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175423]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175427] 2 locks held by getty/3452:
[16929.175427]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175429]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175433] 2 locks held by getty/3455:
[16929.175433]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175436]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175440] 2 locks held by getty/3513:
[16929.175441]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175443]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175446] 2 locks held by getty/3515:
[16929.175446]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175449]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175457] 2 locks held by zsh/14000:
[16929.175457]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175460]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175464] 2 locks held by zsh/7684:
[16929.175464]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175466]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175470] 3 locks held by kworker/3:0/10502:
[16929.175470]  #0:  ("cgroup_destroy"){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[16929.175476]  #1:  ((&css->destroy_work)){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[16929.175478]  #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>]
css_killed_work_fn+0x1f/0x170
[16929.175484] 1 lock held by rsyslogd/16108:
[16929.175485]  #0:  (&f->f_pos_lock){......}, at:
[<ffffffff811ca69a>] __fdget_pos+0x4a/0x50
[16929.175489] 2 locks held by getty/16596:
[16929.175490]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175492]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175496] 2 locks held by getty/16601:
[16929.175497]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175499]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175502] 2 locks held by getty/16603:
[16929.175503]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175505]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175509] 2 locks held by getty/16621:
[16929.175509]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175511]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175514] 2 locks held by getty/16627:
[16929.175515]  #0:  (&tty->ldisc_sem){......}, at:
[<ffffffff81451334>] tty_ldisc_ref_wait+0x24/0x60
[16929.175517]  #1:  (&ldata->atomic_read_lock){......}, at:
[<ffffffff8144cbce>] n_tty_read+0xae/0xb90
[16929.175521] 3 locks held by kworker/2:3/19520:
[16929.175522]  #0:  ("cgroup_destroy"){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[16929.175524]  #1:  ((&css->destroy_work)){......}, at:
[<ffffffff8106a88d>] process_one_work+0x15d/0x5b0
[16929.175527]  #2:  (cgroup_mutex){......}, at: [<ffffffff810e549f>]
css_killed_work_fn+0x1f/0x170
[16929.175531] 2 locks held by lxc-start/21854:
[16929.175531]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[16929.175534]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[16929.175538] 2 locks held by lxc-ls/21856:
[16929.175539]  #0:  (&p->lock){......}, at: [<ffffffff811d077b>]
seq_read+0x3b/0x380
[16929.175545]  #1:  (cgroup_mutex){......}, at: [<ffffffff810ea122>]
proc_cgroup_show+0x52/0x200
[16929.175554] 3 locks held by bash/10002:
[16929.175555]  #0:  (sb_writers#6){......}, at: [<ffffffff811aa5c3>]
vfs_write+0x1b3/0x1f0
[16929.175559]  #1:  (rcu_read_lock){......}, at: [<ffffffff81455f45>]
__handle_sysrq+0x5/0x1b0
[16929.175563]  #2:  (tasklist_lock){......}, at: [<ffffffff8109a923>]
debug_show_all_locks+0x43/0x1e0
