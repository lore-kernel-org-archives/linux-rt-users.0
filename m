Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8841CAAC
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710252; cv=none; b=hrL1nb+eOQ/Smd1tkFWBQD6UbAqybU11YJn1q+FRLvKpVo4Qtyvypk3nO7UoRrfbnsVi2ieMjYcMrhwVhxmagbG5mQVK9imSK0JO4MI5IcMyeg4do7dbQ8xiE8x61A4ciAPdM+e8R/lz134T4/QH/yUt9M9q03bkMwmBu979MmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710252; c=relaxed/simple;
	bh=43t1bqnXETdo3ldL7mm2GkeHyOC01D7GL30uSY6+n98=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KZzOVyEdbmkrE6oqyiBrLnfJqBICr1k2liJOe+jI7qMEKqF8Bu2Mr5SPSA6kYOHzAt3VZEP+Y0OEO3P7enZg8dAivohXAOpdEs/FkYP1pvqidZMNg1BRDNrzFdc47Oszx1uJHaLRx/dsVD+f2R96NcqBnXkKULk2+8WCkKU6dkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=XuNMdOGB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="XuNMdOGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1734710247; x=1735315047; i=mista.tapas@gmx.net;
	bh=43t1bqnXETdo3ldL7mm2GkeHyOC01D7GL30uSY6+n98=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XuNMdOGBS4U8dPy/d299yYN8BRwNFHdkIqXZGoNejgmg0xmxGISuBrwc4bJEYIoc
	 Tm3/ruB/2hQRS/sVWaMHqIKHlDJ8hnCr/89gu0E/D62B719Dd/tPKbLXPNQDGyUDL
	 LfNwiz2BJDePBWneRSjedCmcQgHwUU1AdlTTS0ITMQSgkgcMnbbna5wg4tkYxkJlM
	 vAjT4eSzglR2fRXi0tfrqx0Orv+ppBRZ0VVyg0IMS381Xo9FxhZwahADTDrFxhBhd
	 vlIR8ECuY7ss5L9naFIXArYHv2jCfMRGoNLzWpKh6vtqzF+fkyY1uNOpsHzO+6f4m
	 yXYeUqlzQ3LCWH0fbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.136] ([92.39.22.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1tDS1e0wpN-00Nedv; Fri, 20
 Dec 2024 16:57:27 +0100
Message-ID: <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
Date: Fri, 20 Dec 2024 16:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <84bjx6h2kd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iTs5YgUqHamNMSAJtNKrWVWaNVwUq0V6EQQQ1VMdNdgTnrNlOPH
 gPQ0xO3U1lmhM5+xDsFPIjFLtJ4VCHm8Uq06x/cwUHLDiTy+cVK5xJAj6os6mHJDgJ/p+fY
 xo7I2hMnhWY+ikl/kgOt/zCVhLNqQ/iSMSa4NHM0+jGiGwqBILCXLUhU21o8792WzpGN+S2
 3PzWOpZzVJ/iwEXQkK65w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NtksWbEf7q4=;4g4yM1QvjdW+yGyNhAcKyor67MJ
 UncjSHgf6so65e8vgxyRe80eMzYS6JdRGuf65A4iRGlGa3lDpwOqF4qy95tj5Ha92efGaohp5
 5iKNzME9AFtkTLKPdeom2/hdNXrpBjviTfuQLQDC/UmZ2nb3wNIJ8JjBs5ffkz+TmSffGFEbs
 jvtilHYhEVOU3k1Ku0lT+6Zb0QD4/rEw0ebHBguYZHLmEBGd6l8QQwgdxW5WL70By5M7WpcZ/
 yA+/JPXaPmOS82BBtT6tS0mBnnIXYyhTIfmiD+b9YjWmjmim5JiXHCbqq5ynQn0lO9ybee9r2
 96o+flUx3n1EjgNdMvLXOeu0OYUXRyDCQBvl3i/n93zko5kUh03Ktxk1xf5TwamRHT1ambOb3
 HOcdFQoUG1GeoP7cX+EuFLC2FCqvrq6IizAQNifUp3T8U8MQOT2zYeZUnjN2aD39ks0wsxbCB
 DTQuS2IYrqSPJM3STEC7SenEkVOdXujHisgH9owLm+nn57mBBQxLQlttYfI5gq8QIv2YgefBe
 P7yfxEyMuZ8I6gECsr9iFAeyeg83skxCuj8hnXIZmoupgl7aMR+c+hWDJa0n2PRSLEdEYRhVb
 nC2S+ITIvaadQ938uMzDliOicLeIAa9O6z9lXEDmTWXqU6jmBEXwpyAr/mFw+JrjlR3z07FWe
 AXn+g/tqIBvi8QQGjS26pCHQpK5RwaYQgj94siQ3NIwvlKgwZvfgNnLpSM0GlKNs6Oozbzikr
 sSFmhSP6yR78edaHjmZuOcS+/3gbzPFVFz6QULd5papYWUO+NsLQijqLEkTFJXSU5IJUFXGc3
 i8JYHYyHZvZ/ydumE8RR9ovaU3FJ2+JCXPCidp481QJs/GsTs8ztlyLqsvcuMSh+0x0aSbmYp
 kygp913zWPa2Oriqjo2GvuTxCoo9nmKqMXiPI5EZfqKLUXI0FZBKKLHp9k8xGO0H+cLv8k4yq
 UaCaoPARC9yrGOBAVeZLUCeOAgm5pK0r8iq2Shnq9JocXEXk+XXwfx5p8ZoxhZV+AUJ3qRQwU
 fp6W0+TNMvqrvymPuedSJqqGyIxE9d7Qk/4eSXMLBsY/XXFGabhTmnS1wnt2DvgT+d/pnS3un
 ortciHXNv+Vj3vTgXumFjiAAqgRlCh

Hi John! Sorry, forgot to hit "reply all". So here it goes again :)
With a little clarification as well..

On 20/12/2024 15:05, John Ogness wrote:
> There are various kernel configurations that affect latency. But I am
> curious... Why do you think a maximum latency of 80us on an $80 board is
> large?

Simply because 80 us are an "eternity" =F0=9F=98=89 That's like 192000 cyc=
les at
2.4Ghz. And also because other slow systems (like that Celeron j4125
board I have) behave much better even at similar clock speeds (EDIT:
IIRC). I don't think the price point has anything to do with it really.

EDIT: Don't get me wrong though. 80 us are OK for my use case (audio
processing) - I just wonder if it might be even better.

> What maximum latencies are you expecting? And why do you think it
> is not "under control"?

I would _wish_ for latencies in the low tens of microseconds =F0=9F=99=82 =
I do
not expect anything.

Kind regards,
FPS

