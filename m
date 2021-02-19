Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F480C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 13:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E552864E46
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 13:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBSNpV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 08:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBSNpT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 08:45:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6BC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 05:44:39 -0800 (PST)
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613742277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItKJlxMJsEmzyXbl7SUx/JZlOvc8hGmdiv/xG/lT6BQ=;
        b=EBZC70EiNEr1Lr8kcnUOO7dbHEglgemDEx289xx2VuLSnpDOHnDtfbYDzXF8On/V7XW80i
        +sxLMRRYC9mWRJcTq7hJe1PxZUcypHAh5W6dv4K4Y17iAQHB5+8WABT+EwptPNF3j6E05S
        +Qro/J9qwqYB4lw0xIzcGEIGfShyab3MOYj7qQXUTVyTq3dMHedi1Ibwc6MyTBCbNX0q1D
        LUx13MajbIeuMDF1Jn7GAoSJVCJEWyNC4rDQpjy8OstJ3xo+A3U9T6NdcyBbI/TmSxBtW5
        W/fNZ/uhKt2HdQpp7LFMMT5m8iz3ziy3AwhFJd5ckOGPmAmAwuFmdOy/8pQg5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613742277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItKJlxMJsEmzyXbl7SUx/JZlOvc8hGmdiv/xG/lT6BQ=;
        b=pe0nT2jBhynJn9zuYrfQkMnpNIuUxAn2dk7w2IFR5IuUuK9I8De/Up5eSGjpoSHNx2DU0S
        8YSHSrBK28e6t5Bw==
To:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <20201218161843.1764-2-dwagner@suse.de>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-2-dwagner@suse.de>
Date:   Fri, 19 Feb 2021 14:44:36 +0100
Message-ID: <878s7k41ff.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri Dec 18 2020, Daniel Wagner wrote:
> libnuma is hard dependency for cyclictest. Thus we can always call
> numa_initialize(). This allows us to remove the global 'numa' variable
> to track if libnuma has been initialized or not.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

It seems like with this particular commit, it's not possible to run
cyclictest on arm32 systems anymore. I guess due to missing NUMA
support?

Just tested on a dual core Cyclone V:

root@tsn:~/rt-tests# ./cyclictest -S -m -p 99 --secaligned
FATAL: Couldn't initialize libnuma
root@tsn:~/rt-tests#=20

I've used the current unstable/devel/latest branch. Any suggestions?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmAvwMQACgkQeSpbgcuY
8KbOxBAAmtO8QLe2pChThhCOD1wPmvowNmLsKT2hC5tivXVU4rtNIv/IZCkrkj1D
KAmnI6ph41YrNQOxMaGPxUCnqaxaUNcIziwyohX5e4V7JYaqyF3phrNnXjEtA7rb
7b6wkug5qu99P/LGgC+wPzbipRz1Sv1QsM25MVoJt9/N9YD/9u13IMwOOHhVezpm
gjNHglwc+JDQ0Ral9reZ1PZPXuSJBuDuYHa4LXmaPY8g8tiT2LzG8mo+rXTxsuLh
ZZpnRo4m3SkknFu7MPSLpRyeW6sh7yVuzo0iGMdvfEI9wESSLTrNtSgWMIbDJYo/
Jj9aNKO8oCEHeo187ZlLm0Y+qKCcIR44Fz8QAEAcnSAXQd+IdmwZJWmIx3cQmRYK
F+pKF6KQ+nZl2pZiyJXAU7MUmM9P7sonqgoYPf4961ygjRwK2Ygi4vdk+S3GcsV7
GJFtGKDt6hrziC5XaIIvckbTR+7TWATftuVWLx9hlp+5UkNkXytbP4GiX8piXkG7
mdPYhzoSZNItdrFwkTAjytgsror4gki0/OEt4PPSSFiivD6eKubGUHIw7kHMfeh4
9u6bhq8i0UZ40rWwt2bZE73wO+RTrOVATcavHxH+y4cbP3cmrsc36JrHLyuXjbwj
YogMjW+3NGxY/AeLuXBCH2JGM1R3Y5o8GDjI9nHxh2L6tc7RTII=
=3iyu
-----END PGP SIGNATURE-----
--=-=-=--
