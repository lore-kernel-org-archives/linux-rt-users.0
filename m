Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4278C11F66
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 06:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9281661DC4
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 06:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhF2GqS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:46:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhF2GqS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 02:46:18 -0400
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624949030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3O5iHVw0GIR4P598xeOTWd9+nvz4VCj5AwL14qMfrSc=;
        b=UgxgYimLuBtDhbGC3Jf+KV/JJbKWQAmL8GHCu7B+v3ho5Uc4+wLwLFan6+JU/Ar3bOEfle
        n/HvIHgGKOiayRmSGLUtRHm3lWerfDe/ajDRsUCJAMXmmeFS1hwQcDF+PlnS6STCgpT61Q
        UWSHbXM1NRXMKckMtq3Iw8B8++N51YGwgirEZueb6HEzi5fn1yOnPvsQPY2XRdAUxr6yCw
        0O33XRndvRG9D8wXYY5HuS3SjE5UyuI/S+ls6jC0strZsOHEyGelbEE9looihJ3fZuRjqP
        PrgMd2nhDGOwqDr/1u/8CLD98QZyFDtUfz68b3e1XcCoied67XTu5S5Se5Kr7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624949030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3O5iHVw0GIR4P598xeOTWd9+nvz4VCj5AwL14qMfrSc=;
        b=fgnshE5iGKwZ0VZUYPhE9XGgmH/C/3lzn1RjmPuQ5FXQbYNPme/KX1evcQSOPkuWh9V1p+
        6JSirCDUU8H1z5AA==
To:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH rt-tests v1 1/2] rt-utils: Call get_timestmap() in
 rt_init()
In-Reply-To: <20210628201203.30974-2-dwagner@suse.de>
References: <20210628201203.30974-1-dwagner@suse.de>
 <20210628201203.30974-2-dwagner@suse.de>
Date:   Tue, 29 Jun 2021 08:43:49 +0200
Message-ID: <87r1gl6uhm.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Daniel,

On Mon Jun 28 2021, Daniel Wagner wrote:
> Move the get_timestamp() from rt_test_start() to rt_init(). The idea
> of rt_test_start() was to get the start timestamp right before the
> 'main loop' for the test starts. At least for cyclictest the
> rt_test_start() was placed wrongly so that the first test cycle could
> hit the pagefault when strftime() wrote into the tsbuf.
>
> We don't have an exact semantic description what start test timestamp
> means, so the simplest thing to avoid any further problems with it, is
> to take the timestamp right at the beginning when the program
> starts. Most test programs have a very short setup phase anyway.
>
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

This fixes the issue for me:

Tested-by: Kurt Kanzenbach <kurt@linutronix.de>

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmDawSUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRB5KluBy5jwpsyIEACk8j+pTRm4AuSbCvO+jKbtX7kEQkAh
zqQjjdfB0VeUyElVVG5t+E8bQ850PdyrFCCyI+n4f8FnR2qEmFMPKUuxpK00R0wb
fTLXDdCRfyqeWJ7Ruk0X38G2V9cJsiPZ2vnsDbLykcAEoQX9UT7gsZSP1MHd/956
xxdg9kN7m/122EALPcboUAkL0101oEdGIoFZgMyW66TnsAwsl7Osxw64YQ6bu5et
F2UC6e57vlObgO1UAu0/jw3pkIDH/63976jJLqRdaH4fx4+RKIWnb5BC3foOq2vu
WiT4cmTfuXT+vWM+XZZiUv977sB65Mpk4tiJIx3vZy0HJLtAi7gc5Jbk+7pENMMo
EdWQJfDIh6AP8CjbPtgIAjura3hfiCOkAjw00QbWqgzATz0okU4mVtMmcI5oARy9
TInvNvDBfD8YDfQcvJLUu7kuthyiqM3RKoVjNkpZwzNRgVipiu6uRJji79ZtYgzI
bulffsH+qzhJlkD0muHeErz0bV5DPeXrS27MxnzVt4AlAA3HEm2oUN5FGIipaWWh
eIhelDpdGayJJlHwed61XFdizWvpLORm1XuHU18acRChtlSf19kvckkHl+l6duup
Z7keijO192fI0IThMzWPYRO+HvPbRMnAyVhIGfbiqC1Ak41FGSrNNGWfZ8eWPU3W
Q48n/uVjPHvqXQ==
=HLuD
-----END PGP SIGNATURE-----
--=-=-=--
