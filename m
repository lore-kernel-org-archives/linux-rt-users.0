From: Joe Korty <joe.korty@ccur.com>
Subject: might_sleep oops in irq_set_affinity_notifier users
Date: Mon, 19 Aug 2013 12:25:25 -0400
Message-ID: <20130819162525.GA3532@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:6581 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796Ab3HSQmN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Aug 2013 12:42:13 -0400
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
       by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id r7JGPPTF004323
       for <linux-rt-users@vger.kernel.org>; Mon, 19 Aug 2013 12:25:25 -0400
Received: (from jak@localhost)
	by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id r7JGPPO4004322
	for linux-rt-users@vger.kernel.org; Mon, 19 Aug 2013 12:25:25 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
The sfc, mellanox, and infiniband drivers use the
irq_set_affinity_notifier service.  This causes these
drivers to issue a might_sleep oops on driver load due to
calling schedule_work under a raw spin lock:

int __irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask)
{
	...
	if (desc->affinity_notify) {
		kref_get(&desc->affinity_notify->kref);
		schedule_work(&desc->affinity_notify->work);
	}
	...
}

int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
{
	...
	raw_spin_lock_irqsave(&desc->lock, flags);
	ret =  __irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask);
	raw_spin_unlock_irqrestore(&desc->lock, flags);
	...
}

I suppose this could be fixed by using tasklets instead of
schedule_work.  But perhaps it might be better to modify
work queues to use raw locks for the queuing / dequeing
of work rather than sleepy locks; that way, work can be
queued up under both sleepy and atomic contexts under the
rt kernel, just as work can be today queued up under the
nort kernel without any problems.

Joe

PS: failure paths: both sfc and mellanox invoke
irq_cpu_rmap_add which in turn invokes the above
irq_set_affinity lock which oops.  The infiniband driver
invokes irq_set_affinity_lock directly.

PPS: oops was observed under 3.6.11.6-rt38 but a perusal
of 3.10.6-rt3 sources shows it has the same problem.
