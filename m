Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="FfBJ/FB7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55695
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 04:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702384928; x=1702989728; i=efault@gmx.de;
	bh=goBhFucCfUZlzvMgRm9Ad/rfqb+5k/jPzPFomuBjX/U=;
	h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
	b=FfBJ/FB7kzLHK24zv5qLmHBShXZ5KSfHBpNdoMfW2EIRe4hvp7foSt1D3ngSLXSx
	 dZx48152F3SaLAc7H0723mn0f2tLLDJGGMqQ03ljSZ1F9ftCXUml/NBw8A+Z+BVeK
	 E/vSKXnZ89RJtwKNDXuWigUvEK0Cwon+kpRz7++kJcDDkMG/kr5kPgkKa6Y54jHyh
	 E646z8OUPlkja7lpx92RhfuubDtsS22EHudHB/MP/LkNVZW7YoPH+KP0v61TaoyhB
	 8GGg/XD6PY2F1JeHRlnISxonnlTsD8EzRiF5ij1BjoJorWY8p4p9nswArRvUqrD3u
	 OMn6bSiLhs/mUOR03A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.35]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1r24mu3OzQ-00B7PG; Tue, 12
 Dec 2023 13:42:08 +0100
Message-ID: <da41b939c1f2bbc9735250301ba3c4e735dfb313.camel@gmx.de>
Subject: Re: i2c jitter is worse in PREEMPT_RT kernel than stock Raspberry
 Pi kernel
From: Mike Galbraith <efault@gmx.de>
To: mfranklin@comfiletech.com, linux-rt-users@vger.kernel.org
Date: Tue, 12 Dec 2023 13:42:08 +0100
In-Reply-To: <44fb3d4d-6303-4287-b2ac-7898cc237c47@comfiletech.com>
References: <44fb3d4d-6303-4287-b2ac-7898cc237c47@comfiletech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h0RPt3rsv2d9FN6UAAimhuSV5lJtteYsIlv2uVTdIMPw/WA4c1/
 wfEQbu6lmVBrcgWw4DMzAxL3giXLuddelN2XGc9EfryX+JKljCg/QtexfTAmasZJhqOzEme
 2y76JfiAMs0W0SAEXv0W5/U4mi/ckdoK6LszUE3yzfXfnIepN7djd6JXwAI/Pev5vuw33Wx
 2t2ppK64Hf5Ef+OM9rQrA==
UI-OutboundReport: notjunk:1;M01:P0:4MvgCOQxybs=;q/UjmQP9CapEqe5Bfm0qnPzvYoK
 4Hv6BnR82Ml0jV2MBejMvp7ia9VC3nG+EzNfVFpunOU/Hz97kkyz5iETMn0HxWFpidOjwv41e
 cRI4Hvj2CAXcQLwvwkhsoUimdcppgglLzGOr6iZkBydoWYD8N4lGRZdU3f+TbYoU9zLEEtzZt
 7lmnj7JR5irxPOZQTlC/7610k1O1es2dkzDCY67nCZmuDRokWi9JTrsG/pqG5dV/SZOJToPEw
 QwId2DFHTeipHMiWzr3osKxd77H/uK9HHW7cFcu2gxCJlgKPOpeF74MxUdenMeYClIAsefmJV
 6S8Ln1Sdaf1sYTB/ZhpE4UiV6/szqtzah9TbLItIbD4BBubr78F04dS3CpvOJUv29CkgjrNDH
 Iny2nFYloDIvtWuwRYjVnDfnEOrihGODqYLU0D1GQpTQrU581SFaEOAgLVpEzMdr+0zWaoCtu
 CWHXzwBqT7fqwxQRTBWQTVxA05jZiwoyxxa8cwrA7qlSvX6X9TPfbdXxVb4cRKhAreVd3g29u
 x6wLh5emnUa/Aq3TXs77cjZguQy3GpLfe6RSmYJU+FpuDvZh4GGRTXooUYahToIcf4KgfJJ01
 8Y+Ol19eVJgVfJ1wz5Xzrbo93PciaSAmyfaKWlnQBZqa754bzRbpJpbkxM4kVu81YkMZxcluc
 ySQcggPG5ApKJ8K/a7diXosfr+/bXNnTw/Y+ILpjfUmYJCrbMFRJBka4CnJURsrRHi5LYhFto
 I2/kc5bJGGdzRvdvuPBwITOkYORG55MzIhg/fYKTO3i8i2/M2FNy3pR6UT+DEwgT23c+8po15
 H7l0eau6SDpoVL0sSzJoDa0lDPG1FPSRu0SE1G4yxKo/6Yuk3nSCG9PK79ixZPzGtcgdjSXyF
 nOCOYXqKlLSvGG3uToCBtBu6yOKtYFu0QN/cKX18DyW6jbgNbUXl3sGKOpdrlm7vz1MQZgtZ3
 V1xyNw==

On Tue, 2023-12-12 at 11:53 +0900, Michael Franklin wrote:
> Hello,

Greetings,


<snip proggy etc>


> Interestingly, in the stock kernel, `htop` shows that most CPU activity
> is concentrated on core 3 (which is what I expected and preferred),
> while in the realtime kernel, the CPU activity is distributed across all
> cores, despite booting with `isolcpus=3D3` and running the test program
> with `task set -cp 3 $(pidof i2ctest)` in both kernels.
>
> Q1:=C2=A0 Why is i2c communication is more jittery in the realtime kerne=
l
> than the stock kernel?

I'd speculate it's primarily due to threaded IRQ handling being both
more expensive and preemptible.

> Q2:=C2=A0 Why is activity distributed across all cores in the realtime
> kernel, but more concentrated on core 3 in the stock kernel?

I don't see that.  Using isolcpus or not, the test proggy wakes only on
CPU3 (as it had damn well better), and box wide affinity i2c IRQ thread
wakes on CPU0.

Booting the non-rt kernel with 'threadirqs' behaves the same, and I
suspect will jitter about the same should you try it.  You're isolating
the test proggy, but for the rt kernel the IRQ thread is left dangling
in the breeze to be perturbed by other IRQ threads or whatnot.

	-Mike
