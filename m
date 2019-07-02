Return-Path: <SRS0=UpHf=U7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BCDC5B57D
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BFA2146F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 07:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfGBHEq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:04:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGBHEq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jul 2019 03:04:46 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1hiCpv-0000AJ-5i; Tue, 02 Jul 2019 09:04:19 +0200
Date:   Tue, 2 Jul 2019 09:04:18 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Corey Minyard <cminyard@mvista.com>,
        Corey Minyard <minyard@acm.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190702070418.h6ynkkgk6v6s3aii@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190628214903.6f92a9ea@oasis.local.home>
 <20190701190949.GB4336@minyard.net>
 <20190701161840.1a53c9e4@gandalf.local.home>
 <20190701204325.GD5041@minyard.net>
 <20190701170602.2fdb35c2@gandalf.local.home>
 <20190701171333.37cc0567@gandalf.local.home>
 <20190701172825.7d861e85@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7vyok5bdebzdhy5e"
Content-Disposition: inline
In-Reply-To: <20190701172825.7d861e85@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--7vyok5bdebzdhy5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jul 01, 2019 at 05:28:25PM -0400, Steven Rostedt wrote:
> On Mon, 1 Jul 2019 17:13:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 1 Jul 2019 17:06:02 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Mon, 1 Jul 2019 15:43:25 -0500
> > > Corey Minyard <cminyard@mvista.com> wrote:
> > >
> > >
> > > > I show that patch is already applied at
> > > >
> > > >     1921ea799b7dc561c97185538100271d88ee47db
> > > >     sched/completion: Fix a lockup in wait_for_completion()
> > > >
> > > > git describe --contains 1921ea799b7dc561c97185538100271d88ee47db
> > > > v4.19.37-rt20~1
> > > >
> > > > So I'm not sure what is going on.
> > >
> > > Bah, I'm replying to the wrong commit that I'm having issues with.
> > >
> > > I searched your name to find the patch that is of trouble, and picked
> > > this one.
> > >
> > > I'll go find the problem patch, sorry for the noise on this one.
> > >
> >
> > No, I did reply to the right email, but it wasn't the top patch I was
> > having issues with. It was the patch I replied to:
> >
> > This change below that Sebastian marked as stable-rt is what is causing
> > me an issue. Not the patch that started the thread.
> >
>
> In fact, my system doesn't boot with this commit in 5.0-rt.
>
> If I revert 90e1b18eba2ae4a729 ("swait: Delete the task from after a
> wakeup occured") the machine boots again.
>
> Sebastian, I think that's a bad commit, please revert it.

I'm having the same problem on a Cyclone V based ARM board. Reverting
this commit solves the boot issue for me as well.

Thanks,
Kurt

--7vyok5bdebzdhy5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl0bAfIACgkQeSpbgcuY
8KZ9rg/9FckLlD8kORcH3JuRYUFpoKf6pvs6L4rSIoDYOm6YJY7E3sgbCHpPwBdR
6BeSRAOmLJCwPkcOVM9dfU7HNTuR7zfBL4DUSdHOjf/Ut2dsPskyjElOXnjhj9HF
XswGR1dc5PWrYZNLMouVVGEvLeJ/imOzzDont/JXlturwAtGlXEef29m4IQ3xSlQ
hV4lNQZtzHtyvsFD20IGg/EELBlZsSE8Bjs16Hoij0sYDUQfw5WO9roz5HmY6gpg
7x2djlmMZxkLJUmonPOLsoGO29Aw5nrLqqCVz/hhlNPEW0WR77k6DEBqmrSrgCBA
sDrPfzHfEw32M9GXgja8lfWBtqOEHk/j1JP7ggTc/bsYESe1HSj9zvLUYjTTyAiV
SAhDcjER4fofYTsq0Wy/cOTpRHf/NLF9qkLDzMzyJ5ZOj8cHUP68s3n/yFoByIZg
ZXKFh5eWlQiUkkhnZ9Xzl8oPr4LSKpwM02AzxD2CalYopyFUsHB/vQR9fbCv5MPa
Hk3nZjtgKoZ0TfzGtDyji/ggV342y/WrMHJc2A6AL53b/UHLNOuou85/c9+5Rl2m
lIvt8VA46m0fafScqgk3YecIkCLmpKWarhrjLrew6oBYiGDRHiUvaccLMx64w974
nyM51bRCuPcc1GPz0yGqLUZUxVmQInJ66/tirQG0nPfNuEemAPM=
=/qd2
-----END PGP SIGNATURE-----

--7vyok5bdebzdhy5e--
