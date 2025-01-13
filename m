Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B361C07FC
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766550; cv=none; b=e6DyZlAiAFaX1GEsOrV60AdmuUDBqct1QlsJ12/ClhkRRyPPYq0LBihMrp9gWrjApKOrrRT6B1cspgrok1SsxV06m/t/cah2RZwRchBNwClLKwO45QCRA1TfGgg2BOnQi6eo5cVKRlu0ECOEIJre/K0fiywt6TBUVB3rqxUaxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766550; c=relaxed/simple;
	bh=LovRtCk8ESW+0DYQmThHQrv4YhXWKPS+ONt6yNDrTqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=owCxGkil0/5c61xj3mHh0N/6p95dMGmnbp4Uhmz9OA0adFoxh8S9vxisSHcRYzXba8KBK3wiqA7DXWzDRAOFAEvZu2pFAe1k0r631jPUlJ1WWNSQd4eX6LywO7CB03klwKiNB1ZDxpH70VRAY8b8IsfKqigBC45brcOoloh4G44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p7l8FONy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=deDlO1to; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p7l8FONy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="deDlO1to"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736766546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bevuTikE30Fft3FV1FIjHPc6IoyvWWDz423SL7POjhQ=;
	b=p7l8FONyxpQxFs47Fg1//w/9zbfgb8s7Xnc9jUUSRJDiFJdgFM7fgGJl+2EDWAAj9epQ4v
	MHnaz0hZLWCISesDagPo5dDy7WAWA+Bt+pSi0xlkw3dVix5ThMhZEeV80Fz7EanSC13s9Z
	xkac6fQvY06y2IWrr9N9QDuuezQCaMSTyGS13kw0q5mNTk1KxRYMs224ylX5ZqUqFvsRMv
	ZZyvBboKzxSekW0h7mxfWGLZ+PdTRFzkWS9DZfqstMVI2pDTzuBch3KlQ93wGMYOF5WHfm
	OhumBz+DGRKuc1JK0MZa8eYDaOYOxf1JqUfu4eGCf4gh5a7I8GdGo2BpxScrBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736766546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bevuTikE30Fft3FV1FIjHPc6IoyvWWDz423SL7POjhQ=;
	b=deDlO1tolnUviKa5T238KbsKPCRo/FptXhGGciPIb9scpLa8m8U6l1RWgtUaGnaiLPlsaw
	Uh+WxFaG19P9RbDw==
To: Florian Paul Schmidt <mista.tapas@gmx.net>, Leon Woestenberg
 <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
In-Reply-To: <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
 <84frlnsosm.fsf@jogness.linutronix.de>
 <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
Date: Mon, 13 Jan 2025 12:15:05 +0106
Message-ID: <84ikqjdl7y.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-13, Florian Paul Schmidt <mista.tapas@gmx.net> wrote:
>>> T: 0 (139313) P:95 I:1000 C:   5881 Min:      2 Act:    3 Avg:    3 Max:      10
>>> T: 1 (139314) P:95 I:1500 C:   3920 Min:      1 Act:    1 Avg:    7 Max:     419
>>> T: 2 (139315) P:95 I:2000 C:   2940 Min:      1 Act:    1 Avg:    7 Max:     480
>>> T: 3 (139316) P:95 I:2500 C:   2352 Min:      1 Act:    1 Avg:    9 Max:     433
>
>> I assume you see the same effect when running stress(1) pinned to CPU1?
>> ... just to be sure the boot CPU is not somehow special. (No need to
>> boot with isolcpus since the machine is otherwise idle anyway.)
>>
>> taskset 0x2 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1
>>
>> sudo cyclictest -m -p 95 -a 1,2,3 -t 3
>
> Yeah, I see the same behaviour with this way of running the test: The
> core with the stressor on it shows small latencies and the other huge
> ones. The effect disappears once I run two or more stressors, e.g.
>
> taskset 0x4 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1
>
> and
>
> taskset 0x8 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1
>
> Then all cores show huge latencies.

To me this looks like memory bus contention. I would expect you could
reproduce the same behavior with bare metal software.

Someone with some experience with this platform would need to speak
up. The usefulness of my casual responses has come to an end. ;-)

John Ogness
