From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 5/7] RT: Add support for low-priority wake-up to
	push_rt feature
Date: Sat, 13 Oct 2007 11:46:18 +0200
Message-ID: <1192268778.27435.46.camel@twins>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
	 <20071013001559.7444.4125.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4VwZ6l1GB6tyvBFlZrSq"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:20169 "EHLO
	viefep33-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751022AbXJMJqW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Oct 2007 05:46:22 -0400
In-Reply-To: <20071013001559.7444.4125.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-4VwZ6l1GB6tyvBFlZrSq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-10-12 at 20:15 -0400, Gregory Haskins wrote:

> +/* Push all tasks that we can to other CPUs */
> +static void push_rt_tasks(struct rq *this_rq)
> +{
> +	while (push_rt_task(this_rq));
> +}

I'd like to see an additional termination condition to this loop (might
just be paranoia though).


--=-4VwZ6l1GB6tyvBFlZrSq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEJPqXA2jU0ANEf4RAj2sAJ9AntN2u/dQBMve5zSxj1hwiFYSEwCggsQ3
2Y8duIYjzPXL4VLgNZr+waU=
=RJZF
-----END PGP SIGNATURE-----

--=-4VwZ6l1GB6tyvBFlZrSq--
