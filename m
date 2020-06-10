Return-Path: <SRS0=psFn=7X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C7C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 05:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4F020801
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Jun 2020 05:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFJF6G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgFJF6F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Jun 2020 01:58:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BC7C05BD1E;
        Tue,  9 Jun 2020 22:58:05 -0700 (PDT)
Received: from p5b06d650.dip0.t-ipconnect.de ([91.6.214.80] helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1jitkQ-0006Mf-Kt; Wed, 10 Jun 2020 07:58:02 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Subject: Re: stress-ng --hrtimers hangs system
In-Reply-To: <CA+h21hp+UsW+Uc-xHyQAMrRVLX9CXZu8B2Svq+9npLtxs0_DWw@mail.gmail.com>
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com> <87wo4lekm5.fsf@kurt> <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com> <CA+h21hp+UsW+Uc-xHyQAMrRVLX9CXZu8B2Svq+9npLtxs0_DWw@mail.gmail.com>
Date:   Wed, 10 Jun 2020 07:57:46 +0200
Message-ID: <87y2ovzcmd.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Vladimir,

On Tue Jun 09 2020, Vladimir Oltean wrote:
> Just out of curiosity, what and how many CPU cores does your ARM64 box
> have, and what frequency are you running them at?
> Mine is a dual-core A72 machine running at 1500 MHz.

That particular machine has a dual core Cortex A53 running at 1GHz.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl7gdloACgkQeSpbgcuY
8KZhoA/+McQHPRNx5dbPNMribYcHMyBoTT6mtyXeKErLeU/FLLA1R6qLxGRPYb/o
3t3lo+zLveJTxAA3ars6I9txVXGmxL/dKlGF2d5GJPDdAkB2zsZY9dzNipqxDM7u
aIvenHzu5G/PRCsOrED9AYc+gIl8MmtGre5ODqHR4gLV/OHU2GBzc95ayBRjkLN/
Rwk0avqNfhVRfLD4YpGxYCYvbi/8AxDhaYxXfA+08DfdTev8TLbnnj7Rd1hhZ1T9
zfVx4iiF6s43IQu3AniZegh3C+ER4RdFWwt9Jhf6pFun3wSPLzElnOnUDB9ydLzm
6Hf5VnAAGSBd7Qi10VPg83dDHOHko1VhnUhcA03o5STr5FU6r/DkOKCwL9iyRHGl
w8+/Ob48Zt6z5jtd+HYPwWfOh2hLkLFlXKU2+KTPw6QvQvxiXHTLmadzadXEGGdE
cF9FkwjqftQGULnWJfq7xCruiPh0P0voo/qFtEZ46aqrssgVwqxCF3n93AikLIDO
lrAnQMRoRnBK7eoOaLmk/akDIgQ0AB6nQf8KU44+kBFApc3xYvSp2COgEIlKykke
ubK8mTAQJwJ8t+JljKpybtRwYeZv2yxN58yC+7Qz4Q5uewi7E7BIINERGs91Swp0
il3tyvjKUFNS3LDNRrcX1FtC0r4AXe3O9ECIZbVIvySR3vpsY5s=
=osnr
-----END PGP SIGNATURE-----
--=-=-=--
