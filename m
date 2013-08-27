From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Tue, 27 Aug 2013 11:50:11 +0200
Message-ID: <521C7653.9080402@autostatic.com>
References: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFB896D13E5FC18F3163EB6CC"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:49564 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab3H0JuO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 05:50:14 -0400
Received: by mail-we0-f178.google.com with SMTP id u54so3626477wes.23
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Aug 2013 02:50:13 -0700 (PDT)
In-Reply-To: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB896D13E5FC18F3163EB6CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/26/2013 02:28 PM, Wolfgang Wallner wrote:
> I know that in 2.6.33 there were splitted softirqs, and that it was pos=
sible to configure each thread with its own priority.
> What are the steps that need to be done in 3.x to achieve similar resul=
ts as in 2.6.33?

Isn't it still possible to configure each thread with its own priority?
Afaik IRQs still get assigned a bottom-half. I'm using rtirq myself to
prioritize softirqs.

Jeremy


--------------enigFB896D13E5FC18F3163EB6CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJSHHZTAAoJEF63J34m6LiU1SQP/1sgYmSeijur9ftYC+/GrRhP
SAl3jtuD3qctqyEl1lFDVeThhTCNFiNywbF9LcYM4sY2p8yu7WH2Fq3xTU+9o9bJ
g4jmw3iSRv6jNPG9WjrPLH3Out5WCpHHXCUDg0FX6DNHb02wLA2Xr6IO+TzDvUkz
J6ZyZgaZDvPwTTx6Zm/15N0Hpz1IfR89BNB5lTxsz91/5CAAW1KO1B/xsEgdF6LN
TDER7GO6mxrvW9DWbRqbERN74VbKACYObPvbYcJJnLlVi149l+ceM+XrKW2PceD4
j3Vt8WeCw3U4RvMU2JFMjOdlJpPt5RdOwtSqBOljKMGlkmDdwMt7k8S78j/wJFjQ
bt7lJ8ZPS/DviACMhHArMs/iwKU110GViAjq2CRKZg4kwbLDKbuJfUtrV90aLmhA
EJmW5KcoaBy6I98FGpd3+jHtXj/wkJxOTynsoKmVu4DXivEmuesAWheywDGupaBy
9rJYEq//l43xh6gd+pARmQXVs8IH/YOoWMJ77xXWWvbRnDUwPGd0W3CH3lXOzAe6
SS24T72aUrszIC8fpfqZdKOFZBnOeII+KXv6VISgysdA/iNrwV1NKS63wYRY4AP5
vGZ335fFqKtAoXc2UA2j0kpL2Fo+6YQvwpKi/4vtrwgm5L7U1PBUvbK/D1tPVm/C
nLNCD60JRaQDuvAPaenY
=9DWm
-----END PGP SIGNATURE-----

--------------enigFB896D13E5FC18F3163EB6CC--
