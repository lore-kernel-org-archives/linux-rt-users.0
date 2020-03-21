Return-Path: <SRS0=REGa=5G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D19C43332
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Mar 2020 23:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8B20776
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Mar 2020 23:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCUXAb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Mar 2020 19:00:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39316 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCUXAb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Mar 2020 19:00:31 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 09D021C031D; Sun, 22 Mar 2020 00:00:29 +0100 (CET)
Date:   Sun, 22 Mar 2020 00:00:28 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com,
        bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: 4.19.106-rt44 -- boot problems with irqwork: push most work into
 softirq context
Message-ID: <20200321230028.GA22058@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
 <20200319214835.GA29781@duo.ucw.cz>
 <20200319232225.GA7878@duo.ucw.cz>
 <20200319204859.5011a488@gandalf.local.home>
 <20200320195432.GA12666@duo.ucw.cz>
 <20200320160545.26a65de3@gandalf.local.home>
 <20200321224339.GA20728@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20200321224339.GA20728@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Does this patch help? =20
> > >=20
> > > I don't think so. It also failed, and the failure seems to be
> > > identical to me.
> > >=20
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/lin=
ux-cip
> > > https://lava.ciplatform.org/scheduler/job/13110
> > >=20
> >=20
> > Can you send me a patch that shows the difference between the revert th=
at
> > you say works, and the upstream v4.19-rt tree (let me know which version
> > of v4.19-rt you are basing it on).
>=20
> I was using -rt44, and yes, I can probably generate better diffs.
>=20
> But I guess I found it with code review: how does this look to you? I
> applied it on top of your fix, and am testing. 2 successes so far.

And I'd recommend some kind of cleanup on top. The code is really
"interesting" and we don't want to have two copies. Totally untested.

Looking at the code, it could be probably cleaned up further.

Signed-off-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index dd654865c219..88211b87d4e3 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,10 +70,19 @@ static void __irq_work_queue_local(struct irq_work *wor=
k, struct llist_head *lis
 		arch_irq_work_raise();
 }
=20
+static struct llist_head *irq_work_get_list(struct irq_work *work)
+{
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_=
IRQ))
+	    || (work->flags & IRQ_WORK_LAZY))
+		return &lazy_list;
+	else
+		return &raised_list;
+}
+
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
-	struct llist_head *list;
+    	struct llist_head *list;
=20
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
@@ -81,12 +90,7 @@ bool irq_work_queue(struct irq_work *work)
=20
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-	if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_=
IRQ))
-	    || (work->flags & IRQ_WORK_LAZY))
-		list =3D this_cpu_ptr(&lazy_list);
-	else
-		list =3D this_cpu_ptr(&raised_list);
-
+	list =3D this_cpu_ptr(irq_work_get_list(work));
 	__irq_work_queue_local(work, list);
 	preempt_enable();
=20
@@ -107,7 +111,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
=20
 #else /* CONFIG_SMP: */
 	struct llist_head *list;
-	bool lazy_work, realtime =3D IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
=20
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -117,13 +120,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		return false;
=20
 	preempt_disable();
-
-	lazy_work =3D work->flags & IRQ_WORK_LAZY;
-
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
-		list =3D &per_cpu(lazy_list, cpu);
-	else
-		list =3D &per_cpu(raised_list, cpu);
+	list =3D irq_work_get_list(work);
+	list =3D &per_cpu(list, cpu);
=20
 	if (cpu !=3D smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnacjAAKCRAw5/Bqldv6
8u1uAKDColTWBy5Sf9XUN9wBwEEQZNtAIACfd7mBdPEhE4ljF50+So+QdRUKGqo=
=6Fcv
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
