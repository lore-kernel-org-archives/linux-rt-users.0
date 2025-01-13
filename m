Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9A16EC19
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773032; cv=none; b=WFDGBm7j3o4u3xag2sSBhjYVvXtaguGZgw0Lg2tfnnyqbRKRVW0hsL7315WCe5MyqKLDSB0EmQkfIyXcr/DpTBmvL0PdSqOrhdmm/en/eqIfNynmHNwNdyilVdS8pSmCypawEZgjUT9gw6P/0CoQWUA+sLxcZZHIFheVDafNQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773032; c=relaxed/simple;
	bh=iwtpZhongI9pviMWG+1fafGhvKwB+nvFJkYFOmQjrzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djO9i9I4JjfnkN6dLrMcyHK8O1UqMnc2Y1rrzLAyxtoiXLZkejlSg6RdheBEBDrKPJPblR0H9gDyfXPdwpp/zNR0MXtgBGueuIA3ZbIQ8tVUJB55AbsM7bQZ+cxRghGfeNfagYa3UtlpMeYOfkZLnwpmKtb35imprVm4SqqUWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=ciKL7rvd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="ciKL7rvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736773018; x=1737377818; i=mista.tapas@gmx.net;
	bh=iwtpZhongI9pviMWG+1fafGhvKwB+nvFJkYFOmQjrzA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ciKL7rvdRsa/kOej74Ta8IljYbS4SRkbAyNwF0xpYF2veoVlU8C/eMdM8o0yzyd/
	 DWcpYqWnQvpm8ftaDXQ1OU9U6MXjk5AGSfPoXds8OknjPaP47IeZZohd61oahUgC1
	 1bAsynhbuq1oBoFT3jeq/i2U2dHKN70Abxj7noyX3ctLPb7coh2GlsVYKqa1Njf+C
	 KdMDZzB7shR6EJdJSFuA0xfv701n1pVC1hjy4ZdXFJww6WoAhVeQY4BIC2iYuhCLJ
	 5+7FUVs2a7nGDNmAZAbN5gB+8QI/+7DFljADUmBNUXJT8A9CCFIX5/tqjYoMg2tIZ
	 ZBcW/PJFp84z3RPMWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1t0S5S2TH6-00pA4z; Mon, 13
 Jan 2025 13:56:58 +0100
Message-ID: <0176e5d7-4674-4f25-8442-7052aa1ddfbd@gmx.net>
Date: Mon, 13 Jan 2025 13:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
 <84frlnsosm.fsf@jogness.linutronix.de>
 <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
 <84ikqjdl7y.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <84ikqjdl7y.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f6qx6VzkNyHRKi2oidv1HWABHiEnhSrdpLwZOnJxX/NMDvqdPIo
 RtIoe6nuIfA71uWcELdg3Q72DTAbG9nZde0TpzTy4NHCrbJ1D1MpWKSLrkYUWYdN+tOwqjQ
 ub57wPz5TdPHMc+6eCREMVbckohCUmJgNB3lqu/0+hl7Z/kl8UbS0/3SqKl22CUxF/O7hZ4
 NVqXAJHCt5UdRb5ahLwPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ZagFBmU6V4=;auO8U8/aYuvBZx3gDFaeJy/dOta
 UR7ks3jiUl1+ezeim90D3qGqfCW+0H6z8I6f9crDGVO53qXDW8/7i0GSjVNPd3j0aM2fug+am
 P4AJsuK50L64AaWvyq84MMC5QxOaga20Ihcir4gLcoGWnE3E6L1u+JsEA63X9QMSRgrLiM6hg
 MfhGQCx0G1P4Aw5zULAAY1QVfAYhvlJLbwszrm0V4T8AoCYYF0xdQswWJBuPsiZnsY0nFFJS4
 BR9FjAptlFNm0PyLHTZbCIcmnlE0ynCNkx33D7ak/0d3GnUezH1CW5KnzgZ0/bop8jeQvVR3t
 RiZos8JtFZxihhATAgwMXiGIC2Y6w4ZZH/c1ZNurLnLn64VSXyOte+ZhqRvcQDsTJ/CXnO1L2
 1oOta6roafH7MrIHyfHGeZjrc1X5wexeTyO7KL18UsdwqnXYqUVsBRSB+Icrs5GOu+TukMIYd
 kXImG4NkIFiw1OIUWinZXZ5uRi/JnkPx78FlIcYgcJBiF7vHfXt+hHsbIp2ZNaFJAFoEk6HcN
 7HXV/vCsNiI19N1ZzVWCTSp3b5BvZpqtQ6VvSvxi7D7C3pcsnAnz2ulVCIVFA3mxwmXW7HDSa
 3FmruY/AFeQGudegTzSORgauaW+uVIi5aTFzAQbLETcMXG48i3gaJGKCfrNFIq0e27WrsSv2s
 CVHu5QwxslTZdttm2WzWR0AAYL+2bxPxK+JrTF2wDwoQ5/LRfxbtyhZv5Jof9ItyiLpTI8Bwu
 IG4bZ3YqkSCUGYs1KV/1pbCYtuuZ3zE0tbpHqIhxNkiITVRk1GAFC1iHeBn0h5oRjv8mRhkfM
 k4LBwPJ/K3RqcNyZBkGHsn2JYIgflkFxhiuKWOPUVA73vusKXbQa1zmsBLlxynJFo4miVmoVe
 Re804p/IVU9djgX5qeoU71iqNf3x4VGZDJM7n0uc3pw5Z/MYf/7J7bRnK7FdbH8hzd7HC6cQg
 wALQ8cYeHtVsZX2GL5jsFHCpGl7ROXr7MaktoXz2i09wx35VWAOABjCzdBGUdgRBEY3gKwaz2
 7vmVFufp7p4ptMXChP1YABvlBAvYTH0B93qoocBriNG8L+ERDCqwyeWU/6VZxoidNPZjDDO7D
 n5OHFj/+rRXLsJZngJ0YZCG61WVc2B

On 1/13/2025 12:09 PM, John Ogness wrote:
[...]
>> Yeah, I see the same behaviour with this way of running the test: The
>> core with the stressor on it shows small latencies and the other huge
>> ones. The effect disappears once I run two or more stressors, e.g.
>>
>> taskset 0x4 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -=
c 1
>>
>> and
>>
>> taskset 0x8 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -=
c 1
>>
>> Then all cores show huge latencies.
>
> To me this looks like memory bus contention. I would expect you could
> reproduce the same behavior with bare metal software.
>
> Someone with some experience with this platform would need to speak
> up. The usefulness of my casual responses has come to an end. ;-)

Your input is nonetheless very much appreciated :) Also the peculiar
dependence on the stride parameter which has an effect on what memory
banks are touched in what order and with what timing points in this
direction IMHO.

Another datapoint: When I set the cpu speed to 1.5 Ghz instead of 2.4 by
way of cpufreq-set -g powersave the effect is greatly diminshed which
also points into the contention direction.

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

