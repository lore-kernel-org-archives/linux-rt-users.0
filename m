From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch] rt: fix ipi kfree(), introduce IPI_SOFTIRQ
Date: Thu, 12 Feb 2009 10:22:44 +0100
Message-ID: <1234430564.23438.205.camel@twins>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <20090212005032.GA4788@nowhere> <20090212021257.GB4697@nowhere>
	 <20090212081801.GA22979@elte.hu>  <20090212081923.GA26838@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:56865 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbZBLJUz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 04:20:55 -0500
In-Reply-To: <20090212081923.GA26838@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-02-12 at 09:19 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, that's a complex one - we do kfree() from IPI context, [...]
> 
> The patch below might do the trick - it offloads this to a softirq.
> Not tested yet.

The simple fix is something like:

---
 kernel/smp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index bbedbb7..9b974c1 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -252,7 +252,11 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 			 * will make sure the callee is done with the
 			 * data before a new caller will use it.
 			 */
+#ifndef CONFIG_PREEMPT_RT
 			data = kmalloc(sizeof(*data), GFP_ATOMIC);
+#else
+			data = NULL;
+#endif
 			if (data)
 				data->flags = CSD_FLAG_ALLOC;
 			else {
@@ -347,7 +351,11 @@ void smp_call_function_many(const struct cpumask *mask,
 		return;
 	}
 
+#ifndef CONFIG_PREEMPT_RT
 	data = kmalloc(sizeof(*data) + cpumask_size(), GFP_ATOMIC);
+#else
+	data = NULL;
+#endif
 	if (unlikely(!data)) {
 		/* Slow path. */
 		for_each_online_cpu(cpu) {

