Return-Path: <SRS0=Q1V1=3R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC03C33CB3
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Jan 2020 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B044E2467B
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Jan 2020 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgA1HNR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:13:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1HNR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Jan 2020 02:13:17 -0500
Received: from [5.158.153.52] (helo=kurt)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iwL3i-0007LB-KB; Tue, 28 Jan 2020 08:13:14 +0100
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/9] rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
In-Reply-To: <alpine.LFD.2.21.2001271213260.7301@planxty>
References: <20200123205029.20176-1-jkacur@redhat.com> <20200123205029.20176-3-jkacur@redhat.com> <877e1dxjo4.fsf@kurt> <alpine.LFD.2.21.2001271213260.7301@planxty>
Date:   Tue, 28 Jan 2020 08:13:04 +0100
Message-ID: <87y2tsqcjj.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi John,

On Mon Jan 27 2020, John Kacur wrote:
> On Mon, 27 Jan 2020, Kurt Kanzenbach wrote:
>> I'm just wondering about this. Why are the man pages compressed in the
>> Makefile? Actually most package management systems compress the man
>> pages themselves. Users may want to use bz2 or something else.
>>=20
>> In fact, I have a patch on top of rt-tests v1.6 in Gentoo which removes
>> the compression, because portage complains about it.
>>=20
>> Thanks,
>> Kurt
>>=20
>
> I think it's because man pages are generally installed as .gz files on=20
> most distros. Although the Makefile is designed to work well with package=
=20
> management systems, it should also work correctly stand alone.
>
> If you want to submit a patch that would optionally use a different kind=
=20
> of compression or otherwise handle things without breaking the current=20
> defaults, I would likely accept it.

Sounds good. I'll come up with a patch and keeping the existing defaults.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl4v3wAACgkQeSpbgcuY
8KZJmw//WN+aEB6gUUiQGcYHKvSm5NiVuzHKRzxcKGveH7spqyUeoURQWFWtMtQC
Ni6XAAHtjySn7VamlpaeHFHgWUlI5bv1tsIq7a01Ud1vqfForzGc/V4hiHgx5UTx
NW8kmwcDgswoAAacnc/2lATSxUpuZZpWdMVCF7Hv36/bW1Dv8wBCthbuDVuqZC0a
nkaqVBjvWiWTNNB6i9KjJLIH/RKhlVRhWW9J1Km4kcMF9QOX4cZRZ7ATQKbRmT1v
g8noqyjQryauyYjRNf8MjoON1YqouZoJ8ZZ8QNMsJxj1PnFe7egBhtdgYzyDIVxb
sk/IWsbPmOXn9DUBT8U/ZXaSKvzl1+nVrrNQVZ1c+IObzKXBk7VMLY20WtHA5hPW
ILsfOiZH2T6LsE1VHh1J4PDuLpRZUsGEmWw78pTQbNBcR353fWh/6kOz5VbAhSXs
8RJ4zW6KJfkVwTt8cdkKsFILTcAsYvkTEEnbR0z600oHj0hgqBxFwKD7vrrUxofw
JGAuOxbjE0ogZU/obV8ax4lt6opjf63rLDWkbcT63c4XiHdUrnLYx7uPArb54jbA
pm5OEBDDz0mFb2C1W9sIRIzMhqzGltqPpe3e5MedHJPpuKKgkwuSsqArYRU2dAzT
fzfy4UOj+Y+NASxhimOXXjV/otImPFR6hW6O2oIHAgaMgetCsyE=
=ISks
-----END PGP SIGNATURE-----
--=-=-=--
