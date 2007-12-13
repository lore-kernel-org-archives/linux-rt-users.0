From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH RT] add pending in fasteoi for IOAPIC hack
Date: Wed, 12 Dec 2007 22:35:40 -0500
Message-ID: <1197516940.12653.5.camel@perihelion>
References: <Pine.LNX.4.58.0712121539400.22581@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbXLMDgO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Dec 2007 22:36:14 -0500
In-Reply-To: <Pine.LNX.4.58.0712121539400.22581@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2007-12-12 at 15:41 -0500, Steven Rostedt wrote:
> The IOAPIC hack that does a level=>edge to mask does not disable
> interrupts. So we can receive interrupts when masked, and this means
> that we can miss interrupts that arrive when the thread is handling
> them.
> 
> This patch adds the "IRQ_PENDING" logic of the edge irqs to be
> able to catch interrupts coming in when supposably "masked".

ACK on all of these. I've been using them internally for a bit in
pursuit of a later problem. Additionally, I am currently reworking the
level->edge->level hack because it's known to be in violation of a
number of errata from third parties. The "legacy mode" hack is actually
only need on certain systems, which have e.g. a PCIe host bridge with
integrated IO-APIC that snoops the APIC to determine mask status.

I'm going to add a blacklist and quirks instead, as doing
level->edge->level otherwise causes us to start losing interrupts on
other systems. I will supply more information later - this is a somewhat
involved problem that we (Red Hat) have been looking at for a while.

Jon.
