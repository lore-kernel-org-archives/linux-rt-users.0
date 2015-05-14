From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: softirq behavior during a UDP flood
Date: Thu, 14 May 2015 21:32:14 +0200
Message-ID: <20150514193214.GH13442@linutronix.de>
References: <20150501150412.GA15483@nathan3500-linux-VM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Nathan Sullivan <nathan.sullivan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38990 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965157AbbENTcQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 15:32:16 -0400
Content-Disposition: inline
In-Reply-To: <20150501150412.GA15483@nathan3500-linux-VM>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nathan Sullivan | 2015-05-01 10:04:12 [-0500]:

>Hello all,
>
>We are running 3.14.37-rt on a Xilinx Zynq based board, and have noticed some
>unfortunate behavior with NAPI polling during heavy incoming traffic.  Since,
>as I understand it, softirqs are scheduled on the thread that caused them in
>rt, the netowrk RX softirq simply runs over and over on one CPU of the system.
>The network device never re-enables interupts, basically NAPI polling runs
>forever and weight/budget are irrelevant with preempt-rt on.
>
>Since we set IRQ affinity to CPU 0 for everything, this leads to the system
>live-locking and becoming unusable.  With full RT preemption off, things are
>fine.  In addition, 3.2 kernels with RT are fine as well under heavy net load.
>Is this behavior due to a design tradeoff, or is it a bug?

The rx-napi softirq runs once the threaded handler is done with the
handler. Comparing with vanilla there a little difference: vanilla
repeats the softirq a number of times and has a time budget. Once it
decides that it runs for too long it moves into softirqd. -RT on the
other hand repeats the softirq processing as long as there is work to
do. Since it is done after the thread handler completes it work it is
done at the priority of the threaded handler - so if your -RT task has
a higher priority it won't be disturbed by it.

If you put your shell above the threaded handler of the network handler
(or the handler as SCHED_OTHER) then things should be back to normal.
I'm not sure if moving network (after a while of processing) to ksoftirq
is a good idea because we lose the priority then.

Sebastian
