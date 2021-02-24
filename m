Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43778C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB87A64EBB
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhBXJ0X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:26:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhBXJ0W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Feb 2021 04:26:22 -0500
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614158737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6WmisNVMS76SPBoYhZN61NcpUkQSiltoPAHQi3FsUw=;
        b=KYUg1OZJ3Txc+crCg7ArtK4Z0nMnwb7D+iGo3q4m17OPBhFlDWky9aMgdlZ2vfxU0mwTYx
        Q6pGeuCgDky731T1Oc/Vv0TqQxvCq1Vou31SgiGzDeJ2OD2fwm1daoSfwn6xS0qRI399rQ
        xwXo/3mOCbuSRlL50zyDDn1WjsnwMT48vos9ntioQuijI9DmXVVtVgvi9zEKTq3wC9sEPm
        Ou4PiVbL+YJcDArl6GNmVIpigdG6y+DSLQjvCQ9pSJ4Hjj2GcxKPJxv0pBE4itCGi8z8n5
        WuSViri5MnpSxsmbKBoFi7xrduEUqbclq+RFORFXZtRVw5wL4DLrvp+Sh05mbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614158737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X6WmisNVMS76SPBoYhZN61NcpUkQSiltoPAHQi3FsUw=;
        b=ZihiragJVo/aq3wUyTmyK1SuODkgHNEZgJnTQtm0KULoteYIhvX8tVoGJodogP2+BoxKZp
        QvHHdxHPTvkQtwDA==
To:     John Kacur <jkacur@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/2] Fix for machines without numa
In-Reply-To: <20210222220750.12911-1-jkacur@redhat.com>
References: <20210222220750.12911-1-jkacur@redhat.com>
Date:   Wed, 24 Feb 2021 10:25:36 +0100
Message-ID: <87y2fdzujz.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi John,

On Mon Feb 22 2021, John Kacur wrote:
> Trying to return the code to a state where numa is required at compile
> time but not at runtime
>
> - The first patch should allow cyclictest to run on a machine
> without numa.
>
> - The second patch is a clean-up of some old code
>
> The code is pushed in git to branch unstable/devel/no-numa-runtime
> so that people can test before I integrate the code back in the main
> branch

arm32 seems to work fine.

Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # arm32

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmA2G5AACgkQeSpbgcuY
8KZjDQ//dgrPlDaYDgRTY3oIme6CfsGT8zFrR75PPGZPlVon152ZWiGMmR8pUh+z
/nTH7wAn4veTRmxbHhGZ8OQgzIcS7Eyyz/uZ7djpbgH/cnEuOQTmra/c0S4FAJiy
uCh5Jr9N3bZYVNBC8lvgHMtAMigX0ZhPiguguMmz7VumWsJo5B6WgSY8KxxW7CzX
mPrqVhkjOX9XhVBVENkXbh9eNNv5PgfPQyeKDgIw+y5WYg4tGJGizmo8uuhqHpNo
cbkjMIAkiYMebKKLYcAHWI0Az/12//6L2u22nfYD8XDPOA0HtBCWtrQNPNDgpk5C
4SOO830AMQpzkqOTxjGZxtb6NwEw0ZRxOrAQfVbQiB7eww+TJC2gnOSlf0jpytTH
gVXzjNzqLFP9uTNLlS/0b98f5Mgl+MkK8X9Lr4tdFhtmAVHiTYNTuobONMulIcYE
Mwfl5ZXnWx2Ulpu0DigPM6nYlmkm5Cmt4CSUPC6mCUMGaAzRx3Ka1vHMv8iA1JCu
sPhgC8lCchGpeJ7XvbAqGrmR6RYVKrAfvwQhfcd7IT34WNZilwGQ51vOG+wYLJrs
rmKdWwl06PmQj0lHmybtbvLnhoJxCTNohtZNaAgXKkDqG4OSyJxMsf3Dpf4/UJI1
HiLW72Ma2+8ZhMyflsGGVGjD/X4TgLhLpwhDcaC2Go+gWNcWo3o=
=zZda
-----END PGP SIGNATURE-----
--=-=-=--
