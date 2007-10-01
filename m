From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Mon, 1 Oct 2007 15:52:02 -0700
Message-ID: <20071001155202.56c348c8@laptopd505.fenrus.org>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com>
	<200710012341.53169.ak@suse.de>
	<alpine.LFD.0.9999.0710012349160.20478@localhost.localdomain>
	<200710020007.09864.ak@suse.de>
	<alpine.LFD.0.9999.0710020043450.20478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <ak@suse.de>, David Bahi <dbahi@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <GHaskins@novell.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59131 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXJAWyB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 18:54:01 -0400
In-Reply-To: <alpine.LFD.0.9999.0710020043450.20478@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2 Oct 2007 00:47:12 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 2 Oct 2007, Andi Kleen wrote:
> > 
> > > OTOH, the accounting hook would allow us to remove the IRQ#0 ->
> > > CPU#0 restriction. Not sure whether it's worth the trouble.
> > 
> > Some SIS chipsets hang the machine when you migrate irq 0 to another
> > CPU. It's better to keep that Also I wouldn't be surprised if there
> > are some other assumptions about this elsewhere.
> > 
> > Ok in theory it could be done only on SIS, but that probably would
> > really not be worth the trouble
> 
> Agreed.
> 
> I just got a x8664-hrt report, where I found the following oddity:
> 
>  0:       1197     172881   IO-APIC-edge      timer
> 
> That's one of those infamous AMD C1E boxen. Strange, all my systems
> have IRQ#0 on CPU#0 and nowhere else. Any idea ?

2 things;
the current irq balancers don't balance the timer interrupt, in fact
they'll leave it alone (so the chipset might balance)
older ones pin it to cpu 0 or rotate it....
