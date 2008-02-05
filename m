From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: CPU hotplug and IRQ affinity with 2.6.24-rt1
Date: Mon, 04 Feb 2008 22:02:12 -0700
Message-ID: <47A7A784.BA47.005A.0@novell.com>
References: <47A7A131.8040800@qualcomm.com>
 <20080205025144.GA31774@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"LKML" <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: "Daniel Walker" <dwalker@dwalker1.mvista.com>,
	"Max Krasnyanskiy" <maxk@qualcomm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:21447 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYBEFIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Feb 2008 00:08:36 -0500
In-Reply-To: <20080205025144.GA31774@dwalker1.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Feb 4, 2008 at  9:51 PM, in message
<20080205025144.GA31774@dwalker1.mvista.com>, Daniel Walker
<dwalker@dwalker1.mvista.com> wrote: 
> I get the following when I tried it,
> 
> BUG: sleeping function called from invalid context bash(5126) at
> kernel/rtmutex.c:638
> in_atomic():1 [00000001], irqs_disabled():1

Hi Daniel,
  Can you try this patch and let me know if it fixes your problem?

-----------------------

use rcu for root-domain kfree

Signed-off-by: Gregory Haskins <ghaskins@novell.com>

diff --git a/kernel/sched.c b/kernel/sched.c
index e6ad493..77e86c1 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -339,6 +339,7 @@ struct root_domain {
        atomic_t refcount;
        cpumask_t span;
        cpumask_t online;
+       struct rcu_head rcu;

        /*
         * The "RT overload" flag: it gets set if a CPU has more than
@@ -6222,6 +6223,12 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
        return 1;
 }

+/* rcu callback to free a root-domain */
+static void rq_free_root(struct rcu_head *rcu)
+{
+       kfree(container_of(rcu, struct root_domain, rcu));
+}
+
 static void rq_attach_root(struct rq *rq, struct root_domain *rd)
 {
        unsigned long flags;
@@ -6241,7 +6248,7 @@ static void rq_attach_root(struct rq *rq, struct root_domain *rd)
                cpu_clear(rq->cpu, old_rd->online);

                if (atomic_dec_and_test(&old_rd->refcount))
-                       kfree(old_rd);
+                       call_rcu(&old_rd->rcu, rq_free_root);
        }

        atomic_inc(&rd->refcount);
