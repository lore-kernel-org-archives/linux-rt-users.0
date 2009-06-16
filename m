From: Suresh Kumar SHUKLA <suresh.shukla@st.com>
Subject: RE: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 09:24:12 +0530
Message-ID: <000001c9ee36$218cf3a0$a852c70a@dlh.st.com>
References: <loom.20090615T222836-377@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Martin Shepherd'" <mcs@astro.caltech.edu>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:33557 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498AbZFPDye (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2009 23:54:34 -0400
In-Reply-To: <loom.20090615T222836-377@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Martin,

> Is there a way for a device driver to set the priority of the 
> IRQ thread that services interrupts from its hardware? I am 
> writing a device driver for a digital I/O board with general 
> purpose interrupt capability, and I would like the 
> application to be able to tell the driver what priority it 
> needs those interrupts to be given.
> 
> Currently it appears that preemp_rt spawns all IRQ threads 
> with priority 50, and that the only way to change the 
> priority of an IRQ is for an application program to execute 
> the chrt program, after the IRQ thread has been created. 
> However this requires that the driver pass back information 
> to the calling program about which IRQ it is using, so that 
> the program can then call popen to first search for the PID 
> of the corresponding thread, and then execute chrt to change 
> its priority. This is possible but messy, and relies on the 
> name of IRQ threads not changing in the future.
> 
> So is there a way for driver code in the kernel to identify 
> the thread of a given IRQ, and then change its priority?


I tried this exercise in a driver for 2.6.26. I succeeded in identifying the
thread for IRQ and its priority. I couldn't do the priority changes.

 #if 1
	struct sched_param param = { 0, };
	struct irq_desc *desc;

	// 2. Raise the priority of ISR thread
	param.sched_priority = 90;

	// get IRQ descriptor from IRQ, it contains pid
	desc = &irq_desc[IRQ_BASIC_TIMER_3_1];
	printk("Thread Priority = %u\n", desc->thread->prio);	
#endif

Along with this, some minor changes ('static' to 'extern' etc) for irq_desc
structure in corresponding files.

For changing the priority, you may try patches sent by Remy Bohmer
[linux@bohmer.net] on 28-May.

-Suresh

