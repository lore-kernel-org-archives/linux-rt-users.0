Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B691B87F8
	for <linux-rt-users@vger.kernel.org>; Sun, 12 Jan 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736694896; cv=none; b=L69T8Q7irVfunargCegzDVk5dVNJ6cuXEMZ2L/M1H+BvWn0cxCDdru4ZVR13oq0GoWxvFzqvq6KfJL2ZHCvZiepKEOpKFjNbGTDKQnVo5KZPWqt0+LEtjJ/N9T7URF+ErsLZbwxj2LohoiFLGkcG68TUxA312IechOOiGf18hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736694896; c=relaxed/simple;
	bh=05NS+q2cKKPbFXHS3YHcE7aEfyduVFyDgHGqB+KbEfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdsVBfbgJfABdaq4zX/MPIXVesOZcGrQKhgbhfr1EPyknGl7mSEqtESp5rnFXiX6uaJ0F/lt/QOH8GZ9iZjCWwxqZj+/jJQdxIt+2mhiLpZ6bo5uptKNSzLvYw5T2A00MalK/6ML64PfvEz40ca27C2ndYTD80LQcMEGKx0MsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=LOZR2RI3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="LOZR2RI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736694882; x=1737299682; i=mista.tapas@gmx.net;
	bh=nEZ4pd+mujP4M/kgW23kpIgqhR+XUoi7JMwhCiZrdnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LOZR2RI39OdR6QkeC+2KorwusN54GX4R3/1/X0p5Px0n0L1+Zwt6NUYjh6GPzT4e
	 ScdarLm9j+up8dy1zDaTqaKc3k1UtXOk1eweVVj+wy31xUbqPSQbs9Wzagrqedrzu
	 s6nkfb96veW5O0dcTsyhSMc37tvl+QKv7stTYC1XnyvenmLsKqCYTQOIJweKAVvgb
	 7KIFyUYe2h8u1PQ+61serbDrfQIkMmvZ6olCF2hSNQkaBkE0H2dumY+dU3Dbl2bhF
	 66cvSR/O/DfkmbZVjDAjnqQjEx7GCBi0Jiux5P4de1tYMxPHLzo5rDb8YZMlccZtm
	 zEJg4bzMpBAiKKmZ5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.136] ([149.50.51.108]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1tUK3n0Mht-017UbR; Sun, 12
 Jan 2025 16:14:42 +0100
Message-ID: <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
Date: Sun, 12 Jan 2025 16:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
To: Leon Woestenberg <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8IlZw24LLyZylqH91sgRMHEHQaHs5oLYmHAIW5YhxXHn6BwUj78
 HLwmwhFzcGb2oka0thc1RDa6NgEet9F4dyuJ8xjg+1aQ/BzECcgAIU83I+6iINHlpQFv4/r
 gsBvDRwtMvTw+woouwljn9Xdn0Y3aBchxt92/JoY/c/J0nv1emgVItmT9iA2JYUugbvdwXN
 QmGhICiJ5ut61LwJJbmjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JC7pXpzxq0g=;pepqf1k/qUwUqYnoHChOjDdoue1
 3c5G2qVCMDPDb3Rq1dkuGoCWruZDHF4aT7NcBcHv+uTYgtp/gwa3lEHNnhUd5jyMcIWDtgPNf
 o8sDvu94t8Im1ImNYOkG0AAVcYC5A/JXyI8RqZxt2YgZOJ9NhLp1SW26o/RmUjBtwrb4EiYhq
 mBD0GY69QFSiuTiezUTvLD6n2/dUrFNNFejKBF4WHVc7//ZU4OW2vuWkYYnn+M3x4dO7Dd+DV
 tGIM0Ro4h/MU96UlpUG2zXhL+s9TSlcrmmfFrDT3zOmp70Vnmv1OCmEX5hedNaO9bv72QoIoj
 ASpeEpnUoGSw/TaB8zXAq6vYouR3gWqHryMHuhnTOCTVZKKGPDC0mcv9/WnLhMlT9JLcbsjSg
 TkXKJIqdF4KDtlonsmMTYzv9rdNRPm61vTHTRp1G78yQeuifPv64V3qqvr914r1oj55tEvb1P
 LRrIjSE9cT8Ae2Ocl2KuZoBKQGIJywUvLcet2W6bTC1GP7yDsGb4yDIcyQQ2tavldXHfKPuba
 hzYdn+BqhDebQwkpmODaZgAIr+7Hm99yZSe0q+cO7X3GUjEvAzPv5MGInaSTZ8SaBG5Re6/hP
 eFH0MTKYX/TDZ0/4lpbcgzpoqhzwWlhOhd3tz2frkBfUatzO8fQB0n4RBfdmFB89WqWgfJOhk
 PVtXq+cO1mhEVKy5uhGk9IwmD/ZQR318FpRCClpmf1CEAbj4D9HTZJ/B/cXU+Pw7nUuqDheLp
 pgm351UAm/VqMpekMJ98HjPw8cPvqTk473fw4UVVqcsNiFpQk8EWNDN+Li4Efx7MBpBo+fCBD
 JqU9EiiH1uR4tzXxoh/Zd2XKrUshgNu7AjojlDA+S6GW+Hi99tkQFVYmUAopWhW9fJ+xj06gg
 WBFkhhG+xkiP+Q2YmxYbzjAUo4UkTYmpIUkb1CvLhYMINQ9ihuidp2c7R5i2WNX0ynWeIW2nJ
 iMpq0ONn7NpWXXX+9BLv0o33yMNnvFwph6pYcZ+3gE9jeiacnqyHv4vZDIjuLnZq1qpPy5eo3
 fcSPHCo1g/AlBu36L71ZjIzSiXPOpJmubz0/73OlpllweWps2XCmqTAVj5EZavP4aEUs0LmgT
 3TLQzJ0JYzCUcWWouWZrq0v1Yzc387

Hi again!

On 22/12/2024 11:32, Leon Woestenberg wrote:
> You could consider using isolated CPU cores, which should give you
> much lower latencies, if you have full control over the application
> logic.

OK, I got around to playing with isolcpus. As a first attempt I added

isolcpus=1,2,3

to my kernel commandline and tried

stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1

and it ran on core 0 maxxing it out. So, all fine and dandy up to
this point. Then I went on to run cyclictest on the isolated core:

sudo cyclictest  -m -p 95 -a 1,2,3 -t 3

But I get enormous latencies:

# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 2.98 3.08 2.95 3/222 134837

T: 0 (134706) P:95 I:1000 C:   4824 Min:      1 Act:    3 Avg:    8 Max:     518
T: 1 (134707) P:95 I:1500 C:   3215 Min:      1 Act:    1 Avg:    8 Max:     566
T: 2 (134708) P:95 I:2000 C:   2411 Min:      1 Act:    1 Avg:    9 Max:     503

Side note: I get these enormous latencies also without cpu
isolation and this particular stress test (albeit with -c 4 and -m 4
- so the stressor running on all cores.) But I would have expected
the core isolation to mitigate this somewhat. Here's the really
surprising thing though. If I run

sudo cyclictest  -m -p 95 -a 0,1,2,3 -t 4

then I get these enormous latencies on cores 1,2 and 3 but not on
core 0:

# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 2.50 2.83 2.88 3/223 139478

T: 0 (139313) P:95 I:1000 C:   5881 Min:      2 Act:    3 Avg:    3 Max:      10
T: 1 (139314) P:95 I:1500 C:   3920 Min:      1 Act:    1 Avg:    7 Max:     419
T: 2 (139315) P:95 I:2000 C:   2940 Min:      1 Act:    1 Avg:    7 Max:     480
T: 3 (139316) P:95 I:2500 C:   2352 Min:      1 Act:    1 Avg:    9 Max:     433

And _that_ is really strange from my understanding. What is this
raspberry pi 5 doing? O_o

10 us would be an excellent worst case latency ;)

And here's another strange thing: The latencies depend a lot on the
--vm-stride argument to stress. 16 seems to be the value that maximizes
these latencies. IF I go either to higher (32, 64, ...) or lower (8, 4,
2, 1) values the latencies disappear almost completely.

Now I am more puzzled than before.

Kind regards,
FPS
