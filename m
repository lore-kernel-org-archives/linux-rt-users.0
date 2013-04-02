From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 3.6.11.1-rt32
Date: Tue, 02 Apr 2013 05:13:40 +0200
Message-ID: <515A4CE4.9050607@osadl.org>
References: <1364527527.10629.10.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364527527.10629.10.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven,

> I'm pleased to announce the 3.6.11.1-rt32 stable release.
Unfortunately, there is another compile error:
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_wait_for=
_error=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:118:3: warning: passing argument 1 of=20
=E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enabled =
by default]
In file included from include/linux/spinlock.h:273:0,
                  from include/linux/wait.h:24,
                  from include/linux/fs.h:396,
                  from include/drm/drmP.h:47,
                  from drivers/gpu/drm/i915/i915_gem.c:28:
include/linux/spinlock_rt.h:21:24: note: expected =E2=80=98struct spinl=
ock_t *=E2=80=99=20
but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
drivers/gpu/drm/i915/i915_gem.c:120:3: warning: passing argument 1 of=20
=E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [enable=
d by default]
In file included from include/linux/spinlock.h:273:0,
                  from include/linux/wait.h:24,
                  from include/linux/fs.h:396,
                  from include/drm/drmP.h:47,
                  from drivers/gpu/drm/i915/i915_gem.c:28:
include/linux/spinlock_rt.h:24:24: note: expected =E2=80=98struct spinl=
ock_t *=E2=80=99=20
but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_check_we=
dge=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:1890:3: warning: passing argument 1 of=20
=E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enabled =
by default]
In file included from include/linux/spinlock.h:273:0,
                  from include/linux/wait.h:24,
                  from include/linux/fs.h:396,
                  from include/drm/drmP.h:47,
                  from drivers/gpu/drm/i915/i915_gem.c:28:
include/linux/spinlock_rt.h:21:24: note: expected =E2=80=98struct spinl=
ock_t *=E2=80=99=20
but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99
drivers/gpu/drm/i915/i915_gem.c:1892:3: warning: passing argument 1 of=20
=E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [enable=
d by default]
In file included from include/linux/spinlock.h:273:0,
                  from include/linux/wait.h:24,
                  from include/linux/fs.h:396,
                  from include/drm/drmP.h:47,
                  from drivers/gpu/drm/i915/i915_gem.c:28:
include/linux/spinlock_rt.h:24:24: note: expected =E2=80=98struct spinl=
ock_t *=E2=80=99=20
but argument is of type =E2=80=98struct raw_spinlock_t *=E2=80=99

I would propose to adopt the mechanism that Sebastian introduced in
3.8.4-rt2 (https://lkml.org/lkml/2013/3/26/600). The kernel compiles
and runs without any problem with the below patch on a system that
requires the i915 driver module.

	-Carsten.



=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: gpu/i915: don't open code these things

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
  drivers/gpu/drm/i915/i915_gem.c |   10 ++--------
  1 file changed, 2 insertions(+), 8 deletions(-)

Index: linux-3.6.11.1-rt32/drivers/gpu/drm/i915/i915_gem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-3.6.11.1-rt32.orig/drivers/gpu/drm/i915/i915_gem.c
+++ linux-3.6.11.1-rt32/drivers/gpu/drm/i915/i915_gem.c
@@ -90,7 +90,6 @@ i915_gem_wait_for_error(struct drm_devic
  {
  	struct drm_i915_private *dev_priv =3D dev->dev_private;
  	struct completion *x =3D &dev_priv->error_completion;
-	unsigned long flags;
  	int ret;

  	if (!atomic_read(&dev_priv->mm.wedged))
@@ -115,9 +114,7 @@ i915_gem_wait_for_error(struct drm_devic
  		 * end up waiting upon a subsequent completion event that
  		 * will never happen.
  		 */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		x->done++;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		complete(x);
  	}
  	return 0;
  }
@@ -1884,12 +1881,9 @@ i915_gem_check_wedge(struct drm_i915_pri
  	if (atomic_read(&dev_priv->mm.wedged)) {
  		struct completion *x =3D &dev_priv->error_completion;
  		bool recovery_complete;
-		unsigned long flags;

  		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		recovery_complete =3D x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		recovery_complete =3D completion_done(x);

  		/* Non-interruptible callers can't handle -EAGAIN, hence return
  		 * -EIO unconditionally for these. */
