From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: 2.6.23-rt1 trouble
Date: Mon, 15 Oct 2007 11:49:09 +0100 (WEST)
Message-ID: <38542.213.58.131.130.1192445349.squirrel@www.rncbc.org>
References: <1192154640.15992.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Gregory Haskins" <ghaskins@novell.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.netcabo.pt ([212.113.174.29]:40348 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753761AbXJOLBt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 07:01:49 -0400
In-Reply-To: <1192154640.15992.10.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, October 12, 2007 03:04, Steven Rostedt wrote:
> We are pleased to announce the 2.6.23-rt1 tree, which can be
> downloaded from the location:
>
> http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Changes since 2.6.23-rc9-rt2
>
> - updated to 2.6.23
>
> - spin_trylock_irqsave macro fix (S=E9bastien Dugu=E9)
>
> - move rcu_preempt_boost init earlier (Steven Rostedt)
>
> - rt task send IPI condition update (Mike Kravetz)
>

I am experiencing some highly annoying but intermitent freezing on a
pentium4 2.80G HT/SMT box, when doing normal desktop work with 2.6.23-r=
t1.

The same crippling behavior does not occur on a Core 2 Due T7200 2.0G S=
MP,
so I suspect it's something due specific to the SMT scheduling support
(Hyper-Threading). But can't tell for sure, obviously :)

The symptoms are noticeable primarily as some X/GUI intermitent freezin=
g,
sometimes only one application, then several and ultimately the whole X
desktop becomes completely unresponsive. It looks like scheduling
problems. There is this hint that switching to a spare console terminal
(via Ctrl+Alt+Fn) might cause later recovery. But its just a question o=
f
some more time for it just happens again and again, one after another,
several applications becoming temporarily frozen and just by luck the
system gets back to normal, probably due to some incidental shake-up :)
but there are other times that nothing seems to help with no alternativ=
e
to the power-reset switch.

I could not find any evidence on dmesg or in the system logs, of any
apparent trouble. No BUGs, no oops, no panics, no nothing. It just
freezes, this and that, now and then. It just makes it all unworkable a=
nd
obviously subject to ditching.

Again, this only happens on this P4/HT box. On a Core2 Duo laptop, with
same 2.6.23-rt1 with the very same kernel configuration, it does not sh=
ow
any illness and is running quite fine.

Remember one report I had about a similar freezing behavior? Now it's
happening the other way around: the core2 is OK, the pentium4 is KO.

One naive suspicion goes like the new rcu-preempt code is to blame, sin=
ce
I don't remember having this or any other trouble with 2.6.23-rc8-rt1.

Until now this post looks like more of a rant than a proper bug report,=
 I
know. Question is how I can help myself in figuring this all out? Advic=
e
on debugging, tracing or statistical collection would be really
appreciated, as will for any hint in pin pointing the issue, of course.

Help?
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
