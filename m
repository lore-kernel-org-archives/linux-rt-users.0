From: Christoph Mathys <eraserix@gmail.com>
Subject: Hung task for proc_cgroup_show
Date: Tue, 14 Jul 2015 16:40:16 +0200
Message-ID: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f66.google.com ([209.85.215.66]:32872 "EHLO
	mail-la0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbGNOkS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 10:40:18 -0400
Received: by lahh5 with SMTP id h5so509410lah.0
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 07:40:16 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi there!

I just tried out lxc (Linux Containers) with 3.18.17-rt14. After some
time (~20min) the lxc-commands stop working. I got the following trace
from dmesg. Any ideas whats causing it and how to fix it besides a
reboot? I used the same version of lxc with 3.12-rt with no (I think)
rt-specific problems.

[ 1200.764167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1200.764168] lxc-destroy     D ffff88040eae2680     0 15783  15775 0x00000004
[ 1200.764169]  ffff880202697c88 0000000000000086 ffff880202697fd8
ffff880202697fd8
[ 1200.764170]  ffff880202697fd8 0000000000062680 ffff8804078c0000
ffff88028db18000
[ 1200.764171]  ffff880202697dd8 ffff88028db18000 ffff88028db18000
0000000000000000
[ 1200.764172] Call Trace:
[ 1200.764173]  [<ffffffff816face4>] schedule+0x34/0xa0
[ 1200.764174]  [<ffffffff816fc2d6>] __rt_mutex_slowlock+0xe6/0x180
[ 1200.764175]  [<ffffffff816fc99a>] rt_mutex_slowlock+0x12a/0x310
[ 1200.764176]  [<ffffffff8115f1b4>] ? vma_merge+0xf4/0x330
[ 1200.764177]  [<ffffffff8115f7ef>] ? vma_set_page_prot+0x3f/0x60
[ 1200.764178]  [<ffffffff816fcc31>] rt_mutex_lock+0x31/0x40
[ 1200.764179]  [<ffffffff816fdfce>] _mutex_lock+0xe/0x10
[ 1200.764180]  [<ffffffff810de2e2>] proc_cgroup_show+0x52/0x200
[ 1200.764180]  [<ffffffff81200941>] proc_single_show+0x51/0xa0
[ 1200.764182]  [<ffffffff811bcdfa>] seq_read+0xea/0x370
[ 1200.764182]  [<ffffffff811980dc>] vfs_read+0x9c/0x180
[ 1200.764183]  [<ffffffff81198c59>] SyS_read+0x49/0xb0
[ 1200.764184]  [<ffffffff81197d91>] ? SyS_lseek+0x91/0xb0
[ 1200.764185]  [<ffffffff816fe676>] system_call_fastpath+0x16/0x1b

Thanks.
Christoph
