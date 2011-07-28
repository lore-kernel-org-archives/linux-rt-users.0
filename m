From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 17:41:59 +0800
Message-ID: <20110728094159.GA24590@windriver.com>
References: <alpine.LFD.2.02.1107272222420.2660@ionos>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49894 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1G1JmH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 05:42:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1107272222420.2660@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 27, 2011 at 11:37:09PM +0200, Thomas Gleixner wrote:
> Dear RT Folks,
>=20
> I'm pleased to announce the 3.0-rt4 release.
>=20

Building error if !PREEMPT_RT:

  CC      kernel/hrtimer.o
kernel/hrtimer.c: In function =E2=80=98hrtimer_interrupt=E2=80=99:
kernel/hrtimer.c:1459:27: error: =E2=80=98hrtimer_wakeup=E2=80=99 undec=
lared (first use in this function)
kernel/hrtimer.c:1459:27: note: each undeclared identifier is reported =
only
  once for each function it appears in
make[1]: *** [kernel/hrtimer.o] Error 1

Patch is here and seems it could be scrolled into
hrtimer-fixup-hrtimer-callback-changes-for-preempt-r.patch :)

Thanks,
Yong

---
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 38343f8..a7ec41a 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1295,10 +1295,10 @@ static void __run_hrtimer(struct hrtimer *timer=
, ktime_t *now)
 }
=20
=20
-#ifdef CONFIG_PREEMPT_RT_BASE
