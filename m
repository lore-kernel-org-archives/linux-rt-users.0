From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning
 instead
Date: Mon, 10 Jun 2013 18:22:16 -0400
Message-ID: <20130610222215.GA27391@windriver.com>
References: <1369154725.6828.131.camel@gandalf.local.home>
 <CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com>
 <1370637266.9844.95.camel@gandalf.local.home>
 <51B35727.6040907@osadl.org>
 <51B46AC0.7050502@osadl.org>
 <CALqGcGoeGSN8tJ3AmRFeoysWEZdHA2c8X3Ebjn4GHOX=naK_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34551 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab3FJWWM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Jun 2013 18:22:12 -0400
Content-Disposition: inline
In-Reply-To: <CALqGcGoeGSN8tJ3AmRFeoysWEZdHA2c8X3Ebjn4GHOX=naK_Ww@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning in=
stead] On 10/06/2013 (Mon 08:30) Christoph Mathys wrote:

> On Sun, Jun 9, 2013 at 1:45 PM, Carsten Emde <C.Emde@osadl.org> wrote=
:
> > Invalidating and flushing all caches may introduce long latencies o=
f up
> > to several milliseconds. Do not execute it in PREEMPT_RT_FULL kerne=
ls,
> > warn once instead and propose to pin all GPU renderering tasks to a
> > single CPU, if possible.
> >
> > Original commit:
> > 25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.
> >
> > Original log:
> > In order to fully serialize access to the fenced region and the upd=
ate
> > to the fence register we need to take extreme measures on SNB+, and
> > manually flush writes to memory prior to writing the fence register=
 in
> > conjunction with the memory barriers placed around the register wri=
te.
> >
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>=20
> This fixes the problem for me on 3.6.11.5-rt37. Thanks, Carsten!

This thread reminded me of the i915 compile warning I'd seen earlier
today.  Fixing the warning does actually change the code produced.

I'll let you guys who have the actual hardware have the joy of reading
the asm and deciding whether the change is significant or not...

Paul.
--

=46rom 8343a1b04ce4a9462697f584d67e06cd5431fe9b Mon Sep 17 00:00:00 200=
1
=46rom: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 10 Jun 2013 17:55:44 -0400
Subject: [PATCH RT-3.6] i915_gem: properly annotate use of completion l=
ocks as raw
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Currently when compiling drivers/gpu/drm/i915/i915_gem.c we
will get the following warnings:

drivers/gpu/drm/i915/i915_gem.c:118:3: warning: passing argument 1 of =E2=
=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enabled by =
default]
drivers/gpu/drm/i915/i915_gem.c:1890:3: warning: passing argument 1 of =
=E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [enabled =
by default]
 [...]
include/linux/spinlock_rt.h:21:24: note: expected =E2=80=98struct spinl=
ock_t *=E2=80=99 but argument is of type =E2=80=98struct raw_spinlock_t=
 *=E2=80=99

This happens because the i915 code is going after the lock contained
within a completion -- and in RT, we have the commit "completion: Use
simple wait queues", which contains:

    struct completion {
           unsigned int done;
   -       wait_queue_head_t wait;
   +       struct swait_head wait;

and a swait_head is defined as:

   struct swait_head {
           raw_spinlock_t          lock;
           struct list_head        list;
   };

Noting that the wait_queue_head_t's lock was not a raw lock, we
have thus converted the i915 code to use a raw lock, hence the
compile warnings.

These appear to be more than just cosmetic warnings, as the
assembly dump of before this commit and after show some level
of change:

   --- /tmp/before
   +++ /tmp/after
   @@ -551,27 +551,27 @@
         82c:	e8 00 00 00 00       	callq  831 <i915_mutex_lock_interru=
ptible+0x51>
         831:	48 89 c2             	mov    %rax,%rdx
         834:	83 fa 00             	cmp    $0x0,%edx
   -     837:	74 36                	je     86f <i915_mutex_lock_interru=
ptible+0x8f>
   +     837:	74 2f                	je     868 <i915_mutex_lock_interru=
ptible+0x88>
         839:	7c d7                	jl     812 <i915_mutex_lock_interru=
ptible+0x32>
         83b:	8b 83 f0 2c 00 00    	mov    0x2cf0(%rbx),%eax
         841:	85 c0                	test   %eax,%eax
         843:	74 c3                	je     808 <i915_mutex_lock_interru=
ptible+0x28>
         845:	4c 8d ab 88 1d 00 00 	lea    0x1d88(%rbx),%r13
   -     84c:	e8 00 00 00 00       	callq  851 <i915_mutex_lock_interru=
ptible+0x71>
   -     851:	4c 89 ef             	mov    %r13,%rdi
   -     854:	e8 00 00 00 00       	callq  859 <i915_mutex_lock_interru=
ptible+0x79>
   -     859:	83 83 80 1d 00 00 01 	addl   $0x1,0x1d80(%rbx)
   -     860:	4c 89 ef             	mov    %r13,%rdi
   -     863:	e8 00 00 00 00       	callq  868 <i915_mutex_lock_interru=
ptible+0x88>
   -     868:	e8 00 00 00 00       	callq  86d <i915_mutex_lock_interru=
ptible+0x8d>
   -     86d:	eb 99                	jmp    808 <i915_mutex_lock_interru=
ptible+0x28>
   -     86f:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
   -     876:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
   -     87d:	31 c0                	xor    %eax,%eax
   -     87f:	e8 00 00 00 00       	callq  884 <i915_mutex_lock_interru=
ptible+0xa4>
   -     884:	b8 fb ff ff ff       	mov    $0xfffffffb,%eax
   -     889:	eb 87                	jmp    812 <i915_mutex_lock_interru=
ptible+0x32>
   -     88b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   +     84c:	4c 89 ef             	mov    %r13,%rdi
   +     84f:	e8 00 00 00 00       	callq  854 <i915_mutex_lock_interru=
ptible+0x74>
   +     854:	83 83 80 1d 00 00 01 	addl   $0x1,0x1d80(%rbx)
   +     85b:	48 89 c6             	mov    %rax,%rsi
   +     85e:	4c 89 ef             	mov    %r13,%rdi
   +     861:	e8 00 00 00 00       	callq  866 <i915_mutex_lock_interru=
ptible+0x86>
   +     866:	eb a0                	jmp    808 <i915_mutex_lock_interru=
ptible+0x28>
   +     868:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
   +     86f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
   +     876:	31 c0                	xor    %eax,%eax
   +     878:	e8 00 00 00 00       	callq  87d <i915_mutex_lock_interru=
ptible+0x9d>
   +     87d:	b8 fb ff ff ff       	mov    $0xfffffffb,%eax
   +     882:	eb 8e                	jmp    812 <i915_mutex_lock_interru=
ptible+0x32>
   +     884:	66 66 66 2e 0f 1f 84 	data32 data32 nopw %cs:0x0(%rax,%ra=
x,1)
   +     88b:	00 00 00 00 00

   [Similar instance of 2nd lock/unlock disassembly not shown]

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i91=
5_gem.c
index 18da42c..c6998c5 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -115,9 +115,9 @@ i915_gem_wait_for_error(struct drm_device *dev)
 		 * end up waiting upon a subsequent completion event that
 		 * will never happen.
 		 */
-		spin_lock_irqsave(&x->wait.lock, flags);
+		raw_spin_lock_irqsave(&x->wait.lock, flags);
 		x->done++;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	}
 	return 0;
 }
@@ -1887,9 +1887,9 @@ i915_gem_check_wedge(struct drm_i915_private *dev=
_priv,
 		unsigned long flags;
=20
 		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
+		raw_spin_lock_irqsave(&x->wait.lock, flags);
 		recovery_complete =3D x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		raw_spin_unlock_irqrestore(&x->wait.lock, flags);
=20
 		/* Non-interruptible callers can't handle -EAGAIN, hence return
 		 * -EIO unconditionally for these. */
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
