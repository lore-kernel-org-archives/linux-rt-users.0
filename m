From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.6.11.1-rt32
Date: Tue, 09 Apr 2013 13:46:56 -0400
Message-ID: <1365529616.25498.75.camel@gandalf.local.home>
References: <1364527527.10629.10.camel@gandalf.local.home>
	 <515A4CE4.9050607@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <515A4CE4.9050607@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-04-02 at 05:13 +0200, Carsten Emde wrote:
> Steven,

> > I'm pleased to announce the 3.6.11.1-rt32 stable release.
> Unfortunately, there is another compile error:
> drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_wait_f=
or_error=E2=80=99:
> drivers/gpu/drm/i915/i915_gem.c:118:3: warning: passing argument 1 of=
=20
> =E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enable=
d by default]
> In file included from include/linux/spinlock.h:273:0,
>                   from include/linux/wait.h:24,
>                   from include/linux/fs.h:396,
>                   from include/drm/drmP.h:47,
>                   from drivers/gpu/drm/i915/i915_gem.c:28:
> include/linux/spinlock_rt.h:21:24: note: expected =E2=80=98struct spi=
nlock_t *=E2=80=99=20
> but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
> drivers/gpu/drm/i915/i915_gem.c:120:3: warning: passing argument 1 of=
=20
> =E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [enab=
led by default]
> In file included from include/linux/spinlock.h:273:0,
>                   from include/linux/wait.h:24,
>                   from include/linux/fs.h:396,
>                   from include/drm/drmP.h:47,
>                   from drivers/gpu/drm/i915/i915_gem.c:28:
> include/linux/spinlock_rt.h:24:24: note: expected =E2=80=98struct spi=
nlock_t *=E2=80=99=20
> but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
> drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_check_=
wedge=E2=80=99:
> drivers/gpu/drm/i915/i915_gem.c:1890:3: warning: passing argument 1 o=
f=20
> =E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enable=
d by default]
> In file included from include/linux/spinlock.h:273:0,
>                   from include/linux/wait.h:24,
>                   from include/linux/fs.h:396,
>                   from include/drm/drmP.h:47,
>                   from drivers/gpu/drm/i915/i915_gem.c:28:
> include/linux/spinlock_rt.h:21:24: note: expected =E2=80=98struct spi=
nlock_t *=E2=80=99=20
> but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
> drivers/gpu/drm/i915/i915_gem.c:1892:3: warning: passing argument 1 o=
f=20
> =E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [enab=
led by default]
> In file included from include/linux/spinlock.h:273:0,
>                   from include/linux/wait.h:24,
>                   from include/linux/fs.h:396,
>                   from include/drm/drmP.h:47,
>                   from drivers/gpu/drm/i915/i915_gem.c:28:
> include/linux/spinlock_rt.h:24:24: note: expected =E2=80=98struct spi=
nlock_t *=E2=80=99=20
> but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
>=20
> I would propose to adopt the mechanism that Sebastian introduced in
> 3.8.4-rt2 (https://lkml.org/lkml/2013/3/26/600). The kernel compiles
> and runs without any problem with the below patch on a system that
> requires the i915 driver module.
>=20

Thanks Carsten, I'll be updating this later today. BTW, did you get any
core dumps from the work queue race that we've been seeing?

Thanks,

-- Steve
