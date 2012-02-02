From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 02 Feb 2012 13:21:39 -0500
Message-ID: <1328206899.5882.117.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
	 <201202021338.44950.tim.sander@hbm.com>
	 <1328204008.5882.109.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:52471 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab2BBSVk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 13:21:40 -0500
In-Reply-To: <1328204008.5882.109.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-02-02 at 12:33 -0500, Steven Rostedt wrote:

> NETDEV_TX_BUSY is part of NET_TX_MASK thus the packet is requeued (the
> skb->next = nskb) in dev_hard_start_xmit(). And the NETDEV_TX_BUSY is
> passed back to sch_derect_xmit() which calls dev_requeue_skb() which
> then calls __netif_schedule(q) which will call __netif_reschedule(q)
> which will then do raise_softirq_irqoff(NET_TX_SOFTIRQ).
> 
> Thus, as soon as ksoftirq exits this routine, it will restart the
> process over again. As the fec driver never finished with its
> negotiations, the process starts over again and we never move forward.
> 

I'm thinking this bug exists in mainline too. If you set the ksoftirqd
threads to a real-time task on mainline, and then enable this driver,
you may also get it to starve.

Right now, the softirq will detect the requeueing, and push it off to
the ksoftirqd thread. But in mainline, that runs as a normal process,
and it will let the worker thread finish the negotiations. But if that
was a RT task, it might not.

-- Steve


