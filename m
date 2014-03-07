From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FlexCAN on i.MX28 interrupt flooding retrying send
Date: Fri, 07 Mar 2014 14:54:47 +0100
Message-ID: <5319CFA7.7040402@pengutronix.de>
References: <53197E8A.5050409@meduna.org> <53198753.8000900@pengutronix.de> <5319CB58.4070708@meduna.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IHBpVPKpNi4vbRlWxnkJmRuUiCtuWTdqI"
To: Stanislav Meduna <stano@meduna.org>, wg@grandegger.com,
	linux-can@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <5319CB58.4070708@meduna.org>
Sender: linux-can-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHBpVPKpNi4vbRlWxnkJmRuUiCtuWTdqI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 02:36 PM, Stanislav Meduna wrote:
>> Adding the linux-can mailinglist to Cc.
>=20
> I am not subscribed so maybe that's why the original mail
> did not get through - I did Cc: linux-can@vger.kernel.org

My bad, linux-can was on Cc, but it arrived on linux-can late.

>> Your kernel is missing the patch:
>>
>> e358784 can: flexcan: fix mx28 detection by rearanging OF match table
>>
>> With this patch the CAN core properly detected as an mx28, so that bus=

>> errors stay disabled (unless you enable them). If you need bus errors =
to
>> detect not connected CAN busses, you need another patchset berr_limit,=

>> which is not yet mainline. I can repost it here, if you need it.
>=20
> Ah ok.
>=20
> Thank you, this probably points me to the right direction - I'll try
> to implement this behaviour in my kernel (unfortunately
> I cannot move to more recent one at the moment).

The flexcan driver in you kernel doesn't have the improvements for mx28,
i.e. that the bus error is not needed on that CAN core. I think for non
DT we never added that support.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IHBpVPKpNi4vbRlWxnkJmRuUiCtuWTdqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMZz6cACgkQjTAFq1RaXHMYjgCdGlf3gH577VT96aw0cPFBefd8
65sAmwZ6AdIK9bhiIVb4UEnuCnD9WAXK
=Kgy0
-----END PGP SIGNATURE-----

--IHBpVPKpNi4vbRlWxnkJmRuUiCtuWTdqI--
