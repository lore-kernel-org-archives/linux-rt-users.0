From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH RT 2/2] softirq: split timer softirqs out of ksoftirqd
Date: Mon, 6 Jun 2016 11:21:21 -0700
Message-ID: <CAGt3f4mtbeSxAirb9HmWHxjKn5fBGLTc2sgfcXBzA286X0g-PQ@mail.gmail.com>
References: <20160120163239.GA2741@linutronix.de> <20160120163407.GB2741@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34278 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcFFSVv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2016 14:21:51 -0400
Received: by mail-vk0-f52.google.com with SMTP id e4so74451945vkb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2016 11:21:51 -0700 (PDT)
In-Reply-To: <20160120163407.GB2741@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've been running with this patch on ARM (dra7 SOC, which is a
dual-core A15) with a 4.1.18-rt17 kernel for a while without any
noticeable problems. Boosting the ktimersoftd processes on both cores
to a higher priority fixed some timing problems my userspace
application was seeing too.

The userspace application in question has a repeating timerfd in an
epoll and spends most of its time in blocking epoll_wait calls. Under
system load (most from other lower-RT-priority userspace processes),
it was seeing several-ms delays between the timerfd interrupt
happening and ksoftirqd running the HRTIMER softirq to wake it up.
That was with ksoftirqd running as SCHED_OTHER, which is what it
defaulted to. The priority inversion between the userspace processes
is gone after making ktimersoftd the same priority as the
highest-priority application.

Tested-by: Brian Silverman <brian@peloton-tech.com>
