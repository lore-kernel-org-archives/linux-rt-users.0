Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A275C388F9
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 10:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0412145D
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Nov 2020 10:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIQ13zk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8k5Oflk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgKUKF6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Nov 2020 05:05:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKUKF6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Nov 2020 05:05:58 -0500
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605953156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSZ309XZNty7p3dVz12Z0RFvyQ3N1nDJ9jtlNvv1rW0=;
        b=YIQ13zk2fsxnkU6HteadcmRLRinOVjMIYybiU7MKwEPRDplKWLFWVFCCMPgilnc96sAF73
        ozgpH2x/wzpQqtIS8VcFgD8IfFI34xhW5LF36KRqDVArl1b7DOKOvAKYSnfDj+TZjicvzN
        TxR6BRtHFmFBLKwyuu+cISLFl7ffZq2m1BgoWw9gzmPmHUQyR47qb2/rBwTKq62zgKgZo0
        Kb7HvFw2xeXt2weauTLo53jkQoRYzv9NnNazEpqj/kzwnS0j7iioq0jMhCo9QJKWzjXxs2
        rffk7DKj/3QBPBqc4h8qeh3RlCUf1aFrWkIZDnS2jSACagueRlCtqinyHeFm+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605953156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSZ309XZNty7p3dVz12Z0RFvyQ3N1nDJ9jtlNvv1rW0=;
        b=8k5Oflk1XsMVk+dKBfMquM9oeb1hTb0CMZXacpvVPE2iqkvuXyn0DsDJJStJ+ux4yh6rKp
        6SXiHe/KfkP7CPDg==
To:     John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests: Don't compress man pages by default
In-Reply-To: <20201121051925.24507-1-jkacur@redhat.com>
References: <20201121051925.24507-1-jkacur@redhat.com>
Date:   Sat, 21 Nov 2020 11:05:45 +0100
Message-ID: <87y2ivuirq.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat Nov 21 2020, John Kacur wrote:
> This patch changes the default behavior of the Makefile to install
> man pages without compression. This allows distribution build systems to
> use the kind of compression they wish to use without the Makefile
> getting in the way.
>
> It is still possible to compress the man pages using the Makefile, for
> example
>
> make MAN_COMPRESSION=gzip
>
> or
>
> make MAN_OMPRESSION=bzip2
>
> Signed-off-by: John Kacur <jkacur@redhat.com>

Yea, that's why I introduced that option in the first place :). Up to
now I've used MAN_COMPRESSION=none for build systems.

Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl+45nkACgkQeSpbgcuY
8KbmOg//WJv77C4xfeoW/YmdOpHR/dMRyzmV+BSRB49VS9AK9Fue8ku/V6hrHDcF
lfBW156hCwhoJFKWUMh70tkbbHSVNQ9qh07UUMkIkJt9naAFBfesQkMRmhSR5+Cd
eH9G/d50FhhbmBe597LtwKMbwtOrl8Zshts/NM/ft0LVt5ClW05amPWwY/+sDWgW
3+ufte6/X9Tund1b5CtR4cVrXD1Gsy8QtzjfOf+Z882a5W/BHaYyPHG/T5vc9cT2
hhL8jsCkvs8UQci0di9rflFbOjSK6ROcg2xirI/ZGgRiuiIskVUROEPYNnHLvCal
KoVFhNXYHf0eq05Nj1WUG9ap2lFpv3vApHH2v5R2BPk3latRXqN+xfKSsjemfALu
A3INrdP6W3250EWsJ6Gw0JZ0Zx7URyBqjzA9qMGDwcx8Ab1M5jh7qK6T0bLsYNBt
/UtYd0EU8OWO6n5NTzSf9N72pozpWVykFclW51CoyEYeSsVKwia8im+o050X73EV
jJiUJsofPWNW0l3YJ+DQ9XOzsvWOEpbMXJwihdSrkbIyVzjGq9/w5fb0zhHdBjO9
1cKvnxldey14g/9jy99zw+UNDa209sHYjREtALwa1+ctU+ExtetlbN0xY8L+quSC
IxaZZcqlhfK87eqZQ+yL4ueRIlJRPEwDSixPGvyp3/0xZ70Jtf4=
=gdpX
-----END PGP SIGNATURE-----
--=-=-=--
