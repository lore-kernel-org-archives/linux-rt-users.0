Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86122173D
	for <linux-rt-users@vger.kernel.org>; Fri, 31 Jul 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.206.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491243; cv=none; b=tRzbNEVJo81fLu5k3r6xlS5tic7ppdLTXoGfBIFqHD+/Lgu10H4t3+wKC7jUXZoEDp06u0FfMI5O2G7NckhXkIY3ciXJ8iAQrNNwY/0AkP71vSrzShG1ZCzsmy4WPdpkiRwvqG6MtocBD7Ey0Hjx2+Hk/NSIL6Yba9fNYWcJkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491243; c=relaxed/simple;
	bh=rYVVC3DjZYTR3sEqRI8l7oR6QM4f2j4QYVXRzaisd1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDGZkxsdu80mdwu7h3+GNqfIpEh+ZT274HdPiNaD2jdtCkJl2eX095x5HjhEy1cjf/+5bewEHmMpcIJYYqkyxmeqgbr+S40oB6SkeBmoCs+t0I7ac67W4qLemiiYX6l2dFDvrbcmdNuNo/JAaaWRzhlBfDLylB6IST9+DM77BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de; spf=pass smtp.mailfrom=sleepmap.de; dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b=QGgLsGh/; arc=none smtp.client-ip=85.10.206.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b="QGgLsGh/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sleepmap.de;
	s=RzV2MS86Cdvz; t=1785490820;
	bh=rYVVC3DjZYTR3sEqRI8l7oR6QM4f2j4QYVXRzaisd1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QGgLsGh/kG9d99FCaYM5Wo4DQjRiJT3I/WYalvlESMnEMtLKfc2mJQQc0QTsSWyWh
	 v/IDunzvwXt/iiLF0kOkGATioMkUYr2AaTBOr4uRPOzsp/VERqFNrOOPpr4NcsNjZP
	 ay2ZcfB+FK6ge2oA9NKUh+eOW8a4lp7CrBeJkGhk=
Date: Fri, 31 Jul 2026 11:40:12 +0200
From: David Runge <dave@sleepmap.de>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] tuna v0.21 released
Message-ID: <amxtfI7-b5L_5Grd@hmbx>
References: <20260728213631.285648-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fyrfiHYIZiJgSA45"
Content-Disposition: inline
In-Reply-To: <20260728213631.285648-1-jkacur@redhat.com>

--fyrfiHYIZiJgSA45
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Date: Fri, 31 Jul 2026 11:40:12 +0200
From: David Runge <dave@sleepmap.de>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] tuna v0.21 released

On 2026-07-28 17:36:31 (-0400), John Kacur wrote:
> Tag: v0.20

Hi John,

congrats on the new release!

As tag v0.20 is from nine months ago, I guess you meant v0.21?
However, this tag does not exist yet. Did you forget to push it?

FWIW: On Arch Linux we are using the tags of the tuna repository to be informed
of new versions of the project and the auto-generated tarballs, made available
via the cgit interface to build from.

Best,
David

--fyrfiHYIZiJgSA45
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR8efy7g3Ll3lsX4JqQ1LlkHgkpcQUCamxtfAAKCRCQ1LlkHgkp
cZt9AP44XTrMpiYZxd557uUvvWD1BxZJPDOSl5bw54BKWoDX/AD+JXCiO+lEblX7
qQXzPv6Z3NBHwsEEE6Vk5Ca3o3DXNAs=
=dbxK
-----END PGP SIGNATURE-----

--fyrfiHYIZiJgSA45--
