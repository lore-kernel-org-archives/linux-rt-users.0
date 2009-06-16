From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 07:59:28 +0000 (UTC)
Message-ID: <loom.20090616T074347-549@post.gmane.org>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40873 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbZFPH7p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 03:59:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MGTa5-0004Jg-WB
	for linux-rt-users@vger.kernel.org; Tue, 16 Jun 2009 07:59:46 +0000
Received: from adsl-69-105-99-200.dsl.irvnca.pacbell.net ([69.105.99.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2009 07:59:45 +0000
Received: from mcs by adsl-69-105-99-200.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2009 07:59:45 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Suresh Kumar SHUKLA <suresh.shukla <at> st.com> writes:
> 	// get IRQ descriptor from IRQ, it contains pid
> 	desc = &irq_desc[IRQ_BASIC_TIMER_3_1];

That's a very useful clue. I was thinking that I would have to walk the process
tree to find the thread by name. Following up on this clue, it appears as though
in kernel 2.6.29.4 I should be able to use desc=irq_to_desc(irq) to look up the
IRQ descriptor, then use pid=get_task_pid(desc->thread), to get the PID of the
IRQ thread, then use sys_sched_setscheduler(pid,...) to change its priority.
I'll try that out in the morning.

Thanks for the reply,

Martin


