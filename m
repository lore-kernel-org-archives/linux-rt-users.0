Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DD1C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F792206A2
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFEM5O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFEM5O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 08:57:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD4C08C5C2;
        Fri,  5 Jun 2020 05:57:14 -0700 (PDT)
Received: from p5de0bbdb.dip0.t-ipconnect.de ([93.224.187.219] helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1jhBuK-00045S-4y; Fri, 05 Jun 2020 14:57:12 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>,
        linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Cc:     Colin King <colin.king@canonical.com>
Subject: Re: stress-ng --hrtimers hangs system
In-Reply-To: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
Date:   Fri, 05 Jun 2020 14:57:06 +0200
Message-ID: <87wo4lekm5.fsf@kurt>
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

On Fri Jun 05 2020, Vladimir Oltean wrote:
> Hi,
>
> I was testing stress-ng on an ARM64 box and I found that it can be killed instantaneously with a --hrtimers 1 test:
> https://github.com/ColinIanKing/stress-ng/blob/master/stress-hrtimers.c
> The console shell locks up immediately after starting the process, and I get this rcu_preempt splat after 21 seconds,
> letting me know that the grace-periods kernel thread could not run:

interesting. Just tested this on an ARM64 box with v5.6-rt and the
stress-ng hrtimer test works fine. No lockups, cyclictest results are
looking good. So maybe this is v5.7 related.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl7aQSIACgkQeSpbgcuY
8Ka5ew/8CnsvF7WGKuRMYATizAnmuFg6USpgofkEyTTccZ290PViHF/mjlnWm67v
pxDPiE45zhf/oBa1vHbRYJC7GzxTfP6XxbF5Ntx9ZiyV8mhg0qMDCRReAqW0yZFc
G13ERVDgIawP9QdFrci/q/BQA+QbVF8FrJQoecIBOSze73SI/uO2RLm2cnfzV+NL
6b3zyGeu7+y81DnlmckwMxpkUsgqah2eSEMFX07kA4c6cxp/wwmaid9BXQoWtw9k
ZX1vTKY1cGyE1c4L/ndIISyxf+kk8eT+L2bZzADZWzAjGQfTMltA+/bl0G+M5A7u
ZL/UoYWf2dW6KaHLVGrJEF72Wtuqq1zqQMJW0bKF27qYOZbQiZWuRwseeQCAlqar
KjkGUqr0OpXPICujE7fnoS7yyIjcx05DOYCmUwagiFV+rdQTm3qfvTZbvh+FwJ4e
mvli52MmuR7e7cV5m2d6nUBt5IuSy6qS80arDcs3ofzz9shIr3Ko+2a8WUuEepZW
Eroa1Jho9VSwGlrjXjyM5hUJYqDqcuP39bHYi90+SalM8WWa/FH9e9VxHO4gilLT
yZtnFGWg08VCh9BU5RCu78hWqTzhCbJK+FMHUNigzWE/vwjtTh5/S/ZuaJPgMJxS
lARC4gAd3jClS3vQLRmamp5bmhm6QEKeyVsDPEvbr94GXnkX3og=
=5WAo
-----END PGP SIGNATURE-----
--=-=-=--
