From: Julia Cartwright <julia@ni.com>
Subject: Re: how fast can you run a hrtimer?
Date: Fri, 18 Aug 2017 09:52:32 -0500
Message-ID: <20170818145232.GJ8384@jcartwri.amer.corp.natinst.com>
References: <CAOd_LFwErYmZS-5b=a1O8DkqpAZqhgGXwnLhHHWZ8NnheK72Xw@mail.gmail.com>
 <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Cc: rt-users <linux-rt-users@vger.kernel.org>,
        Cliff Brake <cbrake@bec-systems.com>
To: Cliff Brake <cliff.brake@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52213 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751106AbdHROwf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2017 10:52:35 -0400
Content-Disposition: inline
In-Reply-To: <CAOd_LFx5Bn6HtnzD59Hn6feY=ZS3Re+GXHcRU2x2J54cuJDagw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 10:34:19AM -0400, Cliff Brake wrote:
> After a suggestion of using a NMI and a bit of research, it seems
> something like the following article is the probably a reasonable
> approach:
>=20
> http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/

The use of a FIQ probably gives you the best chance to achieve the
latencies you want; but keep in mind that the use of FIQ means you'll
need to get your hands pretty dirty.

The set of operations legal to perform from NMI context is very, very
small.  The usage of gpiolib (and therefore any existing i.MX gpio
driver) is probably not going to work from NMI context, so you'll have
to roll your own solution.

   Julia

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAlmW/y0ACgkQjNrC4UVN
dG9d+wgAm4mT1LCBIBP2SIXQ5vFzrOH17pgSTgdf8K+s8A/p90BmjDZ/vRfj8KWO
9LwTtgMMOqfEtxktTkRLd05XSqmeX2Dmo2ocorB1QWdKXGx4hkVHxhtwljI3TtJZ
7Z7LoAxSugLAlFzRqn14a/TfdEVrfWSKkfR0UYumHCtGQGEMhc0yPGx2AFqrzfVy
Ffu9VZ8Eqz9bo3iA7zCyekoqK5G+s9IV22L/kkcEm+KS4L16X7Jqezmqr6kqjSOE
7KQwCPbY/xtCfyc/LOqg1pluR0IUcS7tyvPJB85f9Y+z8v6FhfMGdbAjADYqEAq6
3kh+OP2qqQQRq+kpHt2U/sfvpjYjWQ==
=79bZ
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
