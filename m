From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.14.43-rt42
Date: Thu, 18 Jun 2015 09:58:07 -0400
Message-ID: <20150618095807.68448b49@gandalf.local.home>
References: <20150520232402.410e9fdb@gandalf.local.home>
	<CADLDEKstKq87vKsk2P+3jMYyha2B+gewBt6+_OwMy63PFAK_bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Juerg Haefliger <juergh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:34632 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753102AbbFRN6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jun 2015 09:58:11 -0400
In-Reply-To: <CADLDEKstKq87vKsk2P+3jMYyha2B+gewBt6+_OwMy63PFAK_bw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 18 Jun 2015 09:26:59 +0200
Juerg Haefliger <juergh@gmail.com> wrote:

> Hi Steve,
>=20
> On Thu, May 21, 2015 at 5:24 AM, Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> >
> > Dear RT Folks,
> >
> > I'm pleased to announce the 3.14.43-rt42 stable release.
> >
> >
> > This release is just an update to the new stable 3.14.43 version
> > and no RT specific changes have been made.
> >
> >
> > You can get this release via the git tree at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.=
git
>=20
> This kernel doesn't compile with CONFIG_NO_HZ_FULL:
>=20
> kernel/time/tick-sched.c: In function =E2=80=98can_stop_full_tick=E2=80=
=99:
> kernel/time/tick-sched.c:183:2: error: implicit declaration of
> function =E2=80=98arch_irq_work_has_interrupt=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   if (!arch_irq_work_has_interrupt()) {
>   ^
>   CC      mm/pgtable-generic.o
> cc1: some warnings being treated as errors
> scripts/Makefile.build:308: recipe for target 'kernel/time/tick-sched=
=2Eo' failed
> make[2]: *** [kernel/time/tick-sched.o] Error 1
> scripts/Makefile.build:455: recipe for target 'kernel/time' failed
> make[1]: *** [kernel/time] Error 2
>=20
>=20
> arch_irq_work_has_interrupt wasn't introduced until 3.17-rc5 with
> commit c5c38ef3d70377dc504a6a3f611a3ec814bc757b.
>=20
> Patch 0353-kernel-irq_work-fix-no_hz-deadlock.patch breaks the build.

Thanks for letting me know. I need to work on the stable releases again
soon. If not this week, I'll do it first thing next week.

-- Steve


>=20
> ...Juerg
>=20
>=20
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
