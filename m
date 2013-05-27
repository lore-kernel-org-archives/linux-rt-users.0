From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Tracers+cyclictest causing kernel oops
Date: Mon, 27 May 2013 10:02:48 +0200
Message-ID: <20130527080248.GE11166@pengutronix.de>
References: <CAFSh4UwgZJD0YGi8GRtAW4APqWkyf2a+v31zgL2Bu3zfVZg6gw@mail.gmail.com>
 <CAFSh4UzfxuTrsUCX9gsm10KRhJB9APLs8DJihxWai1ysdhMiXg@mail.gmail.com>
 <20130503160546.GF8230@linutronix.de>
 <CAFSh4UwD5yyJrtKwUaOX-uiUuzVf7YaDbM4vbZ1EFZBf6F1JHg@mail.gmail.com>
 <519B57A7.1010901@linutronix.de>
 <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45838 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab3E0ICu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 May 2013 04:02:50 -0400
Content-Disposition: inline
In-Reply-To: <CAFSh4UzaOcbD456e408Qw4F=Ynt1WCXwrUx7ekC1GKLZRkFznw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, May 21, 2013 at 04:20:20PM +0100, Tom Cook wrote:
> On Tue, May 21, 2013 at 12:16 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > please CC the list.
>=20
> Sorry.
>=20
> >
> > On 05/11/2013 06:43 PM, Tom Cook wrote:
> [snip]
> >
> > Not known until you brought that up. I just booted x86 with kgdb=3D=
y and
> > did "echo function > current_tracer" with no side effects. I don't =
have
> > ARM at hand right now. Do you do anything kgdb related besides enab=
ling
> > it in the kernel?
>=20
> No.  I've also tried compiling without kgdb and enabling tracers stil=
l
> causes a crash (see below).
>=20
> Again, I'm far from expert here, but as near as I can tell, a fast
> interrupt exception handler is causing a data abort exception.  Do th=
e
> tracers use fast interrupts to wake up?  Is there some tracer-related
> memory that's getting swapped out?
>=20
> pi@raspberrypi:~/rt-tests$ sudo ./cyclictest -p95 -m -f -b 2000
> # /dev/cpu_dma_latency set to 0us
> [  199.186167] Bad mode in data abort handler detected
> [  199.186194] Internal error: Oops - bad mode: 0 [#1] PREEMPT ARM
> [  199.186246] Modules linked in: snd_bcm2835 snd_pcm snd_seq
> snd_timer snd_seq_device snd snd_page_alloc
> [  199.186260] CPU: 0    Not tainted  (3.6.11-rt31+ #1)
> [  199.186297] PC is at ring_buffer_lock_reserve+0x7c/0x144
> [  199.186326] LR is at vfs_write+0x140/0x188
> [  199.186341] pc : [<c009486c>]    lr : [<c00efda4>]    psr: 600001d=
1
> [  199.186341] sp : da645ef8  ip : da645e28  fp : da645f6c
> [  199.186348] r10: 00000000  r9 : 00000000  r8 : 00000008
> [  199.186357] r7 : 200001d1  r6 : c030226c  r5 : c012cd64  r4 : c073=
2000
> [  199.186366] r3 : 200001d1  r2 : 00000018  r1 : 00000000  r0 : db80=
1420
> [  199.186375] Flags: nZCv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM
What are you using fiqs for? AFAIK they are not well supported in
mainline Linux even.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
