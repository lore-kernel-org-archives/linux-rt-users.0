From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH] [RT] avoid preemption in memory controller code
Date: Mon, 08 Dec 2008 18:07:36 +0100
Message-ID: <1228756056.7862.8.camel@thinkpad>
References: <1228746854-23875-1-git-send-email-tim@klingt.org>
	 <alpine.DEB.1.10.0812081138470.26257@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MUR0zWqfO8LZinAN8o6L"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:48320 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbYLHRH6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Dec 2008 12:07:58 -0500
In-Reply-To: <alpine.DEB.1.10.0812081138470.26257@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-MUR0zWqfO8LZinAN8o6L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > the lru_lock of struct mem_group_per_zone is used to avoid preemption
> > during the __mem_cgroup_stat_add_safe function.
> > therefore, a raw_spinlock_t should be used.
>=20
> What is the reason that this must avoid preemption?=20

it guards a call to smp_processor_id() in __mem_cgroup_stat_add_safe().
see http://article.gmane.org/gmane.linux.rt.user/3690

> Is there another
> way to solve this? I rather not just add a raw spinlock if we can
> help it.

not sure, maybe one can disable preemption for that specific function?

tim

--
tim@klingt.org
http://tim.klingt.org

Art is either a complaint or do something else
  John Cage quoting Jasper Johns

--=-MUR0zWqfO8LZinAN8o6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk9VFMACgkQFz+XezW6HD4eqQCgxBvOMt6an7l+8z5D9oBB8jta
F/0Anj3ab0Y4xJzIbR/GwbYPgczkty9T
=6g9o
-----END PGP SIGNATURE-----

--=-MUR0zWqfO8LZinAN8o6L--

