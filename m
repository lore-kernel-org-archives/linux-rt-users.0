Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922A23D29D
	for <linux-rt-users@vger.kernel.org>; Tue,  8 Jul 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005191; cv=none; b=MLWmsSw/TSOewI7Jup5JnTF6eq4wL4mLuLXigB4ZyCZelMfbeUNI5rdzpcJDq0KGL+KwRa3Z8LIcIakP5hbv3GqDTMDaLgNyhnBD8hSbD5mzkesHM9Iomti5Z8zmgilzpjDzBF/EfMiUzMLv5bj93Zx0k8P6gVrheWhlUT0CHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005191; c=relaxed/simple;
	bh=a5Ay6bag9bGf3/MKZttddvj3+1SFlJ8JwlvUDA8tQM4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=B9YUC0sfYXMIrPyLLz0rPmbgQnwikYl+f5gKfu7Q9sGy5Lp2WuZqyJ1POviYldK3IKPjdAxUYw3DLE2D4rgEi93qWFV93L9flS7l01s/xXrdKCzHTL3hKVLlE2sW6fiB5lNc5PUhD3C97LPrVUBw9r+S0p5evf+jDGf1Rg+JM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [89.234.162.240] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZE6A-004fFE-2a;
	Tue, 08 Jul 2025 19:35:26 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZE69-0000000934K-328S;
	Tue, 08 Jul 2025 21:35:25 +0200
Message-ID: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
Subject: PREEMPT_RT vs i915
From: Ben Hutchings <ben@decadent.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>
Date: Tue, 08 Jul 2025 21:35:21 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-aHXCAGlIedGtjg2WiVst"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 89.234.162.240
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-aHXCAGlIedGtjg2WiVst
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Debian currently provides non-default kernel packages with the
PREEMPT_RT patchset applied and enabled.  However, for the Debian 14
"forky" release the plan is to use only the upstream RT support.

One result of this is that the i915 driver will not be included in our
RT kernel package on amd64 because the upstream version lacks the
patches to make it compatible with PREEMPT_RT.  This was not a surprise
to us, but may disappoint some of our users (for example see
<https://bugs.debian.org/1108324>).

I see that Sebastian submitted the i915 fixes upstream in October 2024.
If I understand the explanation in
<https://lore.kernel.org/intel-gfx/Zv-n2h0gsquKOvXu@intel.com/> rightly,
much of these changes are unsafe because i915 has its own hard timing
requirement for reprogramming multiple display controller registers
within a single frame.  Is that still the sticking point?

It seems like the critical uncore lock is currently held in a lot of
places and potentially for a long time.  Would it be practical to split
this lock into:

1. raw spinlock protecting only state needed for the atomic (within-one-
frame) update
2. regular spinlock protecting everything in uncore

or is almost all the uncore state potentially used during an atomic
update?

Would it help to offload the atomic updates to a kthread that runs with
RT priority but still with hard interrupts enabled?

Would it make things easier if setting CONFIG_PREEMPT_RT=3Dy limited i915
to not run on some older hardware?

Ben.

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken

--=-aHXCAGlIedGtjg2WiVst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhtcvkACgkQ57/I7JWG
EQnhMxAAm3p4Mf9jNXbIN0mu2OooFE5xYUjVuzj887FjqEydecdn3YXVdZnpkIVH
jALbfFQLiGomejWH15jyQHig1c4/mwbSddrSJ0+Tl9Pkr6cdcvO2Yg1Kv6vVZS8b
RrrMGJzsz8zN75pqptFDaDo8NWNFTcOcUfAn2PWZbpWfLtkX/w05nvZHTMIwILKL
Gq5LiEEazGPO8T8BMcQYUGdPY2/3qNELtTWxHbmg8n4wrqcGm25mq8p13CRXwNbO
XA25YH2ityz3Iwv5fCpdmtrhXfNpZI8XtUgAWjwFzeRy0ZPT7+SHZRboQN2czPjG
3BIdzaxxHlSEXOnCJ+5gkqHqEhdd8g9NJnS+6gxRlyvKTdbb1RACzSKBqHEfCK/C
DzcId/O9Y8+iXpWSX7vO55fkU1c0zGSei+1Bl/kTtOccnvQM5zS7t9MKMIZM29JM
QIYrcXx236A6n/5lV2fCz4PX+p3QP7tyjPCcbkO6N5b81Lw7pkG/VgCLTCqtqbkk
KeGrLwZlgFgHHFapJHmBhpqGt3mAMZXUL10uGdhnVQucNc6JvyjX8wiWlSbwcjId
9S1iBnIIt3a2i/bbuFySySL2yTE5RwIKX/NynsWyaF6/pmYpfPjT6sue/Z38dbAN
YaxkIbOPVYNeGAoEJ9gK/kNlYMHMGLxfTX+QyL4CKrJbMd2w3wU=
=nw8J
-----END PGP SIGNATURE-----

--=-aHXCAGlIedGtjg2WiVst--
