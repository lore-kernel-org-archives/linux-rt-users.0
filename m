Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5D13C677;
	Mon,  5 Aug 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871994; cv=none; b=Bab6mi7Jgz9RsYv7gpF0aMI0euyo85/9vJUJk+26+1h+DxzZS4kmtQUVCA9EFBQKW2B4BdYvuafDmP5m2A9Fu9zHJf1WhihWU+SSz0t/AP1xxn2cjBAIXSrbdwBR1GHWyaRzK/dPWJzwnT+V/mO/aOn6Mf42uftwvdLysNuG8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871994; c=relaxed/simple;
	bh=xz7pMosSnrQEU6GYh1jNebd60Tvu1ZpHTzssxOtrjUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ3OpRLTyyVzEbNjqJ/KVT7jbQiM0cSPvQKSoFuAG1rkJyc5hN4/lPw7zPYf0h5NkQ7t0SdgaAu7+Ep600yBytWNtV1RTM6/ZaKjBNL+RzVbIo1yIsiUjzr59nh78Dch0YzSXs1y0KYAps5UE2j0q28bE0Fi1PpBdcX5ViWOt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQD5dh/d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/2TPugQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQD5dh/d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/2TPugQf"
Date: Mon, 5 Aug 2024 17:33:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722871990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoVVPlB6sIY1d5GK5dwozDR3uFKevJmf+6ocl8483Eo=;
	b=XQD5dh/dS9zvxT1sxq/wfab9IbwdBAT6s4IMbz3LWOZ7UQqXH1kfld+65EbWFaQ+IC9w3N
	rdvShYi8dFrmIZgxKQNeSqof4R4DpD4WNkP6+4d19QmBQ2KBEMkryzOEVTcTshED3EaKxQ
	rczurYtMnr/7nJ2C2shls6MVWdZfuCHZF5OiE3DBDRJ0MLoAKn+uuU+BunmXzkLqCguAYq
	98/O3A/o1SxzPYYz2VmiW5VjLOONfd38CBEGlT9jXq4efUKF1xa+ohMUgIvT/VlqPfyCCD
	hZswJVT8gPz06dTADE4rqcZ620gyeyFrILIiKmbC10Ir2+H4yy9rUtvzJguSag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722871990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoVVPlB6sIY1d5GK5dwozDR3uFKevJmf+6ocl8483Eo=;
	b=/2TPugQf5xOZFfBEW6r5XFwR13BURvd9nXqxgUgsfnjYsOW99yVs36NxapFUE0d7aSy+3B
	suo4AYuzhO8ljlAg==
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
Message-ID: <20240805153309.k_SfHw62@linutronix.de>
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
 <1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
 <2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
 <1j5xsow839.fsf@starbuckisacylon.baylibre.com>
 <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
 <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>

On 2024-07-29 17:57:05 [+0200], Jerome Brunet wrote:
> On Mon 29 Jul 2024 at 16:28, Mark Brown <broonie@kernel.org> wrote:
>=20
> > On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
> >> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:
> >
> >> > I don't recall this coming up much TBH.  It may be that people just =
set
> >> > raw spinlocks when they need it, or that there's not many people usi=
ng
> >> > relevant devices with RT kernels.
> >
> >> I have not been playing much with RT TBH, but AFAIK, with RT irq
> >> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
> >> something preemptible in the handler should not be a problem.
> >
> >> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
> >> unclear here.
> >
> > Yeah, it's definitely likely to happen all the time for people using RT
> > with relevant devices.  I'm not sure I have a good sense of if it's
> > likely to be a nasty surprise to switch raw spinlocks on by default when
> > it's currently controllable, I'd expect it'll generally be fine but it's
> > possibly a bit rude to any users that don't use interrupts...
>=20
> Indeed it is bit radical.
>=20
> My concern with this patch is that, IIUC, the handler should be
> threaded under RT and there should be no problem with the spinlock API.
>=20
> Adding the RT folks to try to get a better understanding, they should
> have been CCed anyway.

I'm not sure if making the lock a raw_spinlock_t solves all the
problems. The regmap is regmap_mmio so direct memory-access and looks
simple enough to do so. In regmap_mmio_write() I see clk_enable() and
and this uses a spinlock_t so we should be back at the same problem.
There might be an additional problem if reg-caching is enabled.

Let me propose two alternatives:
#1: Why two handlers if we have IRQF_ONESHOT and the primary does almost
    nothing. Assuming the thread is always woken up and the "unexpected
    irq" case does not happen. If so, why not:

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 7e6090af720b9..60af05a3cad6b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -220,9 +220,21 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, voi=
d *dev_id)
 static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
 {
 	struct snd_pcm_substream *ss =3D dev_id;
+	struct axg_fifo *fifo =3D axg_fifo_data(ss);
+	unsigned int status;
+
+	regmap_read(fifo->map, FIFO_STATUS1, &status);
+	status =3D FIELD_GET(STATUS1_INT_STS, status);
+
+	/* Use the thread to call period elapsed on nonatomic links */
+	if (!(status & FIFO_INT_COUNT_REPEAT)) {
+		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+			status);
+		return IRQ_NONE;
+	}
+	axg_fifo_ack_irq(fifo, status);
=20
 	snd_pcm_period_elapsed(ss);
-
 	return IRQ_HANDLED;
 }
=20
@@ -251,9 +263,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *compone=
nt,
 	if (ret)
 		return ret;
=20
-	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
-				   axg_fifo_pcm_irq_block_thread,
-				   IRQF_ONESHOT, dev_name(dev), ss);
+	ret =3D request_threaded_irq(fifo->irq, NULL,
+				   axg_fifo_pcm_irq_block_thread, IRQF_ONESHOT,
+				   dev_name(dev), ss);
 	if (ret)
 		return ret;
=20

#2: If two handers are required due to $REASON then primary should ACK/
    disable the interrupt line while the secondary/ threaded handler is
    running. In this is case then IRQF_ONESHOT is not needed because its
    "tasks" is performed by the primary handler:

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 7e6090af720b9..5b4c518eb4ccd 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -205,11 +205,16 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, vo=
id *dev_id)
=20
 	regmap_read(fifo->map, FIFO_STATUS1, &status);
 	status =3D FIELD_GET(STATUS1_INT_STS, status);
-	axg_fifo_ack_irq(fifo, status);
=20
 	/* Use the thread to call period elapsed on nonatomic links */
-	if (status & FIFO_INT_COUNT_REPEAT)
+	if (status & FIFO_INT_COUNT_REPEAT) {
+		/*
+		 * ACKs/ Disables the interrupt until re-enabled by
+		 * axg_fifo_pcm_irq_block_thread()
+		 */
+		axg_fifo_ack_irq(fifo, status);
 		return IRQ_WAKE_THREAD;
+	}
=20
 	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
 		status);
@@ -253,7 +258,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *compone=
nt,
=20
 	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
 				   axg_fifo_pcm_irq_block_thread,
-				   IRQF_ONESHOT, dev_name(dev), ss);
+				   0, dev_name(dev), ss);
 	if (ret)
 		return ret;

On the PREEMPT_RT both handler will be threaded.
=20
My favorite is #1. Also ACKing the interrupt only if it occurred for the
device/ driver in charge. Otherwise don't care=E2=80=A6

Sebastian
