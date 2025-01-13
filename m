Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E2233121
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759747; cv=none; b=RP6nzthroSHsJO+8VChQwHz5oI/TNQ/WfnZfgKhMp0lF/xRFvjFEzsYJUX9JN9dTxCKQu5AxGrEXcsmXXUIfooCxxEAmHPYfm2FAL1z+P5TqDLnFO7PERD+HttmjvvuYnuVuK9cl46Cmw4wiSmKRcdyGHoU2T89LdeqiOriOouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759747; c=relaxed/simple;
	bh=5AMxfSl6sqWP1gGG+X3l0NrayGkwngnYOlHQKEU38C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnZ0NwqH840GVlGJGTZbits1QsRGTMgwUcJWUoSmP1tRHPsYBuhZaL2zOR1YwKH+AgpXOHPSQxx4MeCH3Ru9cAMwfiD8+d6Tz9ewfiV0s4cV8orbApc+SRahR0t0kYccSIUp0GxIqjudQ80sWSFyU9ZvC9qoFvujLUaPwo8c294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=VzhKaBHr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="VzhKaBHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736759742; x=1737364542; i=mista.tapas@gmx.net;
	bh=AifAfDkfnyQJ0Yao8kDDyxBIFjRz6lBGfoWx69CMCks=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VzhKaBHr9WF1iNJPiSG3ETDsVt2uFHMiBpEABPQy2tOwKt6AxLzaxrOrt51haCyh
	 P5ydKQtEqvqYaqrLMlZrENYtPkRDu8zD13S2qrCupuCNfvUFVa23wemtEIOdJvLPM
	 okTrseu9bFSqJod0XaLblkw+GTD7nMPrJk0aIajhDZX5EUUR6leM4NwEHF6ckzsM1
	 /CJ4q6Gbxj+k49NvY6MsaAomJ9U7p79EtNu1+5bmI3/YgxoaRiYVFfDJRRWuB/4PU
	 TwaMcS6moXrJK9Yl6Nhj+p7KapjHA7XmiTZisfcrFcqeivnQZL4bSyadBkIJpmsP3
	 /fHcdA9PkR2uXU2KVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1tSwzn11Ob-015JOw; Mon, 13
 Jan 2025 10:15:42 +0100
Message-ID: <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
Date: Mon, 13 Jan 2025 10:15:41 +0100
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
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <84frlnsosm.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rHcqTECL7Al2Ae5YajOpLZPoHveTEMpmjVFL6FblfHW8DhKr5cg
 0KdBracIVBTJoSc7Lhs9RBLVQNS152eykkReMcSp8gYipYtPXkHOTFi3Hrx7kKjbTSVvdRR
 TusYJUIv1GHIj/81cTaOqIK2fMq/ynuA7IO5KaMFfzdtLoVSbDt8QQf5CpYcmLGkZR/oC+n
 eucivpKbXPJMZJh2A8TYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JNENNnYh0j8=;jHEzS3dr4984Q9L3QbOYvRcN336
 jZaiut8z5G67Rxz0lKodL1zJniVsSk3+f4QQ9tIZSUYinPu7X3ZdQmZtwWilZpPRbUDzWj+fn
 sMfeGLvcFz41lO9pH8ik3EMwImyCuTTP6qwttccfwyOFXZJLCUDVjU8MVyUoEym9w1DG9Sdqs
 cOcfy7G1MIMbO63fbkdcdG0qthdib47V7/O6rI7A385L9BIvTdeltgaF0JIYuOKuaVkmfRWEX
 52HyB+jqvCtEbHaXmQLVmuCjx0Bckbbj6HVzFgS3RN2KaB0SWMEmAjGyI3b/KImqMSTkCm2sf
 muOYCMpWRWZZqmEKiEgwxKMtfYXPij8e5uEFu1iOBbV8n9lFiCNdL5JfE39e9a8Y5ZOSLk7VB
 8ajNm0Osp4hPlK5yQ8cyI9Esa9xuWYi2YfINDVdkJ0ceoFF0nHkrr0upAEOr7j3oTq3dW+FLd
 DH+89speh+HFeCXFbExhtGiiNIcvxxpbTB5/fXL6GXj0Fm3FHp81tcOtXaXYi+vyXBJOF2xoc
 e49Wv+dDxWIm1y2+rd1/5lUy6tYdveCzRZ12UnPdBR65bhfCtNEvVeCiaBt6FGuBY82UH/AuX
 0ngifQN2JAlMpZrvpIq1GEz2Ah606WcJLk/PeqY5ALeE2Mb+mumdUDb2MWJE2KJ2+1nKwxsPa
 9nDMOjWKybCqZd0zkmh6MorRPL++ewmVZJDMVDP9+wcTaaxcuPTBkXGVsSyZpLdHd0f5qLCB6
 dyze5XTjPjdDXAY5cyrA1Ohe8y8eLszv+bmVAwAX9Idzfwes086Dcgc8kj9t69t/+T/5WNX5b
 fqpNGT06E0bWOxM2uR9GyqCBenhSFRaAYktUR0YsUOYfA06frQsuJFCv3JvHVJ8v/WF7ZM9iq
 0i7aeEhOjaEgs7XfEzB+rnCTlA44rO4/SkLSZx1Tzomr2Knpa4iD7v3kVuLajszztHR5/mCVf
 KjGxYny0S7WV25B6KJWfoerTQM0Xcx4wJY+Q4p2KMH/P7H38vGCbdAfhDNa1HwAyn8lP7Q5/6
 tPuviqtBy9808a0+ry5HzmgP/OyFJ1QKiO8R4XA1F1WBnTz5r8ocr9VhIpVc6PIJrQmQBE5k8
 vP6KdVH9s2LPAlO0/x7yUTM2A2uXIR

On 1/12/2025 10:30 PM, John Ogness wrote:
> On 2025-01-12, Florian Paul Schmidt <mista.tapas@gmx.net> wrote:

[...]

>> T: 0 (139313) P:95 I:1000 C:   5881 Min:      2 Act:    3 Avg:    3 Max=
:      10
>> T: 1 (139314) P:95 I:1500 C:   3920 Min:      1 Act:    1 Avg:    7 Max=
:     419
>> T: 2 (139315) P:95 I:2000 C:   2940 Min:      1 Act:    1 Avg:    7 Max=
:     480
>> T: 3 (139316) P:95 I:2500 C:   2352 Min:      1 Act:    1 Avg:    9 Max=
:     433
>
> Notice the average is considerably higher on the "idle" CPUs. Perhaps
> you have cpufreq scaling enabled?

I don't think so. Cores are pinned at 2.4 Ghz by way of cpufreq-set -g
performance.

> Are you running these tests using the OSADL kernel?

No, that is going to be the next thing I'll try. Sadly something's up
with the generated patch script. The kernel directory resulting from
running it is missing the top-level Kconfig. There's a hunk in the
monsterpatch that deletes it:

Index: linux-6.1.66-rt19-v8-16k/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-6.1.66-rt19-v8-16k.orig/Kconfig
+++ /dev/null
[...]

Lines 246845 and following.

Why? :)

The kernel I am running is:

$ uname -a
Linux ogfx5 6.13.0-rc6-v8-rt2+ #1 SMP PREEMPT_RT Thu Jan  9 17:07:08 CET
2025 aarch64 GNU/Linux

I also get similar results with 6.13.0-rc3 but compiled with 16k pages
and for the pi 5 architecture.

> I assume you see the same effect when running stress(1) pinned to CPU1?
> ... just to be sure the boot CPU is not somehow special. (No need to
> boot with isolcpus since the machine is otherwise idle anyway.)
>
> taskset 0x2 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c=
 1
>
> sudo cyclictest -m -p 95 -a 1,2,3 -t 3

Yeah, I see the same behaviour with this way of running the test: The
core with the stressor on it shows small latencies and the other huge
ones. The effect disappears once I run two or more stressors, e.g.

taskset 0x4 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1

and

taskset 0x8 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1

Then all cores show huge latencies.

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

