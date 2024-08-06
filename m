Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE915B147;
	Tue,  6 Aug 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927464; cv=none; b=DZHT1vf5P/e0RYlRZLu2RWf4rfazNAsz9Mbxzy1pR0MA5ATtPk1APU/y06Z2cLVFNm+ML8yc6jxeIDEXq9p6bvM1W2Ca4J4zobMh0Zgk1/WGm2JWqPgdnSjBtaBUNP6wjifrhv3wXEw/byBQ+s+xpwBoGcfnyW28+bO5W/noKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927464; c=relaxed/simple;
	bh=N7g1AP1MRXJlKsv+snG6qoOFn+tmUQ1MGZZk1aup6Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYwJarYl/rhLUqpc9tW5eE2w+c2TNbi16Tx0R820F0h+elriobDTzPoPD/BvdxWvdc1CWDIABCz4I1BEK49P3wl3pyXX8eJ0qSz92nE1O9PdTha1s9e0H1Fe5Dt35+z0Hb8LR4gF/GXVd15w2oL42IxtcuX2UT7Nfh8ahX9Q6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJRRVkgB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDiaKIxv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJRRVkgB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDiaKIxv"
Date: Tue, 6 Aug 2024 08:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722927461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62j0r8NgTpks8O2+mQwJWIgoNQHaq1WhltO5raRF02k=;
	b=cJRRVkgBGdGhodNNKTBJlbcd6CZrAkA/ofmdaQEfsMZAYKUC2t6laHW3ecwbsZYsFCkjf2
	34NutzNm4wtBFruN1N/CaUOqAJVkcorfbh7KLq9O+wButW4dCGbS+Pm+dpqnYVhnU7CcKH
	Xu7lftAhyAixgFQgNUz0otmYznlLcuO6szm1IxiNQ7CLQdg/mFfRhVCTG91PjDcYfObYyF
	wVnB2WwvbJMyAvNcERY9GkyHzIeC6CAk1vmGaMiCeZAJNws74jPchsjxbw/c/DJIPpQASm
	gMtijUgKIMSgRg0gfH2PAro4Eo1bHCZVngsmOhRxVPQ2k424eg37xaWoTEAScg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722927461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62j0r8NgTpks8O2+mQwJWIgoNQHaq1WhltO5raRF02k=;
	b=QDiaKIxvidaD49LuxspxsysRalmPj+QyVKlprtlmK9xpaznAzA3Asj/riap4hJk0L+Ls7X
	kFkI1mah3UN8YyCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Brown <broonie@kernel.org>
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
Message-ID: <20240806065740.DAZwSnQ7@linutronix.de>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
 <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
 <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
 <20240805153309.k_SfHw62@linutronix.de>
 <04b2b8c5-8b18-4594-9eeb-9971d8cf3786@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04b2b8c5-8b18-4594-9eeb-9971d8cf3786@sirena.org.uk>

On 2024-08-05 17:56:22 [+0100], Mark Brown wrote:
> On Mon, Aug 05, 2024 at 05:33:09PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > I'm not sure if making the lock a raw_spinlock_t solves all the
> > problems. The regmap is regmap_mmio so direct memory-access and looks
> > simple enough to do so. In regmap_mmio_write() I see clk_enable() and
> > and this uses a spinlock_t so we should be back at the same problem.
> 
> The clk_enable() is optional, users simply shouldn't use the internal
> clock management with devices that it'll cause problems for.
> 
> > There might be an additional problem if reg-caching is enabled.
> 
> The flat cache is there mostly for the benefit of things accessed from
> interrupt context, it guarantees to never do any allocations and doesn't
> lock.  You can also use other caches if you ensure that any registers
> accessed in interrupt context are already cached so won't trigger any
> new allocations.

My point is simply that those two things could complicate things further
if the desired fix is to (always) use raw_spinlock_t.

Sebastian
