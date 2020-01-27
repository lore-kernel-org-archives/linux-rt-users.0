Return-Path: <SRS0=nqJC=3Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1EEC32771
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 10:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD54D207FD
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgA0KpC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:45:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgA0KpC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jan 2020 05:45:02 -0500
Received: from [5.158.153.52] (helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iw1t5-0000oU-NC; Mon, 27 Jan 2020 11:44:59 +0100
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/9] rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
In-Reply-To: <20200123205029.20176-3-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com> <20200123205029.20176-3-jkacur@redhat.com>
Date:   Mon, 27 Jan 2020 11:44:59 +0100
Message-ID: <877e1dxjo4.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi John,

On Thu Jan 23 2020, John Kacur wrote:
> - Add a simple manpage for cyclicdeadline
> - Install it from the Makefile
>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  Makefile                            |  1 +
>  src/sched_deadline/cyclicdeadline.8 | 53 +++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 src/sched_deadline/cyclicdeadline.8
>
> diff --git a/Makefile b/Makefile
> index 552b3fe885cc..e2142ba3f4e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -193,6 +193,7 @@ install: all install_hwlatdetect
>  	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
>  	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
>  	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
> +	gzip -c src/sched_deadline/cyclicdeadline.8 >"$(DESTDIR)$(mandir)/man8/cyclicdeadline.8.gz"

I'm just wondering about this. Why are the man pages compressed in the
Makefile? Actually most package management systems compress the man
pages themselves. Users may want to use bz2 or something else.

In fact, I have a patch on top of rt-tests v1.6 in Gentoo which removes
the compression, because portage complains about it.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl4uvysACgkQeSpbgcuY
8Kbznw//Q0CgHnVJVRhVgjNTNPLK/YpitthY+LQhBGtj4jdhZrzy+lvHwpvcfC7n
etnUFiW916o6XVouzYrNUuq4p8VZyHS2svC6ZvdLT71ubW2UtmrsqKlNw99c0dO5
8Kr7jysePclKVR7VS4jBXkW4+0AZfREmxXNoYtAEAi4UOxnE95CkXmnCHxB4Qb3K
/JcULlvopB6l45kifLUIblXPBpfzSj55C/4yZohqYSvO7jwZgIl4/FgDHjwrwF8M
YeNUxNTn5qipnrHTb3KFG0YAlC5c4iH5UYLc1xAexk3tlK8wtb+230sXtO0xoJcP
jIHIRD7fT48jsr96xubxtCCFlJ3QVLFbmQW1eq7nV+w50Lr/8wad/iQakvDkiiks
K0WU3E4PSGoM822pLU0TDCzSz8VY2AHlvMTDsoOocQ7X7yu4PMGDHApaB8gYedga
NwB79/4mqKH02wW/M1LwN6zMdQ6du8wXhnlsG1dYHdd48BpsjLIYmThlxQjvFTkv
wr0lw2d+mqwCivgB9XawlDW2gTnO90Q6Z3OofaCzlUHG1UyXa0adrvn25CBLR3T2
w2MpjGvUltSPHfWVaPJyqCxjr14ZJuPaLP/8PQ8ChyyyZrpnj7ozVDqqieMw14Zq
2r4/YpQQVXoqNghI7L2ZI+7coDvEHhHQ549S3ObQA1l9BFyW08c=
=HD39
-----END PGP SIGNATURE-----
--=-=-=--
