From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 0/2] VFCIPI support v2
Date: Mon, 30 Jul 2007 18:06:04 -0400
Message-ID: <46AE288C0200005A00028613@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:6928 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S969037AbXG3WGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 18:06:17 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-30 at 14:34 -0700, Daniel Walker wrote:

> Do you have any information regard the amount that IPI's contribute to
> overall system latency?

Nope...

>  My experience is that most IPIs are relatively short.

Agreed.

>  I wonder if the effect of a threaded IPI might be worse for
> latency than non-threaded ..

I have no doubt that it is worse, at least from certain perspectives. ;)
As with PREEMPT_HARDIRQS, the minimum latency as observed from the
caller's perspective (the one driving the interrupt) should be expected
to be _worse_ than if executed directly in interrupt context.  There's
simply more overhead to deal with.

Conversely however, the overall system latency _should_ improve as I
have made both the caller and callee side of the FUNCTION_CALL link
opportunistically preemptible.  This is an improvement over the existing
system which is completely unbounded with what essentially is arbitrary
code (any module can request an FCIPI).  This is a very good thing, IMO.
And whatever arguments you can make against VFCIPI increasing minimum
latency you could make against PREEMPT_HARDIRQs as well ;)  IRQ handlers
should be short too (in theory) ;)

That being said: My inspiration for this changeset came not from the
desire to reduce overall latency.  Rather, I was seeing places where
code that used spinlock_t + FCIPI stopped working in RT because the
spinlock_t suddenly became sleepable.  I could have just addressed this
in a more tactical manner by fixing the subsystem in question (e.g.
convert it to raw_spinlocks, etc).  But I thought it might be worthwhile
if I could make the FCIPI subsystem transparently support unmodified
clients much in the way the rt_mutex/hardirq system does.  The result of
that experiment is this patch series.

Regards,
-Greg
