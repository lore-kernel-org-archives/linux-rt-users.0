From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] tasklet: correct the comments about tasklet schedule
Date: Thu, 26 Feb 2015 15:35:55 +0100
Message-ID: <20150226143555.GG12992@linutronix.de>
References: <536075C1.2080704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	zhangwei <jovi.zhangwei@huawei.com>,
	Li Zefan <lizefan@huawei.com>, peterz@infradead.org
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49212 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbBZOf7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 09:35:59 -0500
Content-Disposition: inline
In-Reply-To: <536075C1.2080704@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Qiang Huang | 2014-04-30 12:02:09 [+0800]:

>--- a/include/linux/interrupt.h
>+++ b/include/linux/interrupt.h
>@@ -514,9 +514,8 @@ extern void __send_remote_softirq(struct call_single_data *cp, int cpu,
>      to be executed on some cpu at least once after this.
>    * If the tasklet is already scheduled, but its execution is still not
>      started, it will be executed only once.
>-   * If this tasklet is already running on another CPU, it is rescheduled
>-     for later.
This is true

>-   * Schedule must not be called from the tasklet itself (a lockup occurs)
This is true

>+   * If this tasklet is already running on another CPU (or schedule is called
>+     from tasklet itself), it wound not be rescheduled.
that are two statements.

I suggest you fix the driver instead poking at the tasklet code.

>    * Tasklet is strictly serialized wrt itself, but not
>      wrt another tasklets. If client needs some intertask synchronization,
>      he makes it with spinlocks.

Sebastian
