From: Juerg Haefliger <juergh@gmail.com>
Subject: Re: [ANNOUNCE] 3.14.43-rt42
Date: Thu, 18 Jun 2015 09:26:59 +0200
Message-ID: <CADLDEKstKq87vKsk2P+3jMYyha2B+gewBt6+_OwMy63PFAK_bw@mail.gmail.com>
References: <20150520232402.410e9fdb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520232402.410e9fdb@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, May 21, 2015 at 5:24 AM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
>
> Dear RT Folks,
>
> I'm pleased to announce the 3.14.43-rt42 stable release.
>
>
> This release is just an update to the new stable 3.14.43 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.gi=
t

This kernel doesn't compile with CONFIG_NO_HZ_FULL:

kernel/time/tick-sched.c: In function =E2=80=98can_stop_full_tick=E2=80=
=99:
kernel/time/tick-sched.c:183:2: error: implicit declaration of
function =E2=80=98arch_irq_work_has_interrupt=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  if (!arch_irq_work_has_interrupt()) {
  ^
  CC      mm/pgtable-generic.o
cc1: some warnings being treated as errors
scripts/Makefile.build:308: recipe for target 'kernel/time/tick-sched.o=
' failed
make[2]: *** [kernel/time/tick-sched.o] Error 1
scripts/Makefile.build:455: recipe for target 'kernel/time' failed
make[1]: *** [kernel/time] Error 2


arch_irq_work_has_interrupt wasn't introduced until 3.17-rc5 with
commit c5c38ef3d70377dc504a6a3f611a3ec814bc757b.

Patch 0353-kernel-irq_work-fix-no_hz-deadlock.patch breaks the build.

=2E..Juerg



>   branch: v3.14-rt
>   Head SHA1: 2af10b11747b4336ac620aa93ba9bae16864315e
>
>
> Or to build 3.14.43-rt42 directly, the following patches should be ap=
plied:
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.43.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.=
43-rt42.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Juerg Haefliger
Hewlett-Packard
