From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Review comments/questions on preempt-irqs-i386.patch
Date: Tue, 19 Aug 2008 20:04:11 -0400
Message-ID: <20080820000408.GA28774@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:59829 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752423AbYHTAMh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 20:12:37 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm looking at what is in "preempt-irqs-i386.patch" in the broken out
series for 2.6.26-rt1; and I've spotted something that I think might be
a merge/carry-forward error (not sure).  Specifically this chunk:

-       if (auto_eoi)   /* master does Auto EOI */
-               outb_pic(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);
-       else            /* master expects normal EOI */
-               outb_pic(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
+       if (!auto_eoi)  /* master expects normal EOI */
+               outb_p(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
+       else            /* master does Auto EOI */
+               outb_p(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);

I'm wondering (a) is the replacement of outb_pic with the more generic
outb_p intentional, or a carry forward artefact, and (b) the outb aside,
I think this change looks like it essentially does:

- if (x)
-	x-action();
- else
-	not-x-action();
+ if (!x)
+	not-x-action();
+ else
+	x-action();

Is that a fair assesment, or am I missing something?

Thanks,
Paul.
