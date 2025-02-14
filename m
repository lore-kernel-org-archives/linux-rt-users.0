Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB4211497
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Feb 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523949; cv=none; b=PwE+zpxc9oBe5dg/l7A0E0szpEI4k/w/nEYPPesYxtKC+rZe4mvsCh2R6oc1dtgthgES3jYvVFkdJTzj3R60BGFFsY/kx/GZLdWQ7ZNZMZaUMzasUv1BNxkAqqui8O49yxWxcL0q8jaiOVuw5wCjCocTIU/yptZG+pCpsl/FhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523949; c=relaxed/simple;
	bh=XZIHd/XydJWQ2RWLu4ouSfWJL0phLlb/dDUW7u/zkIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dlWffarCsN4vzdOoZnhCgchWT3qf1a5aDeof6WVhBaug5a/PxAj7zt9GOQq9uODI2OWhoOsQojfhAX95CjKkvv3pS5vA83mPx/IiOP7Aw5DRdAg/ELLfS6hZ5eDXuApxUmfzTDqRTcNhjrlQdvEXVTMeEcrf9PmlhRzwjyFIGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=ugsoGzMY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="ugsoGzMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739523942; x=1740128742; i=efault@gmx.de;
	bh=cckbmQH49aL0KpdTZEvgJ0e1gc2iLuHTsigDeO6YBRc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ugsoGzMYsCnBcE2D3ia7FLpWS8DVtuYvvPqao+CpGhY0yAnzcaCyNwaE9g05hNDi
	 Ue2baqcfgOxv50sPizfKI8obUdEP+n3I0hb/lhjkPotD0eHQZpmEa0cSM6OP2LyHR
	 9DSpOAOFUaCJ6t2aj/DX/O+p2lI0UpjEGpVAPsKSFn28mE77D78WSWjLcxdi3pXFX
	 MhTZiKO25plk1pkGVZF9ixAUUHxVi8y27XkYwILHjvve61lXtSm8PnDqsYigj5vTy
	 lMbliGbykFO0lmYV+BO1dtoF+yJ36Q8Yzk2QAtS5AX12XxvECQ6BQidZHVt5sHw1x
	 mJxOAjqYdl7j/EU4OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.158]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1tSJjM3sXV-013I50; Fri, 14
 Feb 2025 10:05:42 +0100
Message-ID: <deea066a4bd4703ed395287b627666da990cbbda.camel@gmx.de>
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
From: Mike Galbraith <efault@gmx.de>
To: Florian Paul Schmidt <mista.tapas@gmx.net>, Leon Woestenberg
	 <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
Date: Fri, 14 Feb 2025 10:05:41 +0100
In-Reply-To: <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
	 <84bjx6h2kd.fsf@jogness.linutronix.de>
	 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
	 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
	 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
	 <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
	 <fe289947-7f41-4810-ab37-6d40c0081135@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QTasjISBggvf8ISGHREysZaELy5sEjutnRvHpNepHpxJCWQK0Zx
 XwVBwcflCwZrDJYvtLdOT6HSWhh+/GfabkNhkqwgb5rb5xgtiUFsSVZzGKHY/uCm8sp3vKw
 zoa6Koxiumpv36vODQ8ZkHGFQg6E+HVQA4Qrtpwbe9OkNRA91YDVKkmOAMICbcVYK9Wmekc
 uSHaZNUBohcR4wIP8d1sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uyUZyHrsF2k=;7i4f3s/6WR01UxoNH1bzLaZiof2
 kmD/JDVab8hQK1Oxv2NipykNO8Y4U52b7LTWjzJBA3xoGh385c1oPq1QDz9aSVKU189XcH3h3
 cri4hqUjF3c9b8Hrbpqx7zsSFPUTer4MI16LNGtOPzQ+bANk898zVz4PaljtXjjCi4KCY93es
 VvWFe/yy5W9/9WDGzYc9e75i2unuAC+onNNv/RggNBoIXuW49mK5jg0HWK/8w81PFeTN+PtkI
 hqyRqJWxTYTKH2DCncpbIjvnHJ6vNwaNpQe2bmHpTzBJrsmOiGIEz4ByFmzti9hzDR093uUzS
 lxMQkLHdqwCPnVujS+rBM6MNwoXaPaiwEwf0/kSJ3hg9MAV38LUR8gTrc7Wjg6SlY5d5q1BUv
 jt92oHUX7gl53J34ss27pF4vH5KerD5qa3UT0tqfgj4pf9ke5xPKRHWkRfRN0a/ik5VqhC1j2
 S2W+9CELoY9xcuYhALjBNZy4IctZTFSZSX92xzNpDbFqWS91bY1N/Rdr0MgvBAi2YJuu2Vezf
 8kf7w2Rlvwb+NznyeHAfqsjd1SbQPF2PWkNjd+wv6FLXN79J4MFG2J/Yv/Za/7dkhcxsyLaeF
 +oM02KWbG97OvwyNYKJJTk3ltamJSZqKuZUToAUrnyDfWWDHfN6NaEpzYaAdZFe4Fd4H2Jt8a
 057Rj2h3KHhMVyqKNGXGP/5TEDoQX8Av3TJBhYLHd48YOfnMWHOUfwSWkktWJ/azEhVIafKXt
 wF7MfsDjpVbomTURVibjAe5CMCQF71gksAxDcWX95LRNWLdNP6caX4TPJjHIp/O/0p8/AECW6
 Z04pPtZWjIX/1S0SKSnSNUw5P/x3BElGuBWqnfUNlGpWQlVyU9fG1fNB6E9xlYLlxLEIHSq7u
 3eoPpvNeBt7Dxne9840zG9MM3H2VGRV7UzIma13HaegGsGmr6HRDNolawuj3pqBa1t4PE/uS6
 U2tfgSAwV05L0jQEkYB0P+hI5Me7w1zq49LT659XKFIzRGRANgqriynlEXPFaGLJZG9SEOJN6
 KwVBNed8SLCBQFnOn8nMymDtiN/dPdPQV29AT+6zc8myk4+GRW8nWVOngVdJP5SDjODgqvZQm
 mije0LYrXIDo9aW4e9WnIl3OoKU7UJYMZi559GzJISU0AOjqdrT8xw+SF0GMjLV0LmIaf1JOo
 7Wp424iDC/N4kFzzRdIEPkJGsNjMkfRTAMfMHAqqrPElgodzfFkxjRHohFVEPQy9rpX4VDnFY
 LkKz88q9lRU+Yu8bycsHjoHDYxHIKYXbG/sQGeUaMlsqzJxrExeYWCyZLqA4P5GQUN27GyLUh
 WfL2cky8BWqTOffdXDZVrvBerQvb1kBGZL88aIBUdu2ypdj6X/RCrkxCj3wCbt/UJzGUIWPBg
 T+nfWDChK0T2Zb8A6gYh/4FUYGRk9XWpAogp1MUVbez8P2pyoCN4EeHRNVEa7EpH2trDRrcNV
 NhwOW7Q==

On Fri, 2025-02-14 at 09:31 +0100, Florian Paul Schmidt wrote:
> Hi again!
>
> On 1/14/2025 11:28 AM, Mike Galbraith wrote:
>
> [...]
>
> > This seems rather odd, one core diddling memory is the worst case.=C2=
=A0 Any
> > arm experts out there know why that would be?
> >
> > pi5, locked at 2.4GHz:
> >
> > taskset -c 3 stress -m 1 --vm-bytes 1G --vm-stride 16 --vm-keep --time=
out 60s;killall cyclictest
> >
> > T: 0 (23157) P:99 I:1000 C:=C2=A0 63421 Min:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1 Act:=C2=A0=C2=A0 12 Avg:=C2=A0=C2=A0 27 Max:=C2=A0=C2=A0=C2=A0 13=
78
> > T: 1 (23158) P:99 I:1500 C:=C2=A0 42327 Min:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1 Act:=C2=A0=C2=A0 32 Avg:=C2=A0=C2=A0 29 Max:=C2=A0=C2=A0=C2=A0 17=
34
> > T: 2 (23159) P:99 I:2000 C:=C2=A0 31744 Min:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1 Act:=C2=A0=C2=A0 18 Avg:=C2=A0=C2=A0 28 Max:=C2=A0=C2=A0=C2=A0 13=
53
> > T: 3 (23160) P:99 I:2500 C:=C2=A0 25393 Min:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1 Act:=C2=A0=C2=A0 11 Avg:=C2=A0=C2=A0=C2=A0 6 Max:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 39
> >
>
> I wonder if there is still a way to save the day, i.e. use the RPI5 as a
> somewhat capable RT-system by
>
> 1. making sure that the RT load does not do anything nasty - this is
> mostly under the users' control since they can setup their RT load to
> not do this.

I think that's the answer, don't expect miracles from cute/dinky boxen.

Beating crap out of any box is only useful for finding limits, has
nothing to do with "RT capable".  A box is RT capable iff a given RT
load's hard constraints can be met on that box.  Both of our stress
results show only that if you need amazing memory performance, dinky
pi5 is not for you :)

	-Mike
