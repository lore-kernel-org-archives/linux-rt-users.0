From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: PF_HARDIRQ used in preempt-realtime-core.patch
Date: Mon, 6 Oct 2008 15:49:29 -0400
Message-ID: <20081006194928.GA14183@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:43264 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752850AbYJFTtb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2008 15:49:31 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I noticed that preempt-realtime-core.patch does this to hardirq.h:

-#define in_irq()               (hardirq_count())
-#define in_softirq()           (softirq_count())
-#define in_interrupt()         (irq_count())
+#define in_irq()       (hardirq_count() || (current->flags & PF_HARDIRQ))
+#define in_softirq()   (softirq_count() || (current->flags & PF_SOFTIRQ))
+#define in_interrupt() (irq_count())

I was thinking that in order to have better patch bisection for future
hard/softirq segmentation, that this chunk would be better suited to
live in preempt-irqs-core.patch (where PF_HARDIRQ is introduced).

That would reduce the preempt-realtime-core.patch for hardirq.h to just
one line, if we drop the whitespace shuffling in there at the same time.

I can send diffs of the existing 26rt9 patches, but I'm not sure how useful
folks would find diffs of diffs (if any at all.).  Since it doesn't
impact the actual code base of the resulting patched tree, the other
option is to just ignore it for 26 but keep it in mind for the future.

Paul.
