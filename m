From: Gerrit Binnenmars <gerritbinnenmars@orange.nl>
Subject: Calculate max. latency?
Date: Thu, 25 Oct 2007 23:44:37 +0200 (CEST)
Message-ID: <29860825.1115621193348677639.JavaMail.www@wwinf6301>
Reply-To: gerritbinnenmars@orange.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-4.orange.nl ([193.252.22.249]:51306 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbXJYWJb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 18:09:31 -0400
Received: from smtp-4.orange.nl (mwinf6302 [10.232.3.24])
	by mwinf6310.orange.nl (SMTP Server) with ESMTP id 5594A1C08F26
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 23:45:19 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id AA14D7000092
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 23:44:37 +0200 (CEST)
Received: from wwinf6301 (wwinf6301 [10.232.3.28])
	by mwinf6302.orange.nl (SMTP Server) with ESMTP id 9DDB57000091
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Oct 2007 23:44:37 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

I am investigating the rt patch with linux kernel 2.6.22 (on i386, x86_64 and powerpc). I use a hr timer to generate interrupts. I have three questions:

1. To determine the worst-case period between this interrupt and the start of a real-time user space thread that is waiting for this interrupt I want to use the following formula:

period = irq_off_time + preempt_disable_time + soft_irq_handling + sched_latency

with irq_off_time measured with CONFIG_CRITICAL_IRQSOFF_TIMING
with preempt_disable_time measured with CONFIG_PREEMPT_TIMING
with soft_irq_handling the time seen with e.g. LTT
with sched_latency measured with cyclictest

Is this correct or am I missing something?
Is preempt_disable_time including the irq_off_time?

2. Can a page fault (fopen()) in another application influence this period?

3. I tried to measure the CONFIG_CRITICAL_IRQSOFF_TIMING but preempt_max_latency remains 0
   (I used the echo 0 >/proc/sys/kernel/preempt_max_latency)
   What can be wrong?

With kind regards,

Gerrit Binnenmars
