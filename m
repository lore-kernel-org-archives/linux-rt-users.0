Return-Path: <SRS0=sCGC=UU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F36C43613
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 07:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36420679
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Jun 2019 07:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFUHHf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:07:35 -0400
Received: from sleepmap.de ([85.10.206.218]:39080 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfFUHHf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jun 2019 03:07:35 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 03:07:34 EDT
Date:   Fri, 21 Jun 2019 08:58:07 +0200
From:   David Runge <dave@sleepmap.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] New release rt-tests-1.4
Message-ID: <20190621065807.GJ20165@dvzrv.localdomain>
References: <alpine.LFD.2.21.1906201444220.6702@planxty>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906201444220.6702@planxty>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On 2019-06-20 15:26:30 (+0200), John Kacur wrote:
> We haven't had a release in a while as people were content to work
> from git. However, in order to make it easier to use, test, and put
> into distributions, now would be a good time for an official release.
Good news! :)

It seems the tag is not available yet (according to `git tag -l`).
Could you add it? I would like to package it.

Thanks a lot!

Best,
David

--=20
https://sleepmap.de

--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAl0Mf/wACgkQVMKPT/Wh
qUlDIg/5ARSX9jdzCETjF6bDe+ZL5ACtr4ObfiTat9P8ZAUjKreJu5o3ORaIMJDx
CsZJv1LLpz7liyeO6JjSo3jF+FbEa+u+M4m2SLglmeucV9POB+aHTbsxnNIQ6qVa
L7ytZJCC1mvAorWGNJI1nYmoyUJcLZ2xxt8p+5QTp4kZxXghiDqtBw3BUu0rNTWh
b6OeSv6AtC6TXro6Bei5DLElZN0oNJCrx3sHkv6rALKgr7XdBHbJm4G1KVxe4jjG
J2y1ogVH0OqOqBOEIx26nBxeyBjQH2nfYuUXfh+CfbeYZIENg2H0BpQOhdJrHSzW
jQEgj6q6y7RzkjTxUJC5Xt3e4nuzKHURK+6fLDmMc9YTUAQjo3J5Jy44ECFe814c
kdXeB1t3uq34S+V0erD5/N/a2jbvv0Q+EJFuf4uYcV4PzCgG7voXcCkOu78H/jfk
mDH2vEHWfCRVRVSO6y4H4m+bbZLMeWFHPRoy4VnG9REZdoIpoGM6QtWDHDKlN/qr
oPEW604OEaUaCTq+EoBcm2xBjPbmZTTWjNGiNzZDVy9rwSrxFnzXAIvYVvJvzPrP
cph0hgSBT+eNCUJGJSQ6hjGdSA01FR0ZywoAQUhLi504v2ED7z7DVi8FH5p2ZJhy
cH7+4oydAmWabL6Bodsfoa1GlSGTaS29p1gGzczCbG/jyW7MhmQ=
=cKmD
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--
