Return-Path: <SRS0=7Euv=5F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4414C4332D
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52BF20739
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Mar 2020 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCTTyf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:54:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55914 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTTyf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Mar 2020 15:54:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 07F9C1C0337; Fri, 20 Mar 2020 20:54:33 +0100 (CET)
Date:   Fri, 20 Mar 2020 20:54:32 +0100
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
Message-ID: <20200320195432.GA12666@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
 <20200319214835.GA29781@duo.ucw.cz>
 <20200319232225.GA7878@duo.ucw.cz>
 <20200319204859.5011a488@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20200319204859.5011a488@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > I'm pleased to announce the 4.19.106-rt44 stable release.
> > > >=20
> > > >=20
> > > > This release is just an update to the new stable 4.19.106 version
> > > > and no RT specific changes have been made.
> > > >=20
> > > >=20
> > > > You can get this release via the git tree at:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.=
git
> > > >=20
> > > >   branch: v4.19-rt
> > > >   Head SHA1: 0f2960c75dd68d339f0aff2935f51652b5625fbf =20
> > >=20
> > > This brought some problems for me. de0-nano board now fails to boot in
> > > cca 50% of cases if I move these patches on top of -cip tree.
> > >=20
> > > This is example of failed job:
> > >=20
> > > https://lava.ciplatform.org/scheduler/job/13037
> > >=20
> > > de0-nano is 32-bit arm, should be based on Altera SoCFPGA if I unders=
tand
> > > things correctly.
> > >=20
> > > "fc9f4631a290 irqwork: push most work into softirq context" touches
> > > area of the panic above. I tried to revert it on top of the full
> > > series, and tests passed twice so far... =20
> >=20
> > Test passed 7 times now. So yes, reverting this fixes de0-nano
> > boot. Any ideas what might be wrong?
> >=20
> > I'll be running it few more times.
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/127953471
> >=20
>=20
> Looks like you are running this without PREEMPT_RT enabled.

Yes. We still need to set up proper realtime testing.

> Does this patch help?

I don't think so. It also failed, and the failure seems to be
identical to me.

https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip
https://lava.ciplatform.org/scheduler/job/13110

Best regards,
								Pavel

> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 2940622da5b3..0ca75c77536b 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -146,8 +146,9 @@ bool irq_work_needs_cpu(void)
>  	raised =3D this_cpu_ptr(&raised_list);
>  	lazy =3D this_cpu_ptr(&lazy_list);
> =20
> -	if (llist_empty(raised) && llist_empty(lazy))
> -		return false;
> +	if (llist_empty(raised) || arch_irq_work_has_interrupt())
> +		if (llist_empty(lazy))
> +			return false;
> =20
>  	/* All work should have been flushed before going offline */
>  	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnUfeAAKCRAw5/Bqldv6
8gb1AKC4UHRzoJ+y/GLlVi4otvGsEmA4sQCePb1SuYIyKncm+OugidDI7k92Xeo=
=0kmu
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
