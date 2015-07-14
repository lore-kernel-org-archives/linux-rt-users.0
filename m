From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hung task for proc_cgroup_show
Date: Tue, 14 Jul 2015 17:00:16 +0200
Message-ID: <20150714150016.GC21820@linutronix.de>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60883 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbGNPAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 11:00:18 -0400
Content-Disposition: inline
In-Reply-To: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-07-14 16:40:16 [+0200]:

>Hi there!
Hi,

>I just tried out lxc (Linux Containers) with 3.18.17-rt14. After some
>time (~20min) the lxc-commands stop working. I got the following trace
>from dmesg. Any ideas whats causing it and how to fix it besides a
>reboot? I used the same version of lxc with 3.12-rt with no (I think)
>rt-specific problems.
>
>[ 1200.764167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
=E2=80=A6
>[ 1200.764172] Call Trace:
>[ 1200.764173]  [<ffffffff816face4>] schedule+0x34/0xa0
>[ 1200.764174]  [<ffffffff816fc2d6>] __rt_mutex_slowlock+0xe6/0x180
>[ 1200.764175]  [<ffffffff816fc99a>] rt_mutex_slowlock+0x12a/0x310
>[ 1200.764176]  [<ffffffff8115f1b4>] ? vma_merge+0xf4/0x330
>[ 1200.764177]  [<ffffffff8115f7ef>] ? vma_set_page_prot+0x3f/0x60
>[ 1200.764178]  [<ffffffff816fcc31>] rt_mutex_lock+0x31/0x40
>[ 1200.764179]  [<ffffffff816fdfce>] _mutex_lock+0xe/0x10
>[ 1200.764180]  [<ffffffff810de2e2>] proc_cgroup_show+0x52/0x200
>[ 1200.764180]  [<ffffffff81200941>] proc_single_show+0x51/0xa0
>[ 1200.764182]  [<ffffffff811bcdfa>] seq_read+0xea/0x370
>[ 1200.764182]  [<ffffffff811980dc>] vfs_read+0x9c/0x180
>[ 1200.764183]  [<ffffffff81198c59>] SyS_read+0x49/0xb0
>[ 1200.764184]  [<ffffffff81197d91>] ? SyS_lseek+0x91/0xb0
>[ 1200.764185]  [<ffffffff816fe676>] system_call_fastpath+0x16/0x1b

This seems to be always cgroup_mutex mutex it blocks on. SysRq d (show
all locks) should be able to show you who has the lock.

>Thanks.
>Christoph

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
