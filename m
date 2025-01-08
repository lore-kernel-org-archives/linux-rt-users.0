Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6A1D932F
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Jan 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329339; cv=none; b=BiHYwOwekPMZ5C+3mgd6Wd4VJtKJ30M/Zx+Qt/OeUCZ+HeAcbFsvMO2p/BKZvFqQXMFEi242rtZ1sxXX1kBtM4sbBGD/H8brshFI9iuy0wQPXz69yj8Aa0lrwd42ci8Nhs6vEwnCBcJVb5OFf2oHmSMD6AN2jOh3v9yCijHVzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329339; c=relaxed/simple;
	bh=wUJKk9R+S6Kui82AnvidA1TrQ5vXMAlP6ha2CJb6nHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alyJIdWhYUtXDKRDKp/IYejy2azCxl1IROuIxeWcDSnFoLsLqcDM3+xmEFICbQuXv/u5P5Ie528nzhpNBkPN5+71HG/P1n10BVbMwgjL9UyEuW0Dmg5Clxz92A4VuN1X/SzJ6s2QLWhmmeZNZMLmLGb0JnMza7BMCBDw4f48WOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=L3+oh2R3; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="L3+oh2R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736329325; x=1736934125; i=mista.tapas@gmx.net;
	bh=wUJKk9R+S6Kui82AnvidA1TrQ5vXMAlP6ha2CJb6nHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L3+oh2R3k1QghOw3VZotd9IQH8KDJw0B0LsAb0TNwz0HKFTgRA8SOJbktEbhEFOy
	 r8MLAF0YbeofKjUrIMaX3ZJNP9chp9Y/1uLAUc8qlju8qQh0sIw1n1JeA578llfM8
	 TzTf1yaKBRL5G8AmlQ4aiip+dr0Uoedqaj4Lx0JGRBNn/mPyUB0NtqOTs9AcRbtvS
	 OtNOf1tm3orav5UeNm+zJ0qzvd6zHwN5Kmh8ctPmlKEOoOOMNYcfg1D6Sb8RVplfg
	 j4+NVS0vIxPgJBnQlnfcvY0WJyveHNlDkA22AzvtA0q1m9vG/X0r7HqyYt5nMrInz
	 2fOPA0jtUPNIs1c9Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1t7CWj345g-00PbGT; Wed, 08
 Jan 2025 10:42:05 +0100
Message-ID: <a8afdc70-a3fa-4713-989a-36b14ccdeb74@gmx.net>
Date: Wed, 8 Jan 2025 10:42:05 +0100
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
Content-Language: en-US
From: Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/WJJ3Z79f8wwSlCKh6p7XASLKCFtlC39aVUrL9ykbxGOXCL7ZSp
 6ja1guAvmUxXKWrbkDh116BBf1MQqFMKlJ4I1iGHR1a9I1s8zdocK8aZyMZHE9ryp0u7L7i
 RvZQnLjOnQrodmci9VzoAYZxA3iH5Nmro+ldJppqFJQp58ZlgQHVYgSKJ337aCuc66rBrTV
 mb+Gxr/kcTOqwfYw/drtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7lpmuISAprA=;saW8hpP59JYn8rNK/zHOFbyIm89
 NfYI7wApQn4Dt1yQc718uPzJt08sPiFAj3WuH3lLtiJ4iGPjimwHTlHECaKkuIg+lku45NbSX
 7Rw1Jl2AYt2hd00qUB+LdlSJZuSZuMtIo+gSVLnRRQ97I+292gWLcW4IdpTGT0va9Vcgl+S5O
 Ef3jfTvo2WnbERt7xaCBF//xU4ULUyKEXzO7UzJ4sZDgPCt4C5NR7M9cZNGDompMZvP2jdW6d
 z+UlMKyzcucUmABZuQ6wdXHIACWEPV9tSGyorD2+djVlp9aw/wFrkl5um5gVk2AI8M+/DO0z4
 0CuGr+o7rFfg45WUP8C22No0ehYbDTbT8/jwIyUaQ9+OCiMszAsQXo4Mw18rMBqqDpGFzusSw
 zM/Xcxxohemx549uhVfPhSeQWH8sbI1OLvB5l7SOQcy+lafuTyT5ccGzvO9oVRRb90W3dH8sf
 Z+q03/7xO7qLrlnGc8LkxUDbOE43lKn6r6nm/xMwdDZQtS38biObHEPvVPtJBIRYkNrMuDAA8
 hUw3NaJK2y+tik+NY/A13nmoIMrw4oJnOqDlbmh0OxJbo4HcupZnifusuH84qMm9GuKU4m9pZ
 zTx00i1cLro7He+r5SKkpq/Z5QGRkuZFCgH5/OkhpEhi/ok2hQK6AjeKzLepUN+ggG21qr67B
 unn8gbBU5V5j53/0/G7l0TZhGg9TjNoxF8pc+fr0ikK/Nld4yR9eXjTrmxUIFguDMZQndUpIo
 bqpx05u5m9UnqnHKlmPHhi/eO67sCphAGgOzQECkvquOJX4euAoXkcoW6ArUZSly1DxrNu3Kb
 aG2d6I5AJoXA/n1CifB/SU+ntXCDC+V8KqyBZB60hJ5PYPcwJRHw276NMFgnsRXGNQBy3f/Vw
 CNOKau8/LGq+H/i4IOqnZZ3Zr3XIJ9SPgbe4erD5e4pqbzcSyL8xQdk1VFJprvHK+j8GzIdQc
 l5s345xLQDiU+aJ2xWTiaMFxDih5zbr/NFK7djDXYnTewfB1jBoKUv1kOkRH6Dw6Jzjv+6uBD
 gZiSQxUOBsP1+I3B/zEjfoWVT4gK5lfLXhov7Qax4l1vvv99wpO6oX5+QUK3RiYLjGIGFKJyN
 bouPEZfv8=

Hi!

On 12/22/2024 11:32 AM, Leon Woestenberg wrote:
> Hello,
>
> First of all, you can loo-kup long-term latency plot for PREEMPT_RT on
> different systems. I doubt Raspberry Pi 5 differs from Celeron/Atom,
> in my experience and from looking at the plots:, but YMMD.
>
> https://www.osadl.org/Latency-plot-of-system-in-rack-2-slot.qa-latencypl=
ot-r2s7.0.html?shadow=3D0
> https://www.osadl.org/Long-term-latency-plot-of-system-in-rack.qa-3d-lat=
encyplot-rds3.0.html?shadow=3D0

I am aware of the OSADL test farm :) But thanks for the pointer nonetheles=
s!

> You could consider using isolated CPU cores, which should give you
> much lower latencies, if you have full control over the application
> logic.

I would love to make use of all 4 cores though. I'll play around and see
if the latency reductions with isolated cores make up for the loss of a
core for the RT work.

Thanks and regards,
FPS

=2D-
https://blog.dfdx.eu

