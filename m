From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.0.25-rt44
Date: Fri, 23 Mar 2012 15:50:00 -0400
Message-ID: <1332532200.23924.73.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-y9ABWiV3psqdnF9fB8Rx"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7669 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab2CWTuF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Mar 2012 15:50:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-y9ABWiV3psqdnF9fB8Rx
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable


Dear RT Folks,

I'm pleased to announce the 3.0.25-rt44 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: ed5ff257433a0c026d8724288d921dc8c6da7d57


Or to build 3.0.25-rt44 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.25.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.25-rt44.=
patch.xz


You can also build from 3.0.25-rt43 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.25-=
rt43-rt44.patch.xz



Enjoy,

-- Steve


Changes from 3.0.25-rt43:

---

Richard Weinberger (1):
      printk: Disable migration instead of preemption

Steven Rostedt (2):
      Revert "kprobes: adjust "fix a memory leak in function pre_handler_kr=
etprobe()""
      Linux 3.0.25-rt44

----
 kernel/kprobes.c |    4 ++--
 kernel/printk.c  |    4 ++--
 localversion-rt  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
---------------------------
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a7dcf06..9cdbf26 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1661,9 +1661,9 @@ static int __kprobes pre_handler_kretprobe(struct kpr=
obe *p,
 		ri->task =3D current;
=20
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			spin_lock_irqsave(&rp->lock, flags);
+			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
-			spin_unlock_irqrestore(&rp->lock, flags);
+			raw_spin_unlock_irqrestore(&rp->lock, flags);
 			return 0;
 		}
=20
diff --git a/kernel/printk.c b/kernel/printk.c
index 30dc7f0..60f4290 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -900,7 +900,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	boot_delay_msec();
 	printk_delay();
=20
-	preempt_disable();
+	migrate_disable();
 	/* This stops the holder of console_sem just where we want him */
 	raw_local_irq_save(flags);
 	this_cpu =3D smp_processor_id();
@@ -1031,7 +1031,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 out_restore_irqs:
 	raw_local_irq_restore(flags);
=20
-	preempt_enable();
+	migrate_enable();
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
diff --git a/localversion-rt b/localversion-rt
index 41f7b99..ac4d836 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt43
+-rt44


--=-y9ABWiV3psqdnF9fB8Rx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPbNPoAAoJEIy3vGnGbaoAhcAP/2xL5FWpPdD1tFmByUJaO+8N
QR5Qo8DmwThHqqZP9jfagd3BaZV5NnfY/KGsXnalqhmuWoYI93XtGn4hInEsu6pe
oyNyI6ZUCufSWtlsUemXTpHcUB3b82VEiZRd9+4XqMVhXxwIFKhgrr8wJfisL2jV
k5tuZQs0kj6kvM1V4+bJCZIkHM4TmWevfGk1aiMeb6fz3G+iXLaJg1dL66RjwL0w
miQf5wWA0zXzEtjx2HBY6dQMB/usipG7rRNFb8f8ROSdOsV4pFn1rFAw6yAaDgFm
vf2Vb/VmRyWZAygEeQbx2ikjp1QmpJ3Oxa2xUxlf43RM5eKhdmk4/oh+DctMzwP6
BNNJCtUyVrXT6k5v+MHbn3QECp+35Qp59haG3zPr/04k7HqcLDxwcs74ZiDm7xjd
ePK5U2oplnFu5/+4k/HXYKfwrflBzYDyP8ZinJ3UFdKcDkuWEikmApNPg1Q4iNz5
DVokK8r0dDR1caMtR8gVcK82eR542OsZBC4gkaoASyg8/K9hqAdcIEJEZIf4+8fF
i7Fdo7PdIha3ev2406sNzszzGJQL/uStSjV330vhD3JnaYP5EZm3tyEV3elzVlvL
pAhZAv0Wf7kZDIYOyE3y2nVVzfJyGOM83125YPWkb/1zOxEXF2k8kwOmaqKS9Ipq
tvE8GoqyQFZaflZjlDXU
=sVa4
-----END PGP SIGNATURE-----

--=-y9ABWiV3psqdnF9fB8Rx--

