Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534331BDA80
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Aug 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936117; cv=none; b=kGp0v8fWwIUOSHUQqf0dzUIJ78Pt5d3lc7cJg1fTpkyrw4iMks+FgXSpnRzIpbIcGFQFbiZ1XSIDLT+YVjS0ePaCQ6M87PrZnNk0Y/0OgDWZsNydWuDxKlyDlE9HaBjoZIrcD2Atdw7vX9zlNeVFq4qRWC71MGu7o8l8/nzpIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936117; c=relaxed/simple;
	bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVrpf5opyJiYo4hU9XhF+7kgAz7xwKk1PKYIS+NZV+suT0AJgElkzb5ndKGxLI1DciAjA/jDvFJuhSoAxA5WNYUapE8/TXmD2DrpYhu85PzcYpwkHUJLcT/7NnGRcUPNWSlyEoEh5tmov2YBUqPZslW/EpBcUXHpM5+l+KO+QSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mUx2mhlw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mUx2mhlw"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f035ae1083so4763701fa.3
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Aug 2024 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722936112; x=1723540912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
        b=mUx2mhlwrHE7NpMqRc7OoWNAbcYrI0hTggaPF0j9KQjvZfsLNo1a+cDshumuOkAXST
         5h9d5HPFpjiHjC4bhk0c+2UFh3zVs5oH/2OPt9BDK0rMjW0v6/yUcAORkxtSSv7PdLfj
         gNpHXJysPpGPAzPZol99w8C8xr8NoWy8QDR75NWiCahQJHS5PWnWHSSeyCWnJln2cxbr
         dbHKJwGiopid5VZ9xXUP93iTWOnRaKgti7ktGNTpDJ4iaMFT9OXwF7vvsnr/e1kfITlR
         gopDkKVIHdQ1ipEcRohZO8wB7JW+kHuye7z4c9Xq1LE4ppqmRFJ5tzUVTD26qjD31DdK
         jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936112; x=1723540912;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
        b=KzAoPRjj3beklnzcP6nWFiFsloMimZV6nDLL3hbhOEF0gNEVW4FW4NUgpLLu2pf/KE
         iuyoNTrDCy2KA0o2nN36FJ9hDE7noAmiNmQPmxA+Oz3A/Ua6le9NQZpV8xI+qIbKJ9cO
         ZyF+ZKa10imBNAQJFiZRYTV//c5J2WMpXjmB2+/vpmkDcC3A+xlj7XrHPyVExKZGdxqx
         W/g9PzhqtddyuZ/BGelVoiWHPKaYYhJw8zZFXh3kPlIelXuoLRYyNnfXUfsb2m/zSv3k
         73o8p1CyUoc+bmms1PJLlCl45E6saL7EQs84x8WMotqKz/9uCGtE5qgQED9gqNFFnuze
         bSBg==
X-Forwarded-Encrypted: i=1; AJvYcCUwbEujkh84R9iJQInz072BuN+dBZ7XvFtqod+G4MHOX84Uz8QO8USmN3QwHRMS4EFPVeUi8721fi1Ug9Ye2cat1Edn07S2/QHYsEyXjX8=
X-Gm-Message-State: AOJu0YwrD/t2qwyf+1js9rZi8bab71EIzQ+g55oDPmk4SBgymGSGjI28
	hYmXm2ZtAD4vrUm93BtY1kRSMOOA5ua1JItlD1WX0dOq1GDliWwoya0YVGYXC3c=
X-Google-Smtp-Source: AGHT+IFeTtsP8+6H91ULn+8s1Jzamf9Fh+dKBHWwa5CDk0Tz2O9PLeglp+ALCgLSDZU90YcDG0s7Ig==
X-Received: by 2002:a2e:9548:0:b0:2ef:265e:bb93 with SMTP id 38308e7fff4ca-2f15aa84e0cmr94527721fa.3.1722936111909;
        Tue, 06 Aug 2024 02:21:51 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:c541:c0a5:2f43:ca78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm230716785e9.39.2024.08.06.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:21:51 -0700 (PDT)
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
In-Reply-To: <20240806065021.PINvpze_@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Tue, 6 Aug 2024 08:50:21 +0200")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
	<1j5xsow839.fsf@starbuckisacylon.baylibre.com>
	<7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
	<1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
	<20240805153309.k_SfHw62@linutronix.de>
	<1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>
	<20240806065021.PINvpze_@linutronix.de>
Date: Tue, 06 Aug 2024 11:21:50 +0200
Message-ID: <1jle1auhu9.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 06 Aug 2024 at 08:50, Sebastian Andrzej Siewior <bigeasy@linutronix.=
de> wrote:

> On 2024-08-05 18:07:28 [+0200], Jerome Brunet wrote:
>> Hi Sebastian,
> Hi Jerome,
>
>> Thanks a lot for taking the time to dig into the driver specifics.
>> The IRQ handler is actually not awfully critical in this case. The HW
>> will continue to run regardless of the IRQ being acked or not
>>=20
>> The purpose of the handler is mainly to let Alsa know that 1 (or more)
>> period is ready. If alsa is too slow to react, and the buffer allows
>> just a few periods, the HW may under/overflow the buffer.
>>=20
>> IRQF_ONESHOT is fine because snd_pcm_period_elapsed() 'notifies'
>> all past periods, not just one. The irq handler does not need to
>> run again until this function has been called. It also helps if the
>> period is ridiculously small, to try to reduce the number of IRQs.
>
> IRQF_ONESHOT is used to disable to keep the IRQ line disabled (after the
> primary handler) while the threaded handler is running. This implies
> that the primary handler must not be threaded under PREEMPT_RT.
> =E2=80=A6

This is the point I was missing. It is clear now. Thanks a lot.

I have tweaked #1 and added a few tags but the gist remains the same.
I was going to add you under 'Suggested-by' but maybe putting you as the
actual Author would be more appropriate.=20

What do you prefer ?
