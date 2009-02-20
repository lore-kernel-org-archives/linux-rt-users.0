From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Announce] 2.6.29-rc4-rt2
Date: Fri, 20 Feb 2009 23:54:31 +0100
Message-ID: <1235170471.4736.44.camel@laptop>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <1235168743.1052.16.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35844 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbZBTWyq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2009 17:54:46 -0500
In-Reply-To: <1235168743.1052.16.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-02-20 at 14:25 -0800, Sven-Thorsten Dietrich wrote:
> On Thu, 2009-02-12 at 23:56 +0100, Thomas Gleixner wrote:
> > We are pleased to announce the first update to our new preempt-rt
> > series. It fixes the reported bugs and some more.
> > 
> FYI:
> 
> These patches in RT2:
> 
> rt-fix-ipi-kfree-introduce-ipi_softirq.patch
> rt-fix-ipi-kfree-introduce-ipi_softirq-cleanup.patch
> 
> Cause a hard-lock when running dhcp on my 8-way AMD box.
> 
> Reverting them eliminates the issue.

can you try the patches in:

http://lkml.org/lkml/2009/2/17/385
http://lkml.org/lkml/2009/2/17/384
http://lkml.org/lkml/2009/2/17/387



