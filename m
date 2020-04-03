Return-Path: <SRS0=GZ+T=5T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE44C2BA12
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980F2076E
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Apr 2020 21:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgDCVzH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:55:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38482 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVzH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Apr 2020 17:55:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 612AB1C3727; Fri,  3 Apr 2020 23:55:05 +0200 (CEST)
Date:   Fri, 3 Apr 2020 23:55:05 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Pavel Machek <pavel@denx.de>, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/3] irq_work: Fix checking of IRQ_WORK_LAZY flag set
 on non PREEMPT_RT
Message-ID: <20200403215504.GA30386@duo.ucw.cz>
References: <20200331163453.805082089@goodmis.org>
 <20200331163513.674653275@goodmis.org>
 <20200402172248.GA12483@duo.ucw.cz>
 <20200402173944.jmztz4vjsepjreye@beryllium.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200402173944.jmztz4vjsepjreye@beryllium.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Thu, Apr 02, 2020 at 07:22:49PM +0200, Pavel Machek wrote:
> > I'm currently playing with 4.4.X branch, but I'll eventually test it.
> >=20
> > Is it possible that 4.4.X branch needs similar patch? My code review
> > suggests so...
>=20
> I was waiting for Steven to post the final patch. I'll pick it up for
> the next v4.4-rt release.

It will not apply cleanly...

Here is version that applies to 4.4, and should compile. Not sure what
other branches it should be applied to.

Best regards,
								Pavel

-- cut --

=46rom: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
   =20
When CONFIG_PREEMPT_RT_FULL is not set, some of the checks for using
lazy_list are not properly made as the IRQ_WORK_LAZY is not checked. There's
two locations that need this update, so a use_lazy_list() helper function is
added and used in both locations.
   =20
Link: https://lore.kernel.org/r/20200321230028.GA22058@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[ported to 4.4]
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..abc65de5d793 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -57,6 +57,12 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
=20
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HA=
RD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 #ifdef CONFIG_SMP
 /*
  * Enqueue the irq_work @work on @cpu unless it's already pending
@@ -78,7 +84,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_I=
RQ))
+	if (use_lazy_list(work))
 		list =3D &per_cpu(lazy_list, cpu);
 	else
 		list =3D &per_cpu(raised_list, cpu);
@@ -95,7 +101,7 @@ EXPORT_SYMBOL_GPL(irq_work_queue_on);
 bool irq_work_queue(struct irq_work *work)
 {
 	struct llist_head *list;
-	bool lazy_work, realtime =3D IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+	int lazy_work;
=20
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
@@ -106,7 +112,7 @@ bool irq_work_queue(struct irq_work *work)
=20
 	lazy_work =3D work->flags & IRQ_WORK_LAZY;
=20
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list =3D this_cpu_ptr(&lazy_list);
 	else
 		list =3D this_cpu_ptr(&raised_list);

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoewuAAKCRAw5/Bqldv6
8vTeAKCQGQAE1YDJl5o4lrii1694NafKzwCgsWfrJmpng+RnTMCaB/MU5sYNvvU=
=DaDO
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
