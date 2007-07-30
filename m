From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt 2/9] Dont allow non-threaded softirqs and threaded
 hardirqs
Date: Mon, 30 Jul 2007 07:28:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0707300724120.8151@gandalf.stny.rr.com>
References: <20070730024534.369897977@mvista.com> <20070730024718.890110769@mvista.com>
 <20070730092331.GB25640@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49651 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075AbXG3L2w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 07:28:52 -0400
In-Reply-To: <20070730092331.GB25640@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Mon, 30 Jul 2007, Ingo Molnar wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > I think this was sent before, and it did cause problems before. Would
> > there be *any* reason to have non-threaded softirqs but threaded
> > hardirqs. I can see lots of issues with that.
>
> please elaborate in precise terms: what issues can you see?
>

Hi Ingo,

I don't remember the exact details, I can try to find the thread. But I
remember someone was having their system lock up strangly. We later found
that they had softirqs as normal softirqs and interrupts as threads.  I
think there was some driver that didn't expect the softirq to preempt the
irq handler.  Perhaps the softirq was using spin_lock_irq while the irq
thread was just using spin_lock, which I can see as being something
normal.

The standard Linux does not expect an interrupt to be preempted by a
softirq, and with interrupts as threads but not softirqs, I can see that
happening a lot.

-- Steve
