From: Clark Williams <williams@redhat.com>
Subject: ANNOUNCE: rt-tests version 0.91
Date: Tue, 17 Feb 2015 14:57:34 -0600
Message-ID: <20150217145734.2897d2ff@sluggy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/7lCctKvqOMVN8D1bYQXHENe"; protocol="application/pgp-signature"
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbBQU5v (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 15:57:51 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1HKvo2g005771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 15:57:50 -0500
Received: from sluggy (dhcp-10-15-1-15.hsv.redhat.com [10.15.1.15])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1HKvo5B003487
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 15:57:50 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/7lCctKvqOMVN8D1bYQXHENe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm pleased to announce the v0.91 release of rt-tests

The changes from v0.90 are command line option fixups
in rt-migrate-test and an output format fix in pi_stress.

Repo: git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
Branch: master
Tag: v0.91
Tarfile: https://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-tests-=
0.91.tar.xz

Uwe Kleine-K=C3=B6nig (1):
  pi_stress: remove timestamp of compilation from version output

Boris Egorov (2):
  rt-migrate-test: use variables instead of macros=20
  rt-migrate-test: exit early if nr_runs is non-positive

Clark Williams (2):=20
  rt-migrate-test: sanity check --prio value
  rt-migrate-test: make sure input parameters are converted
                   to correct units=20

Enjoy! Comments, patches, suggestions and snide remarks welcome.

Clark

--Sig_/7lCctKvqOMVN8D1bYQXHENe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU46tNAAoJEEersVlSw9Nz7bEP+wauP9jM/mvfH72RyAZI0e1G
YqcGEw4Vl+YPPNvmqAfXAWqOkC4XeXbykXB/aM6yrR/IN1kdu4EzeaqOPqg6w6N/
Lu/v7K0i3aORcLTTodFHc0JC1HdJCVcNEHlKa9m90nrtf2D3C35qU7shJoHPZmR5
KAtW6F3remBM8e1fhEIo2E1NJ411/D3iYMy6TbgA39AT2QMcouRB4KCcKZ3sf3Yp
HS9kIB8+vwWaZjfU90STBY7myGUpxCb3l+zQyw2lDFVbB9TVnXnv3WZSa25uUxSf
IceJDoTx4jmB5jm0OecaBZmjEQA2T5X/ANWuiGow+8KK63TebvGqqqoFajjiIv++
mOGJuPlDM6EpZacs4XZP6lizcELYieEJotfBDNkPBL2GBmrYwOkGARwaf6tWHqyd
Z8FdChHXCeulasfPn0DinpP1k6k9riO4Rrr1OORLjEvgYCRNpTesoHcF4VG8Sr69
VG/fJXoQLsWS2deGgtsXNaTXdmWwSQcE4Zq85R9bLOqBMqvSaoRqAMWuJpmTfi0q
A1rXXDDJS4ykhXRFva3bbvIZ3DXrnpa0+CCtjZX6Jf7I+i5DLMdDeZJzANMHuHuQ
wsKwqMMrg3LtpXC52wzmvxUW/KNv/JYfrb5FfwLQ85Vb6/sQjNlTPKUtPZ5/AQRH
ggROJ6B5ra98/RSlVgFK
=tPBt
-----END PGP SIGNATURE-----

--Sig_/7lCctKvqOMVN8D1bYQXHENe--
