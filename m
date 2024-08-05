Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F02C684;
	Mon,  5 Aug 2024 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876989; cv=none; b=IKQt/IHuaw9zftnnYpQYDvX9nPEP5sGFqcj+oOu9WTnM6G32jiqJYgtmBgueHKCTavoHki2zXX6znOz8IRX2okN6pimVdsnfrEy8D29bi2irn51OSrGCFuAx/mZ0NCnR4b4Xz9gIMCotdHadoNCZldVUFwKVOiEUgcIFAQ3ejLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876989; c=relaxed/simple;
	bh=cJWWhC5ntldu+JRfUJ99sO45oMidL1C+aIhRQhQ9HhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq67D4p+8EgtDB1ZNU2K5r/v+W9FIUarj1tgfJD9KbiNrQvi5Mv6RjWMTXHCv3Tl2QM7AnpmnejjUrf7Z4BrGiW3Q5d5IETUVpozJamx8DEYx2NkmX93AuYHxb/Ri3V9JlNu4+YfkNj+RB3EAxFabmsIf8Tx7GKhHemrVkIbvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biWOUkoZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biWOUkoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27EFC4AF0B;
	Mon,  5 Aug 2024 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876989;
	bh=cJWWhC5ntldu+JRfUJ99sO45oMidL1C+aIhRQhQ9HhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biWOUkoZ5sBoNUHYGurUnIIqoCBRLJ5bAmFx1TzTjhQrqkTfFCnQ37ZuIwUuokGp3
	 RuY7tEaw8jgMKjxaVkj6bCKPQlKwwbXAG/CrmwhMqOLtMyvkn0kGUtu5tZezCPjZav
	 Yr5F/9aC66HXQmBSwk1T26ph83Ka2gtp9UucMS77yZvzWlvz+fO+tC3q9Vhjdoon0I
	 aWVMobpfMB8zCj9Xx9eT79SxEgjCG8fhoEb9JOzWaZB+AAwROTPV2yV4aBtK/Hicta
	 AucsqaeypgdjrEcJIcF1ukeUUcZcEoSAIMyAinI2CfWUm+YQ/UC5DglJIs1uUYNzqO
	 OcuMSCut6P2Fg==
Date: Mon, 5 Aug 2024 17:56:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-rt-users@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
Message-ID: <04b2b8c5-8b18-4594-9eeb-9971d8cf3786@sirena.org.uk>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
 <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
 <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
 <20240805153309.k_SfHw62@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PmcO6oqNBVuQAmrg"
Content-Disposition: inline
In-Reply-To: <20240805153309.k_SfHw62@linutronix.de>
X-Cookie: Goodbye, cool world.


--PmcO6oqNBVuQAmrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2024 at 05:33:09PM +0200, Sebastian Andrzej Siewior wrote:

> I'm not sure if making the lock a raw_spinlock_t solves all the
> problems. The regmap is regmap_mmio so direct memory-access and looks
> simple enough to do so. In regmap_mmio_write() I see clk_enable() and
> and this uses a spinlock_t so we should be back at the same problem.

The clk_enable() is optional, users simply shouldn't use the internal
clock management with devices that it'll cause problems for.

> There might be an additional problem if reg-caching is enabled.

The flat cache is there mostly for the benefit of things accessed from
interrupt context, it guarantees to never do any allocations and doesn't
lock.  You can also use other caches if you ensure that any registers
accessed in interrupt context are already cached so won't trigger any
new allocations.

--PmcO6oqNBVuQAmrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaxBDYACgkQJNaLcl1U
h9Be3wf9E7bM5pWGm5SeLcoOoFtCljwgUPX4/syxkWZ4gbzyXkWXA1jBOgucoU9o
FvwE+yafCfSo0zG2EhElLUT9dp9MLj0S8JrWfQFSeh+1OGdZR/KjK1NEVYiV6doP
Ye1L6xxIstW6NNhLYENRIUok6WX6L4vFOAWR2By2lr+0IYY9gpstt1/s72jdLamt
xhKp1TzPAOTUvjhYP5BTZJCQ0ugrCnW+T52tdExyCnj/7wdomwKf8TRUZsz1AmUF
yL//1bYA5Oynyz/rrvKNPxjcvG6sGmXaV1ZsomGzrMRnZH0kXzFu6IPUNIRG9fN2
YK8Qt4jLj7DKCNmtBrQLLUjQDKN1Lg==
=p6B8
-----END PGP SIGNATURE-----

--PmcO6oqNBVuQAmrg--
