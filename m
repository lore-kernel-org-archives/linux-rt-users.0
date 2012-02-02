From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 02 Feb 2012 12:33:28 -0500
Message-ID: <1328204008.5882.109.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
	 <201202021338.44950.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Hector Palacios <hector.palacios@digi.com>,
	linux-rt-users@vger.kernel.org, lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:45803 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab2BBRdb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 12:33:31 -0500
In-Reply-To: <201202021338.44950.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-02-02 at 13:38 +0100, Tim Sander wrote:

> I have verified that in my case the driver takes always the return statement in
> line fec.c:247: return NETXDEV_TX_BUSY;  

Thank you!  I think I found the problem. That return of NETXDEV_TX_BUSY
was key.

> It never stops on a breakpoint set on line 250 which shows that the interface
> gets never configured.
> 
> I have taken some screenshots of my hw debugger:
> 
> trace:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_enet_start_xmit.png
> stack:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_enet_start_xmit_stacktrace.png
> locals:http://private.vlsi.informatik.tu-darmstadt.de/tstone/linux/fec_enet_start_xmit_stack+locals.png
> 

As I suspected, this looks to be another case of the ksoftirqd starving
the rest of the processes.

We have the following code:

net/core/dev.c: __dev_xmit_skb()

I'm assuming we're hitting this path:

	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
		   qdisc_run_begin(q)) {
		/*
		 * This is a work-conserving queue; there are no old skbs
		 * waiting to be sent out; and the qdisc is not running -
		 * xmit the skb directly.
		 */
		if (!(dev->priv_flags & IFF_XMIT_DST_RELEASE))
			skb_dst_force(skb);

		qdisc_bstats_update(q, skb);

		if (sch_direct_xmit(skb, q, dev, txq, root_lock)) {
			if (unlikely(contended)) {
				spin_unlock(&q->busylock);
				contended = false;
			}
			__qdisc_run(q);
		} else
			qdisc_run_end(q);

		rc = NET_XMIT_SUCCESS;


net/sched/sch_generic.c: sch_direct_xmit()

	if (!netif_tx_queue_frozen_or_stopped(txq))
		ret = dev_hard_start_xmit(skb, dev, txq);


net/core/dev.c: dev_hard_start_xmit()

		rc = ops->ndo_start_xmit(nskb, dev);
		trace_net_dev_xmit(nskb, rc, dev, skb_len);
		if (unlikely(rc != NETDEV_TX_OK)) {
			if (rc & ~NETDEV_TX_MASK)
				goto out_kfree_gso_skb;
			nskb->next = skb->next;
			skb->next = nskb;
			return rc;
		}


ops->ndo_start_xmit == fec_enet_start_xmit

drivers/net/fec.c: fec_enet_start_xmit()

	if (!fep->link) {
		/* Link is down or autonegotiation is in progress. */
		return NETDEV_TX_BUSY;
	}

NETDEV_TX_BUSY is part of NET_TX_MASK thus the packet is requeued (the
skb->next = nskb) in dev_hard_start_xmit(). And the NETDEV_TX_BUSY is
passed back to sch_derect_xmit() which calls dev_requeue_skb() which
then calls __netif_schedule(q) which will call __netif_reschedule(q)
which will then do raise_softirq_irqoff(NET_TX_SOFTIRQ).

Thus, as soon as ksoftirq exits this routine, it will restart the
process over again. As the fec driver never finished with its
negotiations, the process starts over again and we never move forward.

I'm not sure what the best way to handle this is.

-- Steve


