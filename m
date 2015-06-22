From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] rtmutex: fixup semi incomplete backport causing new warning spew
Date: Mon, 22 Jun 2015 18:23:07 -0400
Message-ID: <1435011787-29356-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39012 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbFVWZq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jun 2015 18:25:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We have a backport of commit 8930ed80f970a90a795239e7415c9b0e6f964649
("rtmutex: Cleanup deadlock detector debug logic") which is commit
8a3af0727b43a6e51e3699f62bd15f9bb60e0692 here on the v3.10-rt branch,
added in the creation v3.10.70-rt75.  However it missed one of the
conversions from the old int to the new enum, leading to this spew:

  CC      kernel/rtmutex.o
kernel/rtmutex.c: In function =E2=80=98rt_mutex_timed_futex_lock=E2=80=99=
:
kernel/rtmutex.c:1709:37: warning: passing argument 5 of =E2=80=98rt_mu=
tex_timed_fastlock=E2=80=99 from incompatible pointer type
            RT_MUTEX_FULL_CHAINWALK, rt_mutex_slowlock);
                                     ^
kernel/rtmutex.c:1634:1: note: expected =E2=80=98int (*)(struct rt_mute=
x *, int,  struct hrtimer_sleeper *, int)=E2=80=99 but argument is of t=
ype =E2=80=98int (*)(struct rt_mutex *, int,  struct hrtimer_sleeper *,=
 enum rtmutex_chainwalk)=E2=80=99
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 ^
kernel/rtmutex.c: In function =E2=80=98rt_mutex_timed_lock=E2=80=99:
kernel/rtmutex.c:1749:36: warning: passing argument 5 of =E2=80=98rt_mu=
tex_timed_fastlock=E2=80=99 from incompatible pointer type
            RT_MUTEX_MIN_CHAINWALK, rt_mutex_slowlock);
                                    ^
kernel/rtmutex.c:1634:1: note: expected =E2=80=98int (*)(struct rt_mute=
x *, int,  struct hrtimer_sleeper *, int)=E2=80=99 but argument is of t=
ype =E2=80=98int (*)(struct rt_mutex *, int,  struct hrtimer_sleeper *,=
 enum rtmutex_chainwalk)=E2=80=99
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 ^

Slightly hard to wrap your head around, but once you do, the missing
conversion is clear, and once fixed, all rtmutex warnings are gone.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 5388ba98acaf..7213fd35ffce 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -1636,7 +1636,7 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, in=
t state,
 			enum rtmutex_chainwalk chwalk,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock))
+				      enum rtmutex_chainwalk chwalk))
 {
 	if (chwalk =3D=3D RT_MUTEX_MIN_CHAINWALK &&
 	    likely(rt_mutex_cmpxchg(lock, NULL, current))) {
--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
