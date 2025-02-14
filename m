Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B0158D96
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521880; cv=none; b=EfoD1JCZgDxid0nWqIker49W0K78y7a4xV7EgMc5Vh3bfSgzFuiqfnRIKgJJe71fi33UeQ7TiPKx5HkbAx7w64ufaFZNiPNYzCVMKRwPe2l98yZyruJVLMFR1zqaPTP8RU7+9L6i5LWlvfYgJEQNBPhLs50nm4MYhvyYvrnI3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521880; c=relaxed/simple;
	bh=eO4Bk7I90p13jDEg+bRzlejuywJhv/YX7ruio5ufsMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5KUxYYYuP3Zk+MEOEp0psRoS6fnr/3V71Hjzvz+SAdiIqNMHOYiaTIRRUsM/yf2PLkR9yAPfJbFsFbGBfOIhhOTdDIH0ItW/l6sk4oVEUIsQmAzsedKMqMGF9HWU16wlWIpLNfmRMTwabeC0eOgKIVfX8L2BIoMTHT8E5qd2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=g3g5lC24; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="g3g5lC24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739521874; x=1740126674; i=mista.tapas@gmx.net;
	bh=NtzYNVIJ5vRrvr4TpwN/VgEPM0wbmlQzxQ1EZE+OQIA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g3g5lC24u//nFe5V2eSQ9/aPSIIouIOa7SVpDOUeXy4WJw3Q+xD6aOYPoe+B61c9
	 U0xQHIVVp7qQSTCNRZ5ex+Cbf05ZW29NMKFI59VxyltAxmeeXK4rXBt3ds4RB4AIA
	 is6UWxrAbUyGaYdJBLdIi+F7EScrYGXy3SXEyqqBrw1HQJgep4nf+U+Mmq/hAisA4
	 II8ExjKiCENue8puwYfs7c9pgL8SHZ/QdRM3N2m1b8mCDpEOHvgKnjDevd5kZQuA8
	 +67TlZrWukDo9uQr3R8WnC2NoOkdiAwiW8uwmuPyB6yTNwyenZDrd3O/PQ/L1rydy
	 wOtvKrDkGEbP25Gbkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1tUsgS0MhG-015Jiw; Fri, 14
 Feb 2025 09:31:14 +0100
Message-ID: <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
Date: Fri, 14 Feb 2025 09:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: Mike Galbraith <efault@gmx.de>, Leon Woestenberg <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
 <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xAM53x6C3JrHfjws/h6nmf8OfG0Tuat6qFjjfNwcYxPCREXS2bJ
 XYmGdXE52kpCWZGrvZlDsVN7gJKoC49Z8QoQzdclPOHl6HXfVOy5FYV5jm7AC2bA2O128VI
 0CaOfs0au7zI3wpqc+TIp/BVvQzB9VangdFtdCt8xXBaUOtuaj57IPtuHbm7Nq2HUdgN84W
 l3+9/URHexyxC5F3I+RuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+q7cUH7fWwA=;DI+GpUg6kOImVoyNyFKtOHtbRdk
 4sop0akGk+JF6H9XsDWHFRO9JeHFAmYFHC8rd4GP22JiUYn+aX/RVuUYDYTrihQANdItKy/58
 nRdvGDb1Zs/AzVA7DH3roANXi/c309kOqJpPMLkJp0xCQ8hZjS91tBvh69mpuX3V1ofng2JGo
 ah/Qg/sJ2l/1f5dxG9WTdVZHcRBKCmkIvLVK12h8in5sGl+WQA2RSexz3HIkZipF9TxXxkdce
 4Z3ntHwzvGimaxUopLqxY8JfWGVXrubOiQmLFu97vd9HPuD0gl6R5x/xMxjHHZFbo+ePyzctR
 eAI+3AUFWsMxALxexE9fd7iWAH90LYCk0gvtZ5pFxPeTO22dFBSUY6bmzC2KnuHMDh333A4a3
 38el9zzPkYLT/yImJb3vPAqsApifagQFBmM1cK07o7PNnD7ef/1SLN03mHby547dnVQc8uWEE
 yWY9Yz/r7VJNWSaIHpg814M5u9hRUVyEXogo9ueNGtkg/AoMZ75OCwIhzK3RX2ztEb7s4NKvB
 Z7SO9wNQEGiQQbDYTb7slqYuughhBZaPzNzeJr/4T8wpCbugUSq9LZyJvKaKfWXTUwp4BdWn2
 omJoOccL4PlsrkpDyUB68OfriucDtCxMK7QZB9XQLM5GoN22b2UF7CFatjVTjM05XaiZHkh9E
 5fOUAwcTFll0+zRVyZwKYmRLTpHZwZxeaTXYt3wUR8NgF7tOffHX6s8AsZ13LAREEx/IT4HZF
 9D3MrLfdeKPZSb3eEjDiI+yUfVsmXY6ncPAV8YZoFxrzT1A3n0CDhCcKv80zDBUiPpuADwE1h
 GDCn8BP3W0tUPSwE3kuG2vY82klUDSotbm9H0xwDBvjX7WK6tu3Gr2ag09dUM9bD3778XhTnP
 ueYSxUQv2Na5JVcsgWRXPWvq2z1hIYL2Sq20iayikdMnxX8HHfY5Cp3gauxTx1bqmzx415cHz
 2D4g9VuF6PnRc9x0JPFDf1CcdQzndNhtfcnC0U0eYf7jOZdxXdIyB1IV/5Bx+g8DJIn7T2BKM
 6viBnF2JuwJqA0SzNufWHLiDJmlPWpMh6ciAyJBOZAtXAZx7zT3cBw4xND5hl8KIVX42IjS1f
 /s+kZYUn5b/vfnXIAp3Yj3W0LnLIs8M8v8mHEqxqaCJOw24qQr2j9hkt8EWaCIzBvHkK73Ofy
 m1hRQpS4tF8EhBVDEw9WUlAMVg8t0d1+8tRzPcmTt6MX1oOAovimokfBS+Odyj3QrCsTjnMep
 DtC7rMAHpVx6966I81XIRbFczsBpGUnGXTHwyvjUOmSpKteJdWfg2Kc/Zxr6FvgwIunmKsiK0
 9uryJZD6CzAoHocS2iq9wbbIZSJdqzVNolaRVZKujbDlqRNd6/f4eaVBcoOH+YyT/ZyxttVfF
 umIlPZKAwbtXvSA6kfAsE9jMLgy/sb8yEzNQuYlhwpgTqdXbf49oWndd+8dzvSyZ/wJZAby7J
 YCG01jQ==

Hi again!

On 1/14/2025 11:28 AM, Mike Galbraith wrote:

[...]

> This seems rather odd, one core diddling memory is the worst case.  Any
> arm experts out there know why that would be?
>
> pi5, locked at 2.4GHz:
>
> taskset -c 3 stress -m 1 --vm-bytes 1G --vm-stride 16 --vm-keep --timeou=
t 60s;killall cyclictest
>
> T: 0 (23157) P:99 I:1000 C:  63421 Min:      1 Act:   12 Avg:   27 Max: =
   1378
> T: 1 (23158) P:99 I:1500 C:  42327 Min:      1 Act:   32 Avg:   29 Max: =
   1734
> T: 2 (23159) P:99 I:2000 C:  31744 Min:      1 Act:   18 Avg:   28 Max: =
   1353
> T: 3 (23160) P:99 I:2500 C:  25393 Min:      1 Act:   11 Avg:    6 Max: =
     39
>
> With all cores diddling ram, things are far from lovely, but cyclictest
> wakeup latency improves drastically.  As you increase the number of
> diddlers 1 -> 4, the latency numbers improve until you get all the way
> up to.. merely awful.
>
> stress -m 4 --vm-bytes 1G --vm-stride 16 --vm-keep --timeout 60s;killall=
 cyclictest
>
> T: 0 (23276) P:99 I:1000 C:  62706 Min:      1 Act:   49 Avg:   48 Max: =
    220
> T: 1 (23277) P:99 I:1500 C:  41800 Min:      1 Act:   53 Avg:   62 Max: =
    274
> T: 2 (23278) P:99 I:2000 C:  31348 Min:      1 Act:   45 Avg:   65 Max: =
    302
> T: 3 (23279) P:99 I:2500 C:  25077 Min:      1 Act:   32 Avg:   54 Max: =
    175

[...]

I wonder if there is still a way to save the day, i.e. use the RPI5 as a
somewhat capable RT-system by

1. making sure that the RT load does not do anything nasty - this is
mostly under the users' control since they can setup their RT load to
not do this.

2. preventing other tasks on the system from trashing the memory bus.
These are not under direct control by the users if they wish to run a
general purpose Linux system besides the RT load.

Is there any mechanism in the Linux kernel to achieve 2.? This would
probably come with significant slowdown of the non-RT tasks, but that
would be acceptable at least for me.

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

