Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ABDC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5478664DA8
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 14:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBSOka (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 09:40:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBSOk3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 09:40:29 -0500
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613745586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BLyxi+W5jFD0GGWwkGXWpkuC/j7ZiaoxH3rL3WJIYc=;
        b=thwvYKEY4OjmM2KtzhUwuhAXblc0Ws16ouTV+UUr5BbeW45AAwZ/ogQB3Gm+XWlBeLwG1B
        L/6x/LjXsiGMCWVrLVDgvyGBYQWHtAIp2E0AzYeDFxnN4Sz0Rqp6/ZNf3djHPNdyUAjBS/
        yvioaYHYeL3lsupGbuULpU5C17l4eR5Ef6WBPhfOd2yzHeSaD/m/MHI7lGLaXdFawQVIc7
        OtAsG5NlCfu20dqMb9eWAFzkqRgYfJP/mOsMMNsi1WfNdvTHVfT0LrdmNl6AX6Ty25We9G
        yQUF0dy2ZlpJllmuEZsbm8vZn71IK27mc3F5ToWD00Tq8pzimlcBI2bJXWA8AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613745586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BLyxi+W5jFD0GGWwkGXWpkuC/j7ZiaoxH3rL3WJIYc=;
        b=e5AYgEZRgDvoSRga1VNGUZ1KSlCquwoY1IUKv8FbQmNZpDKNhvmiHnyBkxpCPJtYzfBXS8
        Shozaf27B4hFkWCQ==
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
In-Reply-To: <20210219141237.kksuqsgmmmis7iht@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-2-dwagner@suse.de> <878s7k41ff.fsf@kurt> <20210219141237.kksuqsgmmmis7iht@beryllium.lan>
Date:   Fri, 19 Feb 2021 15:39:45 +0100
Message-ID: <875z2o3yvi.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri Feb 19 2021, Daniel Wagner wrote:
> Hi Kurt,
>
> On Fri, Feb 19, 2021 at 02:44:36PM +0100, Kurt Kanzenbach wrote:
>> It seems like with this particular commit, it's not possible to run
>> cyclictest on arm32 systems anymore. I guess due to missing NUMA
>> support?
>
> Yes, your distro needs to provide libnuma. cyclictest runs fine on arm32
> with the library.

I'm using Debian and it provides libnuma.

>
>> Just tested on a dual core Cyclone V:
>>=20
>> root@tsn:~/rt-tests# ./cyclictest -S -m -p 99 --secaligned
>> FATAL: Couldn't initialize libnuma
>
> I think you would see the same error when trying to use the '-a' option
> without the patch. The dependency is not new.
>
>> I've used the current unstable/devel/latest branch. Any suggestions?
>
> The simplest thing is obviously to get libnuma on your system. I assume
> this is not so simple in your case. In this case you could build
> cyclictest a static binary.
>
> First, build numactl as static libary:
>
>   ./configure --enable-static && make
>
> and then rt-tests with
>
>   CFLAGS=3D"-static -L../numactl/.libs/" make

Static building with the newest numactl library also doesn't work:

|root@tsn:~/rt-tests# file cyclictest=20
|cyclictest: ELF 32-bit LSB executable, ARM, EABI5 version 1 (GNU/Linux), s=
tatically linked, for GNU/Linux 3.2.0, BuildID[sha1]=3D248eaf8847544423dc51=
c6ceea18bbffc487991e, with debug_info, not stripped
|root@tsn:~/rt-tests# ./cyclictest=20
|FATAL: Couldn't initialize libnuma
|root@tsn:~/rt-tests#

Hmm.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmAvzbEACgkQeSpbgcuY
8KbmJA/+KWHRPuvs67MSj6vm0RfKx3YbYj1g5ISQ6dG9msdA+3ho82sIVwPN1qWP
C0IwnOjf4V/l4+MHvshBc4xtuzMtLXgLle0ku8emlGXvZakFpqNPtAYpgQ+pcbUD
bytD54ca/CBcgvWaCgExgq+VtovjfL9Nns32wfKS2ZndORyw+Sp4C9npShEHs7zv
Hj3LDSTr6L/Cx6v4XtIiS2yVtl9dL+6++zbWmRjKmroT8GYi383MJYkyC0Rv59IT
jAoJhnUpGYKLgpuLAkDAtk8q9L6L9d31k2WTKB65FT6mFCwRNGyO2KN7+7lcvp9X
rXlyTw8X0p0iJtpO72S5Fa7BgybxbCOU55Qq5UZOStNOzGUl4CmlHBwbqVXaX+5x
xX486eDS4NiG5cVQURRWJutYJR30gFulFUMJyLHDAgj9iVHnd4JPPXCla31re6E5
qg0x4uXm1tTEGCsdbpmGMXOjxe3p+9Iw33IZLR6xIVxQLvgAE7g108kouXUNlklg
14oeZJTMi4haPpPnxgRl88q4GziWwGn4lCxi25vA2vFD6pz80mZJxPammIIdz75T
chBXRl8llflZdDNYXtdisw2JXK6hV864gx5nLTpmAEUc1pieoMDltyT3GCRbIBr7
pn3SR6Sc4qfHRvfFJajnpa35xcpPVcf9u+aL8ubyXr12XIvvnTY=
=hYMY
-----END PGP SIGNATURE-----
--=-=-=--
