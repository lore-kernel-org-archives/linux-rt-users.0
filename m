From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.14.39-rt38
Date: Thu, 28 May 2015 11:15:30 -0400
Message-ID: <20150528111530.2c885946@gandalf.local.home>
References: <20150520105535.63704e6b@gandalf.local.home>
	<55672ED6.4070504@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:43049 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753760AbbE1PPd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2015 11:15:33 -0400
In-Reply-To: <55672ED6.4070504@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 May 2015 11:05:58 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On 15-05-20 10:55 AM, Steven Rostedt wrote:
> >=20
> > Dear RT Folks,
> >=20
> > I'm pleased to announce the 3.14.39-rt38 stable release.
>=20
> [...]
>=20
> >=20
> > Changes from v3.14.39-rt37:
> >=20
> > ---
> >=20
> > Marcelo Tosatti (2):
> >       KVM: lapic: mark LAPIC timer handler as irqsafe
> >       KVM: use simple waitqueue for vcpu->wq
> >=20
> > Mike Galbraith (2):
> >       hotplug: Use set_cpus_allowed_ptr() in sync_unplug_thread()
> >       rt, nohz_full: fix nohz_full for PREEMPT_RT_FULL
> >=20
> > Sebastian Andrzej Siewior (1):
> >       kernel/irq_work: fix no_hz deadlock
>=20
> Seems we can't use this commit above as-is on 3.14 (and earlier?)
> since we'll get this:
>=20
> kernel/time/tick-sched.c: In function =E2=80=98can_stop_full_tick=E2=80=
=99:
> kernel/time/tick-sched.c:183:2: error: implicit declaration of functi=
on =E2=80=98arch_irq_work_has_interrupt=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
>   if (!arch_irq_work_has_interrupt()) {
>   ^
> cc1: some warnings being treated as errors
> make[2]: *** [kernel/time/tick-sched.o] Error 1
>=20
> Problem arises because that fcn doesn't come in until 3.18+ with
> the merge v3.18-rc1~114 (in the 2nd commit):
>=20
> git log --oneline --reverse v3.18-rc1~114^2 ^v3.18-rc1~114^
>  a80e49e2cc31 nohz: Move nohz full init call to tick init
>  c5c38ef3d703 irq_work: Introduce arch_irq_work_has_interrupt()
>  76a33061b932 irq_work: Force raised irq work to run on irq work inte=
rrupt
>  3010279f0fc3 x86: Tell irq work about self IPI support
>  09f6edd42421 arm: Tell irq work about self IPI support
>  3631073659d0 arm64: Tell irq work about self IPI support
>  4327b15f64b2 nohz: Consolidate nohz full init code
>  9b01f5bf3999 nohz: nohz full depends on irq work self IPI support
>=20
> Not sure whether we want to backport more stuff or change the
> original backport to not use arch_irq_work_has_interrupt...
>=20
> Config is basically a defconfig but with RT_FULL and NOHZ_FULL =3Dy.

Grumble, I need to add NOHZ_FULL to my test configs. OK, I'll have to
look into this. Thanks for the report.

-- Steve

>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
