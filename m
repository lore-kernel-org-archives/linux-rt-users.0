Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6F1B0F17
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Jan 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329754; cv=none; b=Y9W5JPwpRwHpC+jG2437zqLwm9dj9UxCLnAXNzqjkP7qBhHTctEFGvVfeR2o+dqCaxIb1l+CAVdqgTU/XL9e6xDXXPsrDclwbwFV9bYz9DKIAsP5rjuxSiByNxaMS3xFkXYVASE9VJTFQFdBDSsGnfR9jCHjziEIdIry7x5aIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329754; c=relaxed/simple;
	bh=9VlznO0gIu3qeEb2YykSbHYD+ISel2LtdybcAmpG+kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqo11dqomnD0bynlTWbHod373KSKNGpXRsw5lXL8spreKp/jRbPO/4J+HeojOOt2NmNVaXl11BZr0Yq9LZ922LgxTsqPAnFSDfkh4tsZWrrEiY+HT7czjgpSWDBI1Nvu5LEm20d6Eddm+wmZwHJOMWMD3nkz8Q6j/MS9jtFn/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=WAUEbkLT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="WAUEbkLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736329737; x=1736934537; i=mista.tapas@gmx.net;
	bh=9VlznO0gIu3qeEb2YykSbHYD+ISel2LtdybcAmpG+kI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WAUEbkLTW0DpzmAAoJwrCp9IPPEzE5JBBZDUVW+V9drJAods/vtvnBsgPJEJhICY
	 COKfNso8o8z6AYJ8pnGTIaLLMHtOfGDL3d4xn3psKegl9VgH/Uj4H0o/qI6cZy9Nr
	 ojCiS8EwQUAHNu9Ac1LrRfUMSJFgP+YCdIxKjnZEqZ6nQFMvBFblWXRGp4VJbuW9T
	 iMHic1QSaXGQQ4A8TrrWR9UhxiCiefVLt+Dql0L1OF/LaIcE2063WSJqgxSlIduWJ
	 aZUbcn/kd/I/euwUXIp+movD/qawwmUIj8TtjO5Isj1DeGA6+c4EF1/zuUaehuxOJ
	 eH3vcgClhXrUrgH8Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1tr68B03qE-00oZw9; Wed, 08
 Jan 2025 10:48:57 +0100
Message-ID: <6b290601-7112-410b-9a85-bde02f62d7c3@gmx.net>
Date: Wed, 8 Jan 2025 10:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <20250107143937.d_ho7CXb@linutronix.de>
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20250107143937.d_ho7CXb@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBEmLct8B4E2GwpY0RqkP8agMXu6q0GE8lMwJL/nQkoW18YOv7s
 Qm663KhgjKyeTnZkQqOUVB6gzrJvEBJVKgyeqIiJKxihTjbvVThAPfaJsnARnZbTtpXwjoz
 kxT2XCG7ey9hhecSIGdeeQCXIA8AJUPgUCNKsY7KVXH2IZoiZXsmKPeISidCR2w+09Blmru
 EhLZKaToTw82LCRw/1rAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7g+IXpBfIes=;vV1mwjTAsp0spu1sNAsJeiUMhUw
 BXfJnFymjL8hAPxg8HmL4maYTDFGrD98M8lm+joJCnfbsFhuVvWKiNka9DoUsCHjttSR4i7cK
 rVC0dn8gi0qHf7J799uADvmaxS9W/zvSbDwo5YRGXem1kSkBX01vgiDhmceNj/ksiF6DWV/MY
 pzOTbT/6BBSAUfLZIBoBhjFaCOPxiReOOUN41vwPlzdwcpPMgkNFT1jrHLjJ12q903zSXSFAO
 sbJZCG+JdenqEbqZFW/YUYFrJlmOU8EDprzEjAc9QMDgtPM+hW9R46V3JbBDfvkbzWEU1kKcm
 UuH62oM0QJiu2kg/OUVW6+i18GgKRlBz8woPLDEgqyK6GP3yoBGGp6mI8zne1/1aU+fd75yqn
 IHtx+72hYriOlkkNYm5AKaZoyhM7qbyGzb019/CKgJkYCvWhOaejVcVyKkLl//iyqGzUl0wsq
 q6GDtY/VJLoSgVprnUbPAbrY7TSBHLZ35RNtDEVd3mKD1MaYLnLI1UyICMDqfCIUgGjlW9YZw
 RkCIcGBB7zi+gMxdJkoo7w/eVRWQhtIzEvQZTSsCTwjbZFNyuJjlpdlmA5YuPr6sqkCtv5Hwd
 q+rm8jopfNlTDn7fFxTpktt4GcYCKmKjoQzWdYJEP7Q/b03vihS3XkoYoiTfUrzXoCQrRGtul
 kCpEHJ2OXuugDZtk7fa9Wr84WsfgmUKvMuy12Y6nJybwtCvLN+QrPIQezIVOOdA7p9+8+PMAZ
 gza/Kw1DywvGbqtScFOgQw2GyoAiusA1WTh8gfMkR0kQnfIgKvEfdcdMh4l/nXjfrmB/jP4yl
 z5t9p2fiPmEUN2a5RVpmYmUnn0K3MAHWrAMVHgUHWtCMqz4n5mnWEgxdOXj1TUmb51YwDh/64
 dxmgSIb3Eq3Ka9fvjyD2DAEwR4Ddru4Rut/ATyc8J8h0Ts1dl/Hz9Paxk3sApATFSCgyllBZR
 MD0Ww2o/m2pAldOvZyj8aWZ0YkPWbKwZEf5XApQuggDz4qmtD8sPy6zdTyxfaUdDQmtjK74lv
 kkAmODB13k1l7X/iLke0oQhbPXXt1p4H8PyDP/mbo28A+5qTVg6Bn0LMhWiZV8NR+G47tFOcs
 1wKzlo73TlpVLqvFdZeNjq6ilyk5+F

Hi!

On 1/7/2025 3:39 PM, Sebastian Andrzej Siewior wrote:
> On 2024-12-20 14:18:43 [+0100], Florian Paul Schmidt wrote:

[...]

> The backtrace appears long but everything up to folios_put_refs()
> appears preemtible. Then there is the interrupt handler. This looks
> okay.

That was my impression as well. Nothing really surprising (at least for
my limited knowledge in these matters.)

> Based on this trace, I don't see a section which disables preemption/
> interrupts and be the reason for the interrupt happening.
>
> One thing that could delay your doing are small caches.
> Then there is looking within the system: An inaccurate/ low resolution
> clocksource and/ or timer device.

I will look into these. Thanks for the pointers!

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

