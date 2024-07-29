Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27C158D6A
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Jul 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268630; cv=none; b=EkXgezQbzK6oxp+gboWe3M64Ctdkre/oLEGGZ/1KP+JvgXdWDNxc8DQaPlB2NDGHa3j6wpAg22hFVkUi4PaxxwEptELkAQmtUua+EXV70YxAzkKS9DfCmtF36QIQ0D+B+330tWtto/RAp1cqnNexjrbD7RvRcypveJ7xADMs1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268630; c=relaxed/simple;
	bh=CbhyjmepvZ2GQWlE4o/bGvvFhBwaNQx9b3bICGSN68M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MaOiSTwwWsZkOY5NK+WI10n8QnHASs5jcvvjQ4OrgfGLYv7OGEChCHIY+bzvhyR7MOGTCYeSMctTYenAMsit/KBkNFa5CL5L6cu222ZAVHRXLWMVLbccTq7jWZZ+l+0eXtC3MQC/4hv6YQocnYzybOm1liZdajgqhqOi0ZRbyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTpYxSdu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTpYxSdu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so18333345e9.0
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jul 2024 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722268627; x=1722873427; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQJQXLHnlv/DKOapoxTHZwq5P+QBGMyJlUyNZAowiSs=;
        b=dTpYxSdubzoZvg2P+skIUyp5G1F2bo6NhforT4WEwSmJnAriHq5flK7pjkGFf/P+cZ
         1TcOQRFK0gh7UV42EsLC/+G66kVOVAdHysLz/AiyqFu7YOGBmroX/ThNWx056zAGpqkv
         LCl1nPlvfLnb8UcN5oS/5kHyxlCOw/ViKXOtxsprK9VJjhWYJIG1oX6MXdSuyUt676w3
         jAeRSB79yNUpxKGaWYL6xCYgD33sM12T2N4KhNyUTtlpF6YYKVCHM2TChcoHxq/kZoHK
         gx/xlthh7A2VbBgnNPjFhZIIPgAum3mob8AvzZmAZ/RQydNuvODCUCYUlwfno0+XaosW
         zhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268627; x=1722873427;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQJQXLHnlv/DKOapoxTHZwq5P+QBGMyJlUyNZAowiSs=;
        b=cyFm7THVNE76tVidcU8yeZRrVsynyWgMMxUy+50JiwcVZHhX5DbapwLQ/pxxEa4iho
         jyi8y1/tOT+La5MU9AOkW1Wn7N/c++uUbiKRLAthN8UFSDU8S+fGsSRK5reo+bQXU5G7
         lL/nurkaey0Ii5o6ajJzSTrpTNJuOnrBvR40sfzXZfSIopyO5qHbZi0aLUM5UihBTSkV
         TGiYIejLNyhAHI6xTLgLjpuq+TIUZfIM14uhYTa1yOY7tEv9kaNtKrxW8ejWNpwrr3x7
         TrbZa9yBrw3f6Eu5Btene4IgiuTOkh+8hwQ0wVToTtZIvXO17BT0qwI/j0T7y2feBQva
         0wpg==
X-Forwarded-Encrypted: i=1; AJvYcCX2AW1QacbYoq7UcigLU+nDgl8kGRP+NJtIRRl/M4lmxNGZnBTHdie/DL3OGyeO4tb9HX8Upqcy2gvz+DMiRC26YwiQFXkQAUg/UWflwPg=
X-Gm-Message-State: AOJu0Yx30FRJnbyqw9ctA0jNfmTghxkR+egJIS4rkEOLfh0Efy2YNirv
	VA7IbpEcDa8KwtdSYb+WccdRIpqQlMxQoujkKoR0xOFZlpMF5qr166TePG39Fko=
X-Google-Smtp-Source: AGHT+IEBBx5LsAEMyoM6oe7rtQrWY0rnpjUL/ghKQBCG5QRwkixQ4Ro9RCrukrZIHEiRAWSLTz45yw==
X-Received: by 2002:a5d:6347:0:b0:35f:10ac:ea50 with SMTP id ffacd0b85a97d-36b5cefc0afmr5637864f8f.37.1722268626835;
        Mon, 29 Jul 2024 08:57:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3687003dsm12532306f8f.115.2024.07.29.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:57:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>, linux-rt-users@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@sberdevices.ru,  oxffffaa@gmail.com
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk> (Mark
	Brown's message of "Mon, 29 Jul 2024 16:28:56 +0100")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
	<1j5xsow839.fsf@starbuckisacylon.baylibre.com>
	<7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
Date: Mon, 29 Jul 2024 17:57:05 +0200
Message-ID: <1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 29 Jul 2024 at 16:28, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jul 29, 2024 at 05:06:50PM +0200, Jerome Brunet wrote:
>> On Mon 29 Jul 2024 at 15:44, Mark Brown <broonie@kernel.org> wrote:
>
>> > I don't recall this coming up much TBH.  It may be that people just set
>> > raw spinlocks when they need it, or that there's not many people using
>> > relevant devices with RT kernels.
>
>> I have not been playing much with RT TBH, but AFAIK, with RT irq
>> handlers are threaded unless IRQF_NO_THREAD is set. In this case,
>> something preemptible in the handler should not be a problem.
>
>> The axg-fifo drivers do not have IRQF_NO_THREAD so something is a bit
>> unclear here.
>
> Yeah, it's definitely likely to happen all the time for people using RT
> with relevant devices.  I'm not sure I have a good sense of if it's
> likely to be a nasty surprise to switch raw spinlocks on by default when
> it's currently controllable, I'd expect it'll generally be fine but it's
> possibly a bit rude to any users that don't use interrupts...

Indeed it is bit radical.

My concern with this patch is that, IIUC, the handler should be
threaded under RT and there should be no problem with the spinlock API.

Adding the RT folks to try to get a better understanding, they should
have been CCed anyway.

-- 
Jerome
