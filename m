From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CPU Isolation with PREEMPT_RT
Date: Thu, 14 Jul 2016 17:52:17 +0200
Message-ID: <20160714155217.GB12152@linutronix.de>
References: <CANv7uPRJjawJOHx2ZnKz+iZK3u_PXuDBjCkXefP4kuzeLLpeZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: GeHao Kang <kanghao0928@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45185 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcGNPwZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jul 2016 11:52:25 -0400
Content-Disposition: inline
In-Reply-To: <CANv7uPRJjawJOHx2ZnKz+iZK3u_PXuDBjCkXefP4kuzeLLpeZQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* GeHao Kang | 2016-07-01 14:37:12 [+0800]:

>Hi Ingo,
>
>When the kernel built with CONFIG_PREEMPT_RT_FULL and boot up with some
>specific isolcpus, e.g. 'isolcpus=1,3', the system cannot enter the
>user space and be blocked with the message,  "random: nonblocking pool
>is initialized". Not all combinations of CPU isolation can cause this
>issue. In my test on i.MX6Q, this might happen when isolcpus is set as
>'1, 3', or '2, 3'.
>
>I have tested CPU isolation on various kernels, 4.1.15-rt17,
>4.4.12-rt19, 4.1.15,  and 4.4.0. This issue does not happen on
>4.1.15 and 4.4.0. The following is the detail about the test
>environment and kernel message for system blocking.

So it happens always with a -RT kernel?
You have also nohz_full enabled which does not work (perfectly) on -RT
(you should wake up on each tick).
I don't have imx6q at hand and I can't reproduce the issue on x86.
Do you have the problem with isolcpus= but without nohz?

If this is limited to CPUs 1+3 or 2+3 I suggest magic-sysrq to perform a
task-dump on all CPUs and locks to figure out what is blocking the
system from entering user space.

Sebastian
