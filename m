From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: [PATCH][RT][PPC64] Fix a previously reverted "fix"
Date: Thu, 10 Jul 2008 22:34:56 +0530
Message-ID: <20080710170456.GB7685@linux.vnet.ibm.com>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	Josh Triplett <josht@linux.vnet.ibm.com>,
	Sebastien Dugue <sebastien.dugue@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:52260 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYGJRGR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jul 2008 13:06:17 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6AH5FJp014318
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jul 2008 03:05:15 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6AH4WLN2752572
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jul 2008 03:04:32 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6AH4x7Z017879
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Jul 2008 03:04:59 +1000
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This patch reintroduces a "fix" that got reverted.
Here was the original patch http://lkml.org/lkml/2007/5/22/133

Here is the new patch
This patch also fixes OOPS reported here: http://lkml.org/lkml/2008/6/19/146

>From tsutomu.owa@toshiba.co.jp
Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>



--- linux-2.6.25.8-rt7/arch/powerpc/kernel/entry_64.S	2008-07-10 16:37:17.000000000 +0000
+++ linux-2.6.25.8-rt7.mod/arch/powerpc/kernel/entry_64.S	2008-07-10 07:58:56.000000000 +0000
@@ -579,14 +579,9 @@ do_work:
 	cmpdi	r0,0
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
-	/* here we are preempting the current task */
 1:
-	li	r0,1
-	stb	r0,PACASOFTIRQEN(r13)
-	stb	r0,PACAHARDIRQEN(r13)
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10,1		/* reenable interrupts */
-	bl	.preempt_schedule
+	/* preempt_schedule_irq() expects interrupts disabled. */
+	bl	.preempt_schedule_irq
 	mfmsr	r10
 	clrrdi	r9,r1,THREAD_SHIFT
 	rldicl	r10,r10,48,1	/* disable interrupts again */
