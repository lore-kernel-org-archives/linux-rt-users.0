From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Tue, 14 Jul 2015 16:45:12 +0200
Message-ID: <CALqGcGqoO-UsnZdpCw7ukJpqs1O+7XuJpqCFb5vMXd=6DP0UcQ@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36807 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbGNOpO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 10:45:14 -0400
Received: by lblf12 with SMTP id f12so516701lbl.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 07:45:12 -0700 (PDT)
In-Reply-To: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry, I've just seen that I might have left out an important bit, so
here another, more complete message:

[ 1080.708465] INFO: task kswork:69 blocked for more than 120 seconds.
[ 1080.708471]       Tainted: G            E  3.18.17-realtime-1-rt14 #2
[ 1080.708473] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1080.708475] kswork          D ffff88040e862680     0    69      2 0x00000000
[ 1080.708482]  ffff880407543cb8 0000000000000046 ffff880407543fd8
ffff880407543fd8
[ 1080.708484]  ffff880407543fd8 0000000000062680 ffffffff81c1a480
ffff88040749cd40
[ 1080.708486]  ffff880407543ca8 ffff88040749cd40 ffff88040749cd40
0000000000000000
[ 1080.708489] Call Trace:
[ 1080.708497]  [<ffffffff816face4>] schedule+0x34/0xa0
[ 1080.708500]  [<ffffffff816fc2d6>] __rt_mutex_slowlock+0xe6/0x180
[ 1080.708504]  [<ffffffff816fc99a>] rt_mutex_slowlock+0x12a/0x310
[ 1080.708507]  [<ffffffff816fcc31>] rt_mutex_lock+0x31/0x40
[ 1080.708510]  [<ffffffff816fdfce>] _mutex_lock+0xe/0x10
[ 1080.708514]  [<ffffffff810d8d3f>] css_release_work_fn+0x2f/0xd0
[ 1080.708518]  [<ffffffff8108e59a>] swork_kthread+0xfa/0x150
[ 1080.708520]  [<ffffffff8108e4a0>] ? swork_readable+0x40/0x40
[ 1080.708524]  [<ffffffff8106c8fb>] kthread+0xbb/0xe0
[ 1080.708527]  [<ffffffff8106c840>] ? kthread_worker_fn+0x190/0x190
[ 1080.708530]  [<ffffffff816fe5c8>] ret_from_fork+0x58/0x90
[ 1080.708533]  [<ffffffff8106c840>] ? kthread_worker_fn+0x190/0x190
[ 1080.708591] INFO: task lxc-ls:15615 blocked for more than 120 seconds.
[ 1080.708595]       Tainted: G            E  3.18.17-realtime-1-rt14 #2
[ 1080.708595] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1080.708596] lxc-ls          D ffff88040ebe2680     0 15615  15614 0x00000004
[ 1080.708598]  ffff88009219bc88 0000000000000086 ffff88009219bfd8
ffff88009219bfd8
[ 1080.708599]  ffff88009219bfd8 0000000000062680 ffff8804078c3380
ffff880035f499c0
[ 1080.708600]  ffff88009219bdd8 ffff880035f499c0 ffff880035f499c0
0000000000000000
[ 1080.708601] Call Trace:
[ 1080.708602]  [<ffffffff816face4>] schedule+0x34/0xa0
[ 1080.708603]  [<ffffffff816fc2d6>] __rt_mutex_slowlock+0xe6/0x180
[ 1080.708604]  [<ffffffff816fc99a>] rt_mutex_slowlock+0x12a/0x310
[ 1080.708607]  [<ffffffff8115f7ef>] ? vma_set_page_prot+0x3f/0x60
[ 1080.708608]  [<ffffffff816fcc31>] rt_mutex_lock+0x31/0x40
[ 1080.708609]  [<ffffffff816fdfce>] _mutex_lock+0xe/0x10
[ 1080.708610]  [<ffffffff810de2e2>] proc_cgroup_show+0x52/0x200
[ 1080.708612]  [<ffffffff81200941>] proc_single_show+0x51/0xa0
[ 1080.708615]  [<ffffffff811bcdfa>] seq_read+0xea/0x370
[ 1080.708616]  [<ffffffff811980dc>] vfs_read+0x9c/0x180
[ 1080.708617]  [<ffffffff81198c59>] SyS_read+0x49/0xb0
[ 1080.708617]  [<ffffffff81197d91>] ? SyS_lseek+0x91/0xb0
[ 1080.708619]  [<ffffffff816fe676>] system_call_fastpath+0x16/0x1b

On Tue, Jul 14, 2015 at 4:40 PM, Christoph Mathys <eraserix@gmail.com> wrote:
> Hi there!
>
> I just tried out lxc (Linux Containers) with 3.18.17-rt14. After some
> time (~20min) the lxc-commands stop working. I got the following trace
> from dmesg. Any ideas whats causing it and how to fix it besides a
> reboot? I used the same version of lxc with 3.12-rt with no (I think)
> rt-specific problems.
>
> [ 1200.764167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1200.764168] lxc-destroy     D ffff88040eae2680     0 15783  15775 0x00000004
> [ 1200.764169]  ffff880202697c88 0000000000000086 ffff880202697fd8
> ffff880202697fd8
> [ 1200.764170]  ffff880202697fd8 0000000000062680 ffff8804078c0000
> ffff88028db18000
> [ 1200.764171]  ffff880202697dd8 ffff88028db18000 ffff88028db18000
> 0000000000000000
> [ 1200.764172] Call Trace:
> [ 1200.764173]  [<ffffffff816face4>] schedule+0x34/0xa0
> [ 1200.764174]  [<ffffffff816fc2d6>] __rt_mutex_slowlock+0xe6/0x180
> [ 1200.764175]  [<ffffffff816fc99a>] rt_mutex_slowlock+0x12a/0x310
> [ 1200.764176]  [<ffffffff8115f1b4>] ? vma_merge+0xf4/0x330
> [ 1200.764177]  [<ffffffff8115f7ef>] ? vma_set_page_prot+0x3f/0x60
> [ 1200.764178]  [<ffffffff816fcc31>] rt_mutex_lock+0x31/0x40
> [ 1200.764179]  [<ffffffff816fdfce>] _mutex_lock+0xe/0x10
> [ 1200.764180]  [<ffffffff810de2e2>] proc_cgroup_show+0x52/0x200
> [ 1200.764180]  [<ffffffff81200941>] proc_single_show+0x51/0xa0
> [ 1200.764182]  [<ffffffff811bcdfa>] seq_read+0xea/0x370
> [ 1200.764182]  [<ffffffff811980dc>] vfs_read+0x9c/0x180
> [ 1200.764183]  [<ffffffff81198c59>] SyS_read+0x49/0xb0
> [ 1200.764184]  [<ffffffff81197d91>] ? SyS_lseek+0x91/0xb0
> [ 1200.764185]  [<ffffffff816fe676>] system_call_fastpath+0x16/0x1b
>
> Thanks.
> Christoph
