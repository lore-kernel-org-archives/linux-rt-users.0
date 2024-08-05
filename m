Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3B1514E1
	for <linux-rt-users@vger.kernel.org>; Mon,  5 Aug 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874054; cv=none; b=Nt3IA/c+ApALVWjpZFJlSH5Yjtrv5/BRIBXHIQR8f0z7h8ArbGwhqi1fkmqZVutXKHqvDPsvrXaD7Z10CkuRdclOwjgW13KPF89Y9vBepmjy8Kft59sjyKUMVycgSqPFlcDYrylxbR5ZrrL+UO2ciaYU+6mf1PT4bdBQmBgeaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874054; c=relaxed/simple;
	bh=o0quoQ7ppGWq3Zo/T52ZVjVGnd+dV4B7L5rUpE1A9pI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qnjGTQHmv/ZdYjpQ1JqbR+d+oAqqp0BO1PAeFLLVliNaGoHD+52qiVeK32wHBOJILuz3H00iA548yY/D1SVLwBDlRo70mOHNauoQ0eiCDddZnzGjj2ssfUD+5PyAI0m5/Plj1UnfEILJwMHsvQc3cg23y4EnVevw7q6CLZzYyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PBeBn37k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PBeBn37k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso73878895e9.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Aug 2024 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722874050; x=1723478850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLnycLNpcQG5GUSmWzuFCsE23qxX0cM+qsqCFWzhcF4=;
        b=PBeBn37kWCyHYnxwLi8feiqn5pUULotJFTZbgj0WrxoRIZdKR2BAlVZPkWZBONWy0C
         5a5eSEhTprb1RznVSvhYNVIEVqW9PBtQJJ04QGG9Zk2ZCb9lhUdghfbUf/nSYvjPRXiW
         L0DZSVVMYA+Fx5B9rme1c7b1KokhhaPMYE1lIJHcUXZf+VNiONHl6p9sDFlRt7fq/1Sr
         ilYuWyUJ8hOi/JX+bN7V0TzOEuckI9gUiJhQ9WHzTyxMA66D9yCC2zi/oU07TP0mjqiA
         lQji2klq+hBFWVqtOYiXWiP9CS0DlJhqXzFkDl/NaMzW5xz5LqLrFWTWQExoMTfY/TEY
         UJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874050; x=1723478850;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLnycLNpcQG5GUSmWzuFCsE23qxX0cM+qsqCFWzhcF4=;
        b=wVTaffAZAYMInRe3BQOdjVh4Lkk5fGxpv1f8Mharux8Q7wOvzpMCbK/SipQZOtcTRS
         ielKowImnWy483nkfHC2AlZJL9yehTdF0gZP2NhxFbqlQMQI1nECkfXUFs9D48R+fQYe
         FQbQ4huO1OJ5vA+LpSNAdSWbm2NWTWlug6yi5Kg+5t82QdDOGpxUv8tjVStwkZ72gXzR
         uQ7E0BYRC+fKMzUOYtezC7xnZUQ8MFzbb/RI7VixT6Ukz/EVsGg+spdFEBffVW9kXrBZ
         0a6sTYyjfL/0L75B7HXhc720ktkPQgM5iD9EXZqmU56HyWdjS1OhztFrozsHLZv3oeEe
         43aA==
X-Forwarded-Encrypted: i=1; AJvYcCWwEc7m8cwDyHfgDOs8JyEnSZUN3cmOrpPrAYlKuM0G8gBNy54/qT8sIw0YUgNqQHqmZVncut8rJwrorQR7sObzEHPWXcZzCCTRRXKA8Vk=
X-Gm-Message-State: AOJu0YyGBWt2DaqP7pb5xyIg+XX9XuSyIYOd/V1q6LiJOivcEWRGrRGZ
	Xd8WYohrXZezLaO3q57D/dCV7RUiAQGSOU22a/rbrnVwQnAXpLqMwPMv7Wc+8N4=
X-Google-Smtp-Source: AGHT+IF7E+JH5oT9xq8G5w8s8h2rAblTnJFziKMkgTgJWNnfhajr1VdmMfvwoBX7+IWMhH58JY1aHw==
X-Received: by 2002:a05:600c:a04:b0:426:6ea8:5037 with SMTP id 5b1f17b1804b1-428e6b93136mr74516395e9.37.1722874049736;
        Mon, 05 Aug 2024 09:07:29 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e06c:bc48:dc7f:827a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd169697sm10229385f8f.107.2024.08.05.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:07:29 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>,  linux-rt-users@vger.kernel.org,
  Arseniy Krasnov <avkrasnov@salutedevices.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@sberdevices.ru,  oxffffaa@gmail.com,  Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <20240805153309.k_SfHw62@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Mon, 5 Aug 2024 17:33:09 +0200")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
	<1j5xsow839.fsf@starbuckisacylon.baylibre.com>
	<7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
	<1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
	<20240805153309.k_SfHw62@linutronix.de>
Date: Mon, 05 Aug 2024 18:07:28 +0200
Message-ID: <1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon 05 Aug 2024 at 17:33, Sebastian Andrzej Siewior <bigeasy@linutronix.=
de> wrote:

> On 2024-07-29 17:57:05 [+0200], Jerome Brunet wrote:
>> On Mon 29 Jul 2024 at 16:28, Mark Brown <broonie@kernel.org> wrote:
>>=20
>> > On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
>> >> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:
>> >
>> >> > I don't recall this coming up much TBH.  It may be that people just=
 set
>> >> > raw spinlocks when they need it, or that there's not many people us=
ing
>> >> > relevant devices with RT kernels.
>> >
>> >> I have not been playing much with RT TBH, but AFAIK, with RT irq
>> >> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
>> >> something preemptible in the handler should not be a problem.
>> >
>> >> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
>> >> unclear here.
>> >
>> > Yeah, it's definitely likely to happen all the time for people using RT
>> > with relevant devices.  I'm not sure I have a good sense of if it's
>> > likely to be a nasty surprise to switch raw spinlocks on by default wh=
en
>> > it's currently controllable, I'd expect it'll generally be fine but it=
's
>> > possibly a bit rude to any users that don't use interrupts...
>>=20
>> Indeed it is bit radical.
>>=20
>> My concern with this patch is that, IIUC, the handler should be
>> threaded under RT and there should be no problem with the spinlock API.
>>=20
>> Adding the RT folks to try to get a better understanding, they should
>> have been CCed anyway.
>
> I'm not sure if making the lock a raw_spinlock_t solves all the
> problems. The regmap is regmap_mmio so direct memory-access and looks
> simple enough to do so. In regmap_mmio_write() I see clk_enable() and
> and this uses a spinlock_t so we should be back at the same problem.
> There might be an additional problem if reg-caching is enabled.

Hi Sebastian,

Thanks a lot for taking the time to dig into the driver specifics.
The IRQ handler is actually not awfully critical in this case. The HW
will continue to run regardless of the IRQ being acked or not

The purpose of the handler is mainly to let Alsa know that 1 (or more)
period is ready. If alsa is too slow to react, and the buffer allows
just a few periods, the HW may under/overflow the buffer.

IRQF_ONESHOT is fine because snd_pcm_period_elapsed() 'notifies'
all past periods, not just one. The irq handler does not need to
run again until this function has been called. It also helps if the
period is ridiculously small, to try to reduce the number of IRQs.

>
> Let me propose two alternatives:
> #1: Why two handlers if we have IRQF_ONESHOT and the primary does almost
>     nothing. Assuming the thread is always woken up and the "unexpected
>     irq" case does not happen. If so, why not:

That was mainly there for initial debugging. It does not happen (yet).

>
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 7e6090af720b9..60af05a3cad6b 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -220,9 +220,21 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, v=
oid *dev_id)
>  static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
>  {
>  	struct snd_pcm_substream *ss =3D dev_id;
> +	struct axg_fifo *fifo =3D axg_fifo_data(ss);
> +	unsigned int status;
> +
> +	regmap_read(fifo->map, FIFO_STATUS1, &status);
> +	status =3D FIELD_GET(STATUS1_INT_STS, status);
> +
> +	/* Use the thread to call period elapsed on nonatomic links */
> +	if (!(status & FIFO_INT_COUNT_REPEAT)) {
> +		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
> +			status);
> +		return IRQ_NONE;
> +	}
> +	axg_fifo_ack_irq(fifo, status);
>=20=20
>  	snd_pcm_period_elapsed(ss);
> -
>  	return IRQ_HANDLED;
>  }
>=20=20
> @@ -251,9 +263,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *compo=
nent,
>  	if (ret)
>  		return ret;
>=20=20
> -	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
> -				   axg_fifo_pcm_irq_block_thread,
> -				   IRQF_ONESHOT, dev_name(dev), ss);
> +	ret =3D request_threaded_irq(fifo->irq, NULL,
> +				   axg_fifo_pcm_irq_block_thread, IRQF_ONESHOT,
> +				   dev_name(dev), ss);
>  	if (ret)
>  		return ret;
>=20=20
>
> #2: If two handers are required due to $REASON then primary should ACK/
>     disable the interrupt line while the secondary/ threaded handler is
>     running. In this is case then IRQF_ONESHOT is not needed because its
>     "tasks" is performed by the primary handler:
>
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 7e6090af720b9..5b4c518eb4ccd 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -205,11 +205,16 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, =
void *dev_id)
>=20=20
>  	regmap_read(fifo->map, FIFO_STATUS1, &status);
>  	status =3D FIELD_GET(STATUS1_INT_STS, status);
> -	axg_fifo_ack_irq(fifo, status);
>=20=20
>  	/* Use the thread to call period elapsed on nonatomic links */
> -	if (status & FIFO_INT_COUNT_REPEAT)
> +	if (status & FIFO_INT_COUNT_REPEAT) {
> +		/*
> +		 * ACKs/ Disables the interrupt until re-enabled by
> +		 * axg_fifo_pcm_irq_block_thread()
> +		 */
> +		axg_fifo_ack_irq(fifo, status);
>  		return IRQ_WAKE_THREAD;
> +	}
>=20=20
>  	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
>  		status);
> @@ -253,7 +258,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *compo=
nent,
>=20=20
>  	ret =3D request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
>  				   axg_fifo_pcm_irq_block_thread,
> -				   IRQF_ONESHOT, dev_name(dev), ss);
> +				   0, dev_name(dev), ss);
>  	if (ret)
>  		return ret;
>
> On the PREEMPT_RT both handler will be threaded.
>=20=20
> My favorite is #1. Also ACKing the interrupt only if it occurred for the
> device/ driver in charge. Otherwise don't care=E2=80=A6

I'd prefer #1 too. IRQ is not shared, so the ownership should be fine.

However I still don't fully understand what we are fixing here TBH. It
seems it could apply to other parts of the kernel so I'd like to
understand what is wrong (and avoid repeating the same mistake)

* With PREEMPT_RT, both handler will threaded, so they should be able to
  call preemptible function, right ?
* If so, and spinlock_lock() actually becomes preemptible with
  PREEMPT_RT as stated in this change description, why is it problem here ?

Do you have an idea about what is going on ?

Again, thanks a lot for your help.

>
> Sebastian

--=20
Jerome
