From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [ANNOUNCE] 3.8.4-rt1
Date: Sat, 23 Mar 2013 00:31:29 -0300
Message-ID: <20130323033129.GA3969@uudg.org>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:50388 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422854Ab3CWDbe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 23:31:34 -0400
Received: by mail-yh0-f42.google.com with SMTP id b12so212592yha.1
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Mar 2013 20:31:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1303222301010.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 22, 2013 at 11:10:11PM +0100, Thomas Gleixner wrote:
| Dear RT Folks,
|=20
| I'm pleased to announce the 3.8.4-rt1 release.
|=20
| Again the credit for the heavy lifting goes to Sebastian Siewior, AKA
| bigeasy, who took up most of the work to get this out. He's on my
| companies engineering team and I hope you trust him as much as I do.
|=20
| Known issues:
|=20
|       - SLUB behaves worse than SLAB on ARM
|       - SLAB is broken on PowerPC
|=20
| Still we think that it's time to get out the stuff for broader
| testing. It's -rt1 and we need your help to get this stabilized.

I had to put two ugly hacks in place in order to let kernel build progr=
ess
a bit further. Even though they are not elegant at all, they can hint a=
 way
to fix the two issues listed below:

fs/fscache/page.c: In function =E2=80=98fscache_invalidate_writes=E2=80=
=99:
fs/fscache/page.c:799:9: error: expected expression before =E2=80=98do=E2=
=80=99

and

drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98mutex_is_locked_b=
y=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:4370:14: error: =E2=80=98struct mutex=E2=
=80=99 has no member named =E2=80=98owner=E2=80=99


diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i91=
5_gem.c
index de45b60..d2b04fc 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -4367,7 +4367,11 @@ static bool mutex_is_locked_by(struct mutex *mut=
ex, struct task_struct *task)
 		return false;
=20
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_MUTEXES)
+#ifdef CONFIG_PREEMPT_RT_FULL
+	return mutex->lock.owner =3D=3D task;
+#else
 	return mutex->owner =3D=3D task;
+#endif
 #else
 	/* Since UP may be pre-empted, we cannot assume that we own the lock =
*/
 	return false;
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index ff000e5..d607a58 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -788,6 +788,12 @@ superseded:
 /*
  * Clear the pages pending writing for invalidation
  */
+
+static inline void lock_cookie(spinlock_t *lock)
+{
+	spin_lock(lock);
+}
+
 void fscache_invalidate_writes(struct fscache_cookie *cookie)
 {
 	struct page *page;
@@ -796,7 +802,7 @@ void fscache_invalidate_writes(struct fscache_cooki=
e *cookie)
=20
 	_enter("");
=20
-	while (spin_lock(&cookie->stores_lock),
+	while (lock_cookie(&cookie->stores_lock),
 	       n =3D radix_tree_gang_lookup_tag(&cookie->stores, results, 0,
 					      ARRAY_SIZE(results),
 					      FSCACHE_COOKIE_PENDING_TAG),
--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
