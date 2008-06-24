From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 16:15:49 +0200
Message-ID: <200806241615.49876.jbe@pengutronix.de>
References: <1214271257.8701.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759787AbYFXORY@vger.kernel.org>
In-Reply-To: <1214271257.8701.17.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 June 2008 03:34, Steven Rostedt wrote:
> We are pleased to announce the 2.6.25.8-rt7 tree, which can be
> downloaded from the location:
>
>   http://rt.et.redhat.com/download/
>
> Information on the RT patch can be found at:
>
>   http://rt.wiki.kernel.org/index.php/Main_Page
>
> Changes since 2.6.25.4-rt6
>
>   - ported to 2.6.25.8
>
>   - rwlock pi_lock fixes on waking up multiple readers (Steven Rosted=
t)
>
>   - revert adaptive locks from RCU (Thomas Gleixner)
>      [ for some reason, using RCU causes some latency spikes, this
>        may be a sign of something going wrong in RCU itself ]
>
>   - rwlock mutex owner fix for waking up reader with readers held
>                                                   (Steven Rostedt)
>
>   - rwlock remove waiter from pi_list on above fix (Steven Rostedt an=
d
>                                                     Thomas Gleixner)
>
>   - rwlock replace macro with inline (Thomas Gleixner)
>
>   - rwlock pending namespace updates (Thomas Gleixner)
>
>   - futex fix fault (Thomas Gleixner)
>
> to build a 2.6.25.8-rt7 tree, the following patches should be applied=
:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.8.bz2
>   http://rt.et.redhat.com/download/patch-2.6.25.8-rt7.bz2

This occurs when I try to build a PowerPC (MPC5200) kernel:

[...]
In file included from kernel/sched.c:1318:
kernel/sched.c: In function 'sched_init':
kernel/sched.c:7702: error: implicit declaration of function 'global_rt=
_runtime'
[...]

And when I'm using the patch from Uli Brueggemann to fix it, I get:

[...]
In file included from kernel/sched.c:1325:
kernel/sched_rt.c: In function 'inc_rt_tasks':
kernel/sched_rt.c:290: error: 'struct rq' has no member named 'online'
[...]

Any hints?

Juergen Beisert

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
