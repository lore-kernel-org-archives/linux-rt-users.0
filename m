Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFA221541
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534828; cv=none; b=a98Kq4UyzdqtvqYQ1CQqZjoMAbsTs9cjcah5/AhTZ/OWywC1WfnlpV1HDK5ytjy53JgZ0+i2OxJqVs3NQGDnle9gITcAt6c9Kve6ob9JhFFQm/D7ro2/VGeo8icj1CCbe/JbQv0hXsotvTpY0TJVpz0LAp1u7eVGGMqk08bEzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534828; c=relaxed/simple;
	bh=ostRAiOXLLMELNQ7avd2iOxlx4aiuH60q9LWmyNfTKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rK1OWSvUtnYuNZ+e8OB9qa8jOUh7zZtGLQ9Ay0Rq1w8iWN4c7AyB294DF0xdij2pK9O0V7CXsOJIQiF+CUEqCmVGUvtWC9bNy2PyDDQ8pS70Kh1bfhj9DEjIfRUC4p/CNCde/xMMZLKaOiXR9pq0gapPaWxrN36y9hb/lCUFi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DY3DJCa1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY3DJCa1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739534825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ostRAiOXLLMELNQ7avd2iOxlx4aiuH60q9LWmyNfTKI=;
	b=DY3DJCa1vkc8P5YcDIdG5xPIKlKZpTiNxABlpStosmPIH/pPP0kd/oyb1ev4O1bmcd8N8a
	/iX37nUuRLSQlijrnlgJkhFmt80YCfMCWcoQhfWC0FXHy0M3KkhGWsr9tyOobMO4yxeJ3Z
	Cw+fU47F6RL/hDH7tRKwcNtZUOxTuGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-HDnmgZEdM5aK3EdpJJ6hSg-1; Fri, 14 Feb 2025 07:07:02 -0500
X-MC-Unique: HDnmgZEdM5aK3EdpJJ6hSg-1
X-Mimecast-MFC-AGG-ID: HDnmgZEdM5aK3EdpJJ6hSg_1739534819
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so11248465e9.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 04:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534819; x=1740139619;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ostRAiOXLLMELNQ7avd2iOxlx4aiuH60q9LWmyNfTKI=;
        b=AJlDqJHhM72Y1Oi0mq6y70t0BpIEQgKzbn6nv/Ft4SU4vPX1XyxU80pOlvZLX7k5i6
         XTzuWdgaInN0Hl3GpkRL8RFnpGQYMGqH4KqjVNVqTyHDoXacAnH826HpEvXqvPJlrMPS
         WoC4Oyr/Ld+zhJWhqXoIOeKobue5Z0S9REdSeY4TeylZVtEBJfCQpKewQlGkX2eMCFae
         puNOG1QbV6ABEY5+OAkG7brdwy4CvoiWPepfoS4bjETWb883AvNOb54+1hSi/+x9YlHu
         Vh7UfkWTYM4gNqhTaN9BKVTgCppDBYb++eu2SoYn2nAcxFdwFuiOAoK51Lrniz7USr5h
         S6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWN/pmv/cNR4Zs5QZtC2BKVMOxvMN9zj1TxqILmpY71YABsAAQ5aG+8B/DPcufK4WE3uR/Uw0XqyxjWrtso2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCc9pivX+N5s7TwUgGmZSl9IYb4QcnkT3T0aGor9noDL0PnV1W
	SMnT6F0zH3eS0GYr6cRQqX/vEOa4x+wxpIu4D0KjNujrj9kw9wAkWcYi1QYMqR/o8sh7V22bHzv
	ggyGHI7HoAfw5DQ7AhCa2DTekaHqiUEXdVZ/uwS3nTv1l4vuzxxKdjlQRyC7+V38i
X-Gm-Gg: ASbGncuvEklBN/9L4Iuc/aLDPS9cvU32S9wa2VNqNeKoo3CRWA0NHo+1fLeQKqNKjcz
	HC1cD5/MUMZ5DRVOpiRsi8mdE/9d1ZE+RcS+HFgTdMqVen40Lka4rElqTt2YTzM2wswDYORdgnT
	8BEgd3ZXU/CxVTNXnfp6X+uM1qP946LYttaB1l3Di+h3Jkfxuk+u+2bBX/m08hI6Z38dotvoELO
	shEfyNVnohCgKy+m+ethykORKOyOBeP6XSSrglIZkmrdbHRgCO69YHYaERGqvGGeqFUilXL3TAl
	owmYozRBJeRyKPOOIEgA5YU27og6ssVxxw==
X-Received: by 2002:a05:600c:870a:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-43960169268mr95944525e9.4.1739534819121;
        Fri, 14 Feb 2025 04:06:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGOrB/Db/MBwaKU72ad9HIz6zh3xV7aKrJvPTXt7gDaJtMx4hxSQ/QPCN/fhwhDnNwSeTOUw==
X-Received: by 2002:a05:600c:870a:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-43960169268mr95944235e9.4.1739534818792;
        Fri, 14 Feb 2025 04:06:58 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d22csm74295075e9.22.2025.02.14.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:06:58 -0800 (PST)
Message-ID: <c12f6e1a99ee7deb8ab00ed99e709485d754170f.camel@redhat.com>
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Florian Paul Schmidt <mista.tapas@gmx.net>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org,
  Mike Galbraith	 <efault@gmx.de>, Leon Woestenberg <leon@sidebranch.com>
Date: Fri, 14 Feb 2025 13:06:56 +0100
In-Reply-To: <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
	 <84bjx6h2kd.fsf@jogness.linutronix.de>
	 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
	 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
	 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
	 <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
	 <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Fri, 2025-02-14 at 09:31 +0100, Florian Paul Schmidt wrote:
>=20
> I wonder if there is still a way to save the day, i.e. use the RPI5
> as a
> somewhat capable RT-system by
>=20
> 1. making sure that the RT load does not do anything nasty - this is
> mostly under the users' control since they can setup their RT load to
> not do this.
>=20
> 2. preventing other tasks on the system from trashing the memory bus.
> These are not under direct control by the users if they wish to run a
> general purpose Linux system besides the RT load.
>=20
> Is there any mechanism in the Linux kernel to achieve 2.? This would
> probably come with significant slowdown of the non-RT tasks, but that
> would be acceptable at least for me.
>=20

Hi Florian,

as far as I'm aware, there's not much in the linux kernel to achieve 2,
at least without hardware support (e.g. intel MBA and friends).

What you mention really looks to me like Memguard
(https://github.com/heechul/memguard), there's a lot of research on
similar approaches, essentially what you do is to assume accesses to
the bus are given by LLC (last level cache) misses, as those are
usually easier to measure with PMUs (on-chip performance counters).
Then you give budgets to each core and throttle the cores that finished
their budget.

Memguard is the closest to a ready-made solution (thought a bit old),
but you can find several papers on the topic, also something that
really throttles tasks and not cores, so you won't need to play with
isolating the few cores on the Pi.

This requires a bit of crafting, but I hope it gives you some insights.

Best,
Gabriele

