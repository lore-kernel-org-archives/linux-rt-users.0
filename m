Return-Path: <SRS0=REGa=5G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB844C4332D
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Mar 2020 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A915320754
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Mar 2020 22:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgCUWnn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:43:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37956 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCUWnm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Mar 2020 18:43:42 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 837B81C031D; Sat, 21 Mar 2020 23:43:40 +0100 (CET)
Date:   Sat, 21 Mar 2020 23:43:40 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pavel Machek <pavel@denx.de>, ben.hutchings@codethink.co.uk,
        Chris.Paterson2@renesas.com, bigeasy@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200321224339.GA20728@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
 <20200319214835.GA29781@duo.ucw.cz>
 <20200319232225.GA7878@duo.ucw.cz>
 <20200319204859.5011a488@gandalf.local.home>
 <20200320195432.GA12666@duo.ucw.cz>
 <20200320160545.26a65de3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20200320160545.26a65de3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 2020-03-20 16:05:45, Steven Rostedt wrote:
> On Fri, 20 Mar 2020 20:54:32 +0100
> Pavel Machek <pavel@denx.de> wrote:
>=20
> > > Does this patch help? =20
> >=20
> > I don't think so. It also failed, and the failure seems to be
> > identical to me.
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux=
-cip
> > https://lava.ciplatform.org/scheduler/job/13110
> >=20
>=20
> Can you send me a patch that shows the difference between the revert that
> you say works, and the upstream v4.19-rt tree (let me know which version
> of v4.19-rt you are basing it on).

I was using -rt44, and yes, I can probably generate better diffs.

But I guess I found it with code review: how does this look to you? I
applied it on top of your fix, and am testing. 2 successes so far.

Signed-off-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel

commit aa034c3060dbab96a7b6d6bf827504b394bed15b
Author: Pavel Machek <pavel@ucw.cz>
Date:   Sat Mar 21 22:58:43 2020 +0100

    It sounds like irq_work_queue() was queueing on wrong list?

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 0ca75c77536b..dd654865c219 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -81,7 +81,8 @@ bool irq_work_queue(struct irq_work *work)
=20
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_I=
RQ))
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_=
IRQ))
+	    || (work->flags & IRQ_WORK_LAZY))
 		list =3D this_cpu_ptr(&lazy_list);
 	else
 		list =3D this_cpu_ptr(&raised_list);



      	    	       	      	  	   	    	   Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnaYmwAKCRAw5/Bqldv6
8uRaAKDCWDFPFwlIeZx/6dVMTBD8FlMUvACdHhXhddDpSG1JLgGg5prAU12umD8=
=0yPB
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
