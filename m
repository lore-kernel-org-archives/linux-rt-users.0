Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF33C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Nov 2022 17:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiKORHY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKORHQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Nov 2022 12:07:16 -0500
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 09:07:15 PST
Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF0D8E
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Nov 2022 09:07:15 -0800 (PST)
Date:   Tue, 15 Nov 2022 18:07:09 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: v6.0.3-rt12 does not compile (WAS: [ANNOUNCE] v6.1-rc2-rt1)
Message-ID: <Y3PHQM0QXTTrKcXg@hmbx>
References: <Y1lPqHjmytaSEnHn@linutronix.de>
 <Y1m0MXDKt0yqXdsu@hmbx>
 <Y1osx2Iw0qs3gWxu@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X8utlgxc0ZdWqayl"
Content-Disposition: inline
In-Reply-To: <Y1osx2Iw0qs3gWxu@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--X8utlgxc0ZdWqayl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Nov 2022 18:07:09 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: v6.0.3-rt12 does not compile (WAS: [ANNOUNCE] v6.1-rc2-rt1)

On 2022-10-27 09:01:27 (+0200), Sebastian Andrzej Siewior wrote:
> Please keep the list in Cc:

Thanks, will keep that in mind for the future!

> I'm going to release -rt13 in a bit with this fixed.
> There are few options like SLAB or TRANSPARENT_HUGEPAGE which are not
> available on PREEMPT_RT for one reason or another. I try to avoid
> dropping options if possible.

Seems I forgot to reply...
Thanks for releasing a new version so fast and being on top of these
changes!

For reference: Will there be more rebases on stable versions of the most
recent kernel versions going forward?
The linux-stable-rt repository seems to only cover LTS kernels AFAIKT
and a few more releases in the current stable kernel version range would
allow downstreams to more easily backport patches (e.g. for security
issues) also for the realtime kernel.

Best,
David

--=20
https://sleepmap.de

--X8utlgxc0ZdWqayl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQXk9rV2AOo/9dFFpe7mS+YZPrRaAUCY3PHPQAKCRC7mS+YZPrR
aD3oAPwODV/R9d6YOlcMI+21JUbJX60WSIrkn6rjvwLcbqys8QEAgw+etSthojdQ
w30z9UVAIAN+tD3kUHuNI9OORipbJQs=
=PM3p
-----END PGP SIGNATURE-----

--X8utlgxc0ZdWqayl--
