Return-Path: <SRS0=VhXN=5O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5835C43331
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Mar 2020 10:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A276D20732
	for <linux-rt-users@archiver.kernel.org>; Sun, 29 Mar 2020 10:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgC2KJO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:09:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56014 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KJO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 29 Mar 2020 06:09:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 785261C0323; Sun, 29 Mar 2020 12:09:12 +0200 (CEST)
Date:   Sun, 29 Mar 2020 12:09:11 +0200
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
Subject: 4.4-rt ... seems to have same ireqwork problem was Re: 4.19.106-rt44
 -- boot problems with irqwork: push most work into softirq context
Message-ID: <20200329100911.GA6044@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
 <20200319214835.GA29781@duo.ucw.cz>
 <20200319232225.GA7878@duo.ucw.cz>
 <20200319204859.5011a488@gandalf.local.home>
 <20200320195432.GA12666@duo.ucw.cz>
 <20200320160545.26a65de3@gandalf.local.home>
 <20200321224339.GA20728@duo.ucw.cz>
 <20200321230028.GA22058@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20200321230028.GA22058@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > Does this patch help? =20
> > > >=20
> > > > I don't think so. It also failed, and the failure seems to be
> > > > identical to me.
> > > >=20
> > > > https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/l=
inux-cip
> > > > https://lava.ciplatform.org/scheduler/job/13110
> > > >=20
> > >=20
> > > Can you send me a patch that shows the difference between the revert =
that
> > > you say works, and the upstream v4.19-rt tree (let me know which vers=
ion
> > > of v4.19-rt you are basing it on).
> >=20
> > I was using -rt44, and yes, I can probably generate better diffs.
> >=20
> > But I guess I found it with code review: how does this look to you? I
> > applied it on top of your fix, and am testing. 2 successes so far.
>=20
> And I'd recommend some kind of cleanup on top. The code is really
> "interesting" and we don't want to have two copies. Totally untested.
>=20
> Looking at the code, it could be probably cleaned up further.

It seems 4.4 branch has same problem. Unfortunately, our testing lab
does not help in this case, so .. this is completely untested. Problem
was found by code inspection.

Best regards,
								Pavel

Signed-off-by: Pavel Machek <pavel@denx.de>
Fixes: fc9f4631a290 ("irqwork: push most work into softirq context")

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2899ba0d23d1..19896e6f1b2a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -78,7 +78,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_I=
RQ))
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_=
IRQ))
+	    || (work->flags & IRQ_WORK_LAZY))
 		list =3D &per_cpu(lazy_list, cpu);
 	else
 		list =3D &per_cpu(raised_list, cpu);



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXoBzxwAKCRAw5/Bqldv6
8nrJAJ45k6f/RGYw8Bj5B9J1rR8AeBQOpQCgr0dyWzkNL64ZIzwXYSCHeGsupRc=
=jzfE
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
