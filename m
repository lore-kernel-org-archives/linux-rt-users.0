From: Clark Williams <williams@redhat.com>
Subject: [PATCH] [PREEMPT_RT] make pagefault_{disable,enable}() back into
 static inlines
Date: Fri, 1 Feb 2013 17:06:56 -0600
Message-ID: <20130201170656.75c0ce3c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/GcB7YkkRro/k7IwNWseJEd9"; protocol="application/pgp-signature"
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/GcB7YkkRro/k7IwNWseJEd9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thomas,

The PREEMPT_RT behavior of moving pagefault_disable() and
pagefault_enable() into mm/memory.c as EXPORT_SYMBOL_GPL symbols breaks
compilation of a third-party driver that builds fine on a stock kernel.
Yes, I know, I know, it's a binary driver, but my problem is that it
already compiles and works on a stock kernel; the compile breaks only
on a PREEMPT_RT kernel. The driver doesn't use the fault routines
directly but the symbols get pulled in due to references in
include/linux/io-memory.h.

One way to "fix" it would be to change the definitions to EXPORT_SYMBOL,
but what I wondered is if we should move them back into uaccess.h as
static inlines (like the upstream versions). I've done that in the
attached patch and it seems to work fine. What I'm not sure of are the
performance implications of calling migrate_{disable,enable} from a
static inline.=20

Thoughts?

Signed-off-by: Clark Williams <williams@redhat.com>
---
 include/linux/uaccess.h | 25 +++++++++++++++++++++++--
 mm/memory.c             | 26 --------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 44b3751..f2f6c08 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -4,6 +4,8 @@
 #include <linux/preempt.h>
 #include <asm/uaccess.h>
=20
+#include <linux/sched.h>
+
 /*
  * These routines enable/disable the pagefault handler in that
  * it will not take any MM locks and go straight to the fixup table.
@@ -33,8 +35,27 @@ static inline void pagefault_enable(void)
 	raw_pagefault_enable();
 }
 #else
-extern void pagefault_disable(void);
-extern void pagefault_enable(void);
+static inline void pagefault_disable(void)
+{
+	migrate_disable();
+	current->pagefault_disabled++;
+	/*
+	 * make sure to have issued the store before a pagefault
+	 * can hit.
+	 */
+	barrier();
+}
+
+static inline void pagefault_enable(void)
+{
+	/*
+	 * make sure to issue those last loads/stores before enabling
+	 * the pagefault handler again.
+	 */
+	barrier();
+	current->pagefault_disabled--;
+	migrate_enable();
+}
 #endif
=20
 #ifndef ARCH_HAS_NOCACHE_UACCESS
diff --git a/mm/memory.c b/mm/memory.c
index 66f0ca8..6140eb8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3484,32 +3484,6 @@ unlock:
 	return 0;
 }
=20
-#ifdef CONFIG_PREEMPT_RT_FULL
-void pagefault_disable(void)
-{
-	migrate_disable();
-	current->pagefault_disabled++;
-	/*
-	 * make sure to have issued the store before a pagefault
-	 * can hit.
-	 */
-	barrier();
-}
-EXPORT_SYMBOL_GPL(pagefault_disable);
-
-void pagefault_enable(void)
-{
-	/*
-	 * make sure to issue those last loads/stores before enabling
-	 * the pagefault handler again.
-	 */
-	barrier();
-	current->pagefault_disabled--;
-	migrate_enable();
-}
-EXPORT_SYMBOL_GPL(pagefault_enable);
-#endif
-
 /*
  * By the time we get here, we already hold the mm semaphore
  */
--=20
1.7.11.7


--Sig_/GcB7YkkRro/k7IwNWseJEd9
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEMSpkACgkQHyuj/+TTEp20xgCgoCvUAbTqn+yC3njKxkTBpTBu
3x4AnibtJAgso1lgxfHn3PwVnYz1xseZ
=ATzR
-----END PGP SIGNATURE-----

--Sig_/GcB7YkkRro/k7IwNWseJEd9--
