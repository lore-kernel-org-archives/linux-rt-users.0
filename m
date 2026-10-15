Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6C45FFDE;
	Thu, 15 Oct 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056635; cv=none; b=ER+6X6cAbqo1mC7rQ0A8Y8IgJOAp48xqowdd53ipdUvDdlS09HMa0R0veQbigo3iu8xREz0/R5RA+GrDJbBmxUawjIJXuQBFPvb23xGcOGOXTiCGAJGRgXgV7l33auGwLPan5CPfJWiis9URpCUPIk01mBhfPExR75sw9v2relk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056635; c=relaxed/simple;
	bh=uhnP+jwxp29wNveagBimPPyDBbAIyHeipqn9F6EPfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufy4FNmeqVcfarL7sWiWcRYYLUpOwJf6qDFV/B8fq9DNBPzALEfr8f9mwpQsu/aReTrO9Tk4EcqVUJTTXJ8HPqeALw1iF09V6puaKaP2RahHtu9whf68izznThEc1VAh8E2OFPt9CB2+iU/cWpX/s8ZI85UktB3f5NPpuzUY2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Tmoj8PT9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Tmoj8PT9"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF7E7104DD9;
	Thu, 15 Oct 2026 11:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792056620;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=A9oKQ+lANFcJeP01+osv/cQxBxrkp9GW9iPzUWKGCro=;
	b=Tmoj8PT9m+osZSkfm/8R554z4NVn49x9/MqBwKjBo9HnkjHn6Hpoh3a3s6XsZ9g7zdds77
	SWoUkcyvzLrKgJgavhwZrUk3ieMuUCnajv/ePDwdMznixvGxHqVUVMJ9cSMaQ8fOqCzqUt
	hU/NJsQk6lNVAL6CR48y/SCuSOw7rZ4FPGpVPrHMRK3v10pCzQ32rjLtjLfdsSjk1j8Ojf
	72EZHH6nnTaJCQ1nqzfiguds8X7LXm2KasgHugiqQbjdKyUFdV14L/RbN5FEG8n76B3l1d
	KdAw2zy+ROeW5cXrHufLnJNkuWNBIXfTzyW2dfX4wfrwGaFgwOyJJUM/640XqA==
Date: Thu, 15 Oct 2026 11:30:08 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Stable RT List <stable-rt@vger.kernel.org>
Subject: Re: [ANNOUNCE] 6.1.187-rt68
Message-ID: <atCdIOQEUIZ8dGeB@duo.ucw.cz>
References: <178887672559.938703.5575015017829953375@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bHa3G3JlwVmzANMZ"
Content-Disposition: inline
In-Reply-To: <178887672559.938703.5575015017829953375@demetrius>
X-Last-TLS-Session-Version: TLSv1.3


--bHa3G3JlwVmzANMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 6.1.187-rt68 stable release.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v6.1-rt
>   Head SHA1: c1d28e881fc23290450b0ba3a5d9a78431061256

Thanks for the release.

Unlike others, this one does not seem to have a tag:

commit d44cc6ee62ead2ba9c78eedc75be6b15807fb079 (tag: v6.1.189-rt69, rt/v6.=
1-rt)
Author: Clark Williams <clrkwllms@kernel.org>
Date:   Wed Oct 7 17:22:27 2026 -0500

    Linux 6.1.189-rt69
   =20
    Signed-off-by: Clark Williams <clrkwllms@kernel.org>

commit c1d28e881fc23290450b0ba3a5d9a78431061256
Author: Clark Williams <clrkwllms@kernel.org>
Date:   Tue Sep 8 09:06:26 2026 -0500

    Linux 6.1.187-rt68
   =20
    Signed-off-by: Clark Williams <clrkwllms@kernel.org>

commit 5473e5cc35dfb930c7c50fdd61e63458f975dff9 (tag: v6.1.182-rt67)
Author: Clark Williams <clrkwllms@kernel.org>
Date:   Mon Aug 17 16:55:30 2026 -0500

    Linux 6.1.182-rt67
   =20
    Signed-off-by: Clark Williams <clrkwllms@kernel.org>


Best regards,
								Pavel

--bHa3G3JlwVmzANMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatCdIAAKCRAw5/Bqldv6
8jwaAJ46X8wXge5QEGfIDLQeV/xlnLRdMwCcCm2y36lMgm3PfNle8D3O1ab2bh4=
=ng/u
-----END PGP SIGNATURE-----

--bHa3G3JlwVmzANMZ--
