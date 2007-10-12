From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: NMI watchdog
Date: Fri, 12 Oct 2007 12:12:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710121210210.12663@gandalf.stny.rr.com>
References: <470F3BE0.4050807@free.fr> <Pine.LNX.4.58.0710120625380.8208@gandalf.stny.rr.com>
 <470F7620.6040705@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34566 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761223AbXJLQM5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Oct 2007 12:12:57 -0400
In-Reply-To: <470F7620.6040705@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 12 Oct 2007, John Sigler wrote:
> Steven Rostedt wrote:
>
> > John Sigler wrote:
>  > APIC timer registered as dummy, due to nmi_watchdog=1!
> 213a216,217
>  > Clockevents: could not switch to one-shot mode: lapic is not functional.
>  > Could not switch to high resolution mode on CPU 0
>
> Do you know why nmi_watchdog=1 disables high-resolution timers?
>
> And why nmi_watchdog=1 implies APIC timer registered as dummy?

Crap, I forgot about that. Thomas explained why to me once, and I forgot.

Does it still crash? If not, does it crash if you turn off highres?

Or better yet, try turning off dynamic-ticks. We had a bug once before
that had a problem with the new RCU code and dynamic ticks.

-- Steve
