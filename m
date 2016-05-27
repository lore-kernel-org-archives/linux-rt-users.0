From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kernel/printk: Don't try to print from IRQ/NMI
 region
Date: Fri, 27 May 2016 11:06:58 -0400
Message-ID: <20160527110658.41cdd123@gandalf.local.home>
References: <20160527135812.GB24120@linutronix.de>
	<20160527101251.0ae36e23@gandalf.local.home>
	<20160527145601.GC24120@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:53392 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750914AbcE0PHH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 May 2016 11:07:07 -0400
In-Reply-To: <20160527145601.GC24120@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 27 May 2016 16:56:01 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> >We use to have a patch where a console could flag itself as atomic.
> >That is, that it doesn't call any sleeping locks. What happened to t=
hat.
> >
> >IIRC, the video console was one such console. Otherwise, we lose out=
 on
> >backtraces in irq context. =20
>=20
> video, like VT?
> The call_console_drivers() does not check such a flag and I don't
> remember about removing something like that. I was actually thinking

You probably didn't remove it. It may have been removed a while ago
when Thomas did his big rewrite to get things working again.

> about adding such a flag=E2=80=A6 I remember you had something in you=
r tree to
> print from IRQ off regions via UART.

I had a few hacks for a while, but they were nothing more than hacks.

Perhaps we should make a better early_printk() or simple console for RT
that can handle printk in atomic locations.

I have a hack patch that gives early_printk() a new "spin lock", where
it only takes the lock if the owner isn't on the CPU. Otherwise it
allows lock to continue (and wont release it). That hack was required
to get legible output from early_printk() when I was getting a bunch of
crashes on all the CPUs, because early_printk() has no locks, and the
console is just a mess when all CPUs print at once.

>=20
> We don't print from a context with interrupts disabled or even a pree=
mpt
> disabled region. In such cases we just wake_up_klogd() and print it
> later.

Yeah, but that doesn't help if the "later" never comes.

> The reason for the patch was the HW/SW lockup detector which comes wi=
th
> interrupts disabled or NMI context and gets to the console(s). Usuall=
y
> we defer everything until later except in this case. And I got busted
> later in the VT code (and the problem was that one sleeping while ato=
mic
> warning which led to more stuff to be printed).

Yeah, it's a pain where our output needs to be in schedulable context.

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
