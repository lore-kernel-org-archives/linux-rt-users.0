Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39719 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBZKez (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Feb 2018 05:34:55 -0500
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is
 occupied!
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
Date: Mon, 26 Feb 2018 11:34:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180226094604.7biqg57c4xq2ugao@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gAjaqkuZJICy3DithSateO1cCqwFKAkqe"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: Diana Burgess <diana@peloton-tech.com>, Philipp Schrader <philipp@peloton-tech.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gAjaqkuZJICy3DithSateO1cCqwFKAkqe
Content-Type: multipart/mixed; boundary="yA1jc02ZGgY4xZlIREURCIPHAODSRsxXd";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: Diana Burgess <diana@peloton-tech.com>,
 Philipp Schrader <philipp@peloton-tech.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Message-ID: <7e7f456f-17b9-ae40-5586-fa676db0d202@pengutronix.de>
Subject: Re: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is
 occupied!
References: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
 <AM5PR03MB296341BA74D9A542E92E34E9D6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180226094604.7biqg57c4xq2ugao@linutronix.de>
In-Reply-To: <20180226094604.7biqg57c4xq2ugao@linutronix.de>

--yA1jc02ZGgY4xZlIREURCIPHAODSRsxXd
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/26/2018 10:46 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-23 08:46:36 [+0000], St=C3=A9phane Grosjean wrote:
>> We've pushed a patch to fix a potential issue around the handling of t=
he echo frames. It has been included in 4.15. Are you able to build and r=
un this version of the Kernel?
>=20
> top posting and long lines.
> Could you please quote the patches which you assume should fix this
> behaviour and whether or not they are tagged stable?

91785de6f94b can: peak/pcie_fd: fix potential bug in restarting tx queue

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yA1jc02ZGgY4xZlIREURCIPHAODSRsxXd--

--gAjaqkuZJICy3DithSateO1cCqwFKAkqe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqT4sQACgkQk9IU1zQo
ZfHQuwgAgGXEKDSaRUE/8p5k3Zilma3K8kMY4xaQTCWdDiTJKbHcIIk2BFWyA1Go
ROQS7TAIfuMktWHRQi370H0q4Dl26kbW+u7D8UVVdHb/9oTrZmc23JNqwnSMgc3C
OuSOqgW3ATGbL7dkcmpSbB/IdFDZRmTxeP0o81ZNdiWI+fyhGRrjQ/DZrmemRswL
Rfl3nIELo13ePdb6nIKRNXNpT/ghO1MR7FQ9QGN3Q13yWieIUb63cludNd+48UkE
x6ZrA83nV5xCpJ3PUVBspE3oUObkzjcZvI3n8Oht8BKdHtNGMk/84oYzMRA1KUY2
1irlcd6qN/vDf/NiMVP9MXqv4Hhckw==
=ciLM
-----END PGP SIGNATURE-----

--gAjaqkuZJICy3DithSateO1cCqwFKAkqe--
