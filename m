From: Josh Cartwright <joshc@ni.com>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Mon, 21 Mar 2016 09:40:16 -0500
Message-ID: <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:42197 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755911AbcCUOk0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Mar 2016 10:40:26 -0400
In-Reply-To: <alpine.DEB.2.11.1603190933150.3978@nanos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 19, 2016 at 09:33:34AM +0100, Thomas Gleixner wrote:
> On Mon, 14 Mar 2016, Luis Claudio R. Goncalves wrote:
>=20
> > Hello,
> >=20
> > I just started using 4.4.4-rt11 this afternoon and saw the lockdep spla=
t below.
> > Is this something new or did I miss a patch floating on the list?
>=20
> That's new. Looking into it.

It looks like the way that INIT_HLIST_BL_HEAD() is authored, all
instances of the contained raw spinlock will share the same lockdep
class.  That, coupled with the following in mb_cache_shrink(), is
triggering the lockdep violation:

	void
	mb_cache_shrink(struct block_device *bdev)
	{
		[..]
				/*
				 * Prevent any find or get operation on the entry.
				 */
				hlist_bl_lock(ce->e_block_hash_p);
				hlist_bl_lock(ce->e_index_hash_p);

  Josh

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 44f0b55..d13428a 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -42,13 +42,18 @@ struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
=20
-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
-{
-	h->first =3D NULL;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	raw_spin_lock_init(&h->lock);
+#define INIT_HLIST_BL_HEAD(h)		\
+do {					\
+	(h)->first =3D NULL;		\
+	raw_spin_lock_init(&(h)->lock);	\
+} while (0)
+#else
+#define INIT_HLIST_BL_HEAD(h)		\
+do {					\
+	(h)->first =3D NULL;		\
+} while (0)
 #endif
-}
=20
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW8AfNAAoJEKp7ZBKwQFArsX4IAJ1XmjdFR5wcX7STToolPzo0
0MSoEZleiixRgnMfXHPqDFFbae9M1frbwB+qysQsCi8KiEmN4i+KfZcDt3pTrLm2
jE8XW2HuaSKvmVUGPyCzg5lCQGdMqKOShABnBGiens+AsiSOd8u1X+u3rZPlCoa7
+4QEgomazwzTjk7grPBbSu/foSwOqMv+beSzoQqN5HujQRrqc0dQJaYZbJ9EN/sj
f83XeJS2xY56khUXsD7hrkSLtIIexMQUsu+lHc0n2Ju+8q/KQVI365qJXPASi+nd
qgckhav+47cYchfHmPpbrLFXJ3WNT6EcA5iSWokQwyUcvFug/b937sha1t0vTpc=
=ZDFR
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
