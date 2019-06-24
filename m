Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45866C43613
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EA7208E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfFXOgu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:36:50 -0400
Received: from sleepmap.de ([85.10.206.218]:43998 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfFXOgt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 10:36:49 -0400
Date:   Mon, 24 Jun 2019 16:36:46 +0200
From:   David Runge <dave@sleepmap.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] New release rt-tests-1.4
Message-ID: <20190624143646.GX20165@dvzrv.localdomain>
References: <alpine.LFD.2.21.1906201444220.6702@planxty>
 <20190621065807.GJ20165@dvzrv.localdomain>
 <alpine.LFD.2.21.1906211407410.3661@planxty>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j13PAD5Nz8dz2ik7"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1906211407410.3661@planxty>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--j13PAD5Nz8dz2ik7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-21 14:08:01 (+0200), John Kacur wrote:
> I just pushed the tags, let me know if you can see them now.
Whoops, forgot to answer!

Yes, already pushed the new package. Thank you! :)

Best,
David

--=20
https://sleepmap.de

--j13PAD5Nz8dz2ik7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAl0Q3/4ACgkQVMKPT/Wh
qUlR4xAAlrPVvdheEv5HRnV2BsVSdbAmSpdSN+lMadsgYQFSkoquFlIeKiFDDPry
c00G1+F47mPpf4SzhI9zwN98ibsHBzNnLQ/Aj4MmGhwjzQ/t6Q3jMLDFlYLOKJjD
YvuYJy5xHcQNNPBmtuCsiUiC5ZUUueMHDKERi6jUK7C0Ji0faitiomRuPPkppZUI
4AMPESl48AGQYZ3bexxSgaxsM+YmO9s38Vv++cU2TT+qTuXsXd3B8ShTG6tiY7Nj
/W6YEs4lwYpEYXy6lEleLat913fTn8qcD+AqPpnLpfTB1RBxTzM7m+nK2MhX5sCs
iMb66xuWdiAtwgFl6L5AkpB4z008fdpWS+WAkp1d7aiVROwxt2Pi/MvyXQY11g/m
k/qJvxHwluIt5duIda0iP4eGiodbgaLYJ9m3zjHrCvqufJ/eiRp+tgzH/VpIpdV6
JYDmv+ThZnTrE2lVinOQwoZjsU8jcKDTTWn031Ks//70czlgq7FkJOzoHt3GG2RC
2PwzbHp5iSbjIwXCQdpOTOXhjKuqSv3HtNCf5mUE/js3+ge8a1EWWl89RRVUguRh
LalwdHr2UQhrr2oIu6L2ln2m0P0Jr3LbDBa0voy6JbA7lGPTdgEWomQ7ibJXsTYB
KYiHV31VoMK3tRk1pwjQ6y7J1Oz4A7jdjgD0UmSn0mwrIkOuido=
=MXJN
-----END PGP SIGNATURE-----

--j13PAD5Nz8dz2ik7--
