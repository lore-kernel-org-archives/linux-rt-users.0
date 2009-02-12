From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] irq threading: fix PF_HARDIRQ definition
Date: Thu, 12 Feb 2009 09:42:22 +0100
Message-ID: <20090212084222.GA32091@elte.hu>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <20090211205533.329cea1c@torg> <20090212083850.GA29995@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@tglx.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:43356 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbZBLImo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Feb 2009 03:42:44 -0500
Content-Disposition: inline
In-Reply-To: <20090212083850.GA29995@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> hardirq_count() is correct, but looking at PF_HARDIRQ's definition in sched.h:
> 
>  #define PF_EXITPIDONE  0x00000008      /* pi exit done on shut down */
>  #define PF_VCPU        0x00000010      /* I'm a virtual CPU */
>  #define PF_HARDIRQ     0x08000020      /* hardirq context */
>  #define PF_NOSCHED     0x00000020      /* Userspace does not expect scheduling */
>  #define PF_FORKNOEXEC  0x00000040      /* forked but didn't exec */
> 
> Reveals that due to a typo it not only overlaps the PF_NOSCHED bit, but
> also has a spurious 0x08000000 component.

The reason is that when we forward ported the definition, i first moved it
to the 0x08000000 slot - but that slot was already taken. (our PF_ task
flag space is really crowded ...)

Then i moved it to a free spot, 0x20. Or so i thought: a later -rt patch
in the queue introduced PF_NOSCHED which overlapped it.

But the bigger problem was the spurious 0x08000000 component, which overlaps
with:

 #define PF_SOFTIRQ      0x08000000      /* softirq context */

Explaining why the warning triggered in ksoftirqd ;-)

Anyway, my fix should solve this. Do you still see the lockup under X? (make
sure you also have the IPI fix applied, see the patch in this same thread.)

	Ingo
