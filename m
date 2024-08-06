Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B71BB683;
	Tue,  6 Aug 2024 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927028; cv=none; b=gmYZSlCR+O4k6J1Hdc8SsEbBMoiPRl/HFouP8eT2f0UwVlgDta61qS72oH2k8PMlsSLuzHQSDWq8lQs571Y5qEZVbsQeRYHFa+1Bvmrq0/JKCMOUQEcGOUrHgoV563Une64vmSIIF1h/a3DVbXc9IGd5w6+t2fnICz4XicuquZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927028; c=relaxed/simple;
	bh=T6SyAPa43fw3itnzT92TxN8RxarjUCzV8S2bnCPfBT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goObBIq8em4W9KxrrrQtJ6omBFk9HWGr8keYXEwiyLrkwOqO4QxKb65rqWxP4vyY1J1okloKmZxuuAqr8PxOBla3T4QkfYGWg62J1eZPwIqipbAzpSAUXZQogcioiLjOh/4Spo/xbAE+c5oSXsOE7wTA2gWbA4Ga50FP3iWyrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRNXjRJv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3ml5t+u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRNXjRJv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3ml5t+u"
Date: Tue, 6 Aug 2024 08:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722927024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rYwgW2vpzfVbKjwpUB+DO7Cgb0fWJ3gvVqC78ZYBjc=;
	b=KRNXjRJvNQzui5oqkfFTnZJm+mq5/Uz7KzMCCC2D3wdX+ye1GTrX5Msw+xHtI3OOc1Hdj6
	VieGZ1a/OcRs1m9Sb2Apsmoh29p7j8ragrJqRrkqTqzqWEkNyQJ83OHZPhua96Npo0mpEe
	ALyPCoum7gGChvW2uRhzsZhC8bPmttEZSXIRuy8QVmDTcKZgGI0Bu2e1i1m7QVORQDKD+R
	bb85RgD+Xnhhb0aIybhg3yASzuJvvC5V4LhL3djs7AlTa8zOr56uJSarKVsxymHbK00x3E
	/2asiIoBSLElgrAJZCcVvjtdcfpxSUUlT86D3WjGTe3nt3MpWwhG2OJ6RW5VPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722927024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rYwgW2vpzfVbKjwpUB+DO7Cgb0fWJ3gvVqC78ZYBjc=;
	b=n3ml5t+ugxpduMixS1Q22fM9Y967N/rmITKJzqOlOAMP+ffzesZhFEfh/n6FQXYxf5BhY4
	KO++8jgRBOhm3lAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-rt-users@vger.kernel.org,
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
Message-ID: <20240806065021.PINvpze_@linutronix.de>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
 <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
 <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
 <20240805153309.k_SfHw62@linutronix.de>
 <1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>

On 2024-08-05 18:07:28 [+0200], Jerome Brunet wrote:
> Hi Sebastian,
Hi Jerome,

> Thanks a lot for taking the time to dig into the driver specifics.
> The IRQ handler is actually not awfully critical in this case. The HW
> will continue to run regardless of the IRQ being acked or not
>=20
> The purpose of the handler is mainly to let Alsa know that 1 (or more)
> period is ready. If alsa is too slow to react, and the buffer allows
> just a few periods, the HW may under/overflow the buffer.
>=20
> IRQF_ONESHOT is fine because snd_pcm_period_elapsed() 'notifies'
> all past periods, not just one. The irq handler does not need to
> run again until this function has been called. It also helps if the
> period is ridiculously small, to try to reduce the number of IRQs.

IRQF_ONESHOT is used to disable to keep the IRQ line disabled (after the
primary handler) while the threaded handler is running. This implies
that the primary handler must not be threaded under PREEMPT_RT.
=E2=80=A6
> I'd prefer #1 too. IRQ is not shared, so the ownership should be fine.
>=20
> However I still don't fully understand what we are fixing here TBH. It
> seems it could apply to other parts of the kernel so I'd like to
> understand what is wrong (and avoid repeating the same mistake)
>=20
> * With PREEMPT_RT, both handler will threaded, so they should be able to
>   call preemptible function, right ?

Correct. But flags like IRQF_ONESHOT won't thread the primary handler.

> * If so, and spinlock_lock() actually becomes preemptible with
>   PREEMPT_RT as stated in this change description, why is it problem here=
 ?

Because in this case the primary handler is not threaded and runs in
not preemptible hard-IRQ context.

> Do you have an idea about what is going on ?

Yes.

Sebastian
