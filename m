From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Tue, 26 Jul 2011 11:30:29 +0200
Message-ID: <20110726093029.GR16561@pengutronix.de>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
 <4E2E306A.6040007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38806 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1GZJab (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Jul 2011 05:30:31 -0400
Content-Disposition: inline
In-Reply-To: <4E2E306A.6040007@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 25, 2011 at 08:11:38PM -0700, Frank Rowand wrote:
> On 07/24/11 03:33, Thomas Gleixner wrote:
> > Dear RT Folks,
> >=20
> > I'm pleased to announce the 3.0-rt3 release.
>=20
> ARM panda board boots for PREEMPT_NONE.
>=20
> New compile warning for ARM pandaboard, PREEMPT_NONE:
>=20
> kernel/softirq.c: In function 'softirq_check_pending_idle':
> kernel/softirq.c:119: warning: format '%02lx' expects type 'long unsi=
gned int', but argument 2 has type 'unsigned int'
This happens on x86, too.

The obvious fix is:

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 99620ec..af749f6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -77,7 +77,7 @@ char *softirq_to_name[NR_SOFTIRQS] =3D {
 void softirq_check_pending_idle(void)
 {
 	static int rate_limit;
-	u32 warnpending =3D 0, pending =3D local_softirq_pending();
+	unsigned warnpending =3D 0, pending =3D local_softirq_pending();
=20
 	if (rate_limit >=3D 10)
 		return;
@@ -101,7 +101,7 @@ void softirq_check_pending_idle(void)
 	}
=20
 	if (warnpending) {
-		printk(KERN_ERR "NOHZ: local_softirq_pending %02lx\n",
+		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 		       pending);
 		rate_limit++;
 	}
@@ -115,7 +115,7 @@ void softirq_check_pending_idle(void)
 	static int rate_limit;
=20
 	if (rate_limit < 10) {
-		printk(KERN_ERR "NOHZ: local_softirq_pending %02lx\n",
+		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 		       local_softirq_pending());
 		rate_limit++;
 	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
