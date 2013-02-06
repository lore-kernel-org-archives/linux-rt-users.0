From: Stanislav Meduna <stano@meduna.org>
Subject: Re: Protection of critical section in PREEMPT_RT
Date: Wed, 06 Feb 2013 09:56:02 +0100
Message-ID: <51121AA2.2080907@meduna.org>
References: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com> <50FE68EF.8060909@meduna.org> <CAHX1yNTKw8vr2v01Eft1tVV5YrP-7Zw=3fk9iF6YJYfbnBJ9LQ@mail.gmail.com> <510ACB87.3080007@am.sony.com> <CAHX1yNQgJXM292q1DWXLdQiR_BK5jZ-d+QHVoEEgksQm04YU6g@mail.gmail.com> <alpine.LFD.2.02.1302041138400.11905@ionos> <CAHX1yNTb92NMAi+9F0QCXqyvwEmerGOar5t4J1tLGznF2jD8Tg@mail.gmail.com> <alpine.LFD.2.02.1302051048170.11905@ionos> <CAHX1yNSCba2wc7A2UOfdyzZ9z-YTYp+p16s8kHcA0e+r9sy+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jacky Lam <lamshuyin@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:44532 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756646Ab3BFI4M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 03:56:12 -0500
In-Reply-To: <CAHX1yNSCba2wc7A2UOfdyzZ9z-YTYp+p16s8kHcA0e+r9sy+BQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06.02.2013 02:59, Jacky Lam wrote:

> When driver code is reading the controller's registers and interrupt
> comes, interrupt handler (not the interrupt thread) need to clear the
> interrupt source first and return IRQ_WAKE_THREAD to wait for
> interrupt thread to actually handle the interrupt task. But in order
> to clear the interrupt source, I need to access the controller's
> internal registers. This is the problem I have now.

Maybe I am unterstanding this wrong, but shouldn't you unmask the
interrupt source when you are _done_ with processing the interrupt?

I have no real experience with interrupt driven drivers in RT-Linux,
but in other RTOSs I worked with this was the way to go -
the interrupt handler clears the source and schedules
the service thread but does not unmask the interrupt in question.
This is first done when the interrupt is processed.

That way you cannot be interrupted by the source you are
already processing. However, even that should IMHO work if the
locking is correct. Things can get complicated if you are
sharing interrupts between devices or if one device is accessed
with more drivers.

Do as Thomas is suggesting - turn all the CONFIG_DEBUG* on and
try with a non-RT kernel.

Regards
-- 
                                            Stano

