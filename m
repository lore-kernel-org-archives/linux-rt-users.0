Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A444FC4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 11:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1F0206DF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDDLFy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:05:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLFx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 07:05:53 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1hC0Br-000059-04; Thu, 04 Apr 2019 13:05:51 +0200
Date:   Thu, 4 Apr 2019 13:05:50 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: cyclicdeadline: fix segmentation fault on close
Message-ID: <20190404110550.wnwtssv4mh7shfij@linutronix.de>
References: <20190404094948.3516-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7rntnwkxjdb4da6h"
Content-Disposition: inline
In-Reply-To: <20190404094948.3516-1-kurt@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--7rntnwkxjdb4da6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 04, 2019 at 11:49:48AM +0200, Kurt Kanzenbach wrote:
> The setcpu_buf is unconditionally freed at the end of the program. However,
> there are code paths in which it is not allocated:
>
>   $ sudo ./cyclicdeadline
>   Using all CPUS
>   /sys/kernel/debug/sched_features: Success
>   interval: 600:1000
>     Tested at 5us of 600us
>   deadline thread 2963
>   thread[2963] runtime=600us deadline=1000us
>   main thread 2962
>   fail 2 0
>   T: 0 ( 2963) I:1000 C:   1268 Min:      7 Act:   55 Avg:   56 Max:     256
>   [1]    2961 segmentation fault  sudo ./cyclicdeadline
>
> Fix it by adding the NULL check.

free(3) is actually NULL safe. So, that's not the problem. We're
debugging it.

Thanks,
Kurt

--7rntnwkxjdb4da6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAlyl5Q4ACgkQeSpbgcuY
8KZltRAA10OWiQxBIX2ZwS6fG9iNR0NfoLHbDvLtVSHft33nINfCO/b5ZU8RKvOW
UXPlZfUvunZudP33NtUjp31+7gXN/XvLvdumR22EDqQfPtiX8JOyCIxig00qYF0Q
88t8bHDrPS7ntRmjWIiyh+T6ImhChnz34O2HOWXjkLy4fvi04J6nkTr9OxcezS48
Yxdp50wycrvH1MSMF7HCAxITW0zOqCJGz/3NSbxuhgXB/IKjQvdrJW9tsq0gEWYE
1zTmVuJYnfvGSZ92j2Y9mAhUN2lOQVGzLZhZqiDsyHDgQRdj0s4YsE8aXWkS6FN3
irQdOmRFt5IrrMsiXZTTLXZ2fEC+8MTX+IwNSNNjfo/HrKRrohNVErCOeOUv3mgc
8quv2PeB9IXmTFhp0Ir6DKcjpkGvqomrVuuH/9v/kDGBXeTp6nMGAmM9jJVlw8PD
JTmhkiDr7Kk+D26AWt8J86wYRzzxwdeWNIAdlAPtekj5Uxlg8SfvVxOT/YSJ4ukR
dvGrUjG+820oMvbFWhCBwjE0fTPOGm59kJziePkzVMJl+uTqbNlL2vBz71h7tZqN
ELYar63AejZVfUGgFl4ifatSzLz0wqpj2YlCHaX/w+hhmXBAx4svbVJJIBawi+rU
GTNBWQXg37kVEXSFpNqX9hRFTA87gHxl8I+jK3bODuV5lpJfKOQ=
=R0MQ
-----END PGP SIGNATURE-----

--7rntnwkxjdb4da6h--
