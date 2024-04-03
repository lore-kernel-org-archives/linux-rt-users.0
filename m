Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A084135A65
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138951; cv=none; b=SIliiw+wARiDH3OiCNcJRBNrl9CE6pcxwOF86A37+b+KsqrSULZJXUUV/PGL92FvbIxG6fIZdWztd6gZrlLWgZYF1GOsE2ldLh7dRKCU3DtzsV4hAdBzyYgPBAoaTq0opGbKkCka1DHdFdmLS+oZoKz5+nmu3crVUR3MmsJXauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138951; c=relaxed/simple;
	bh=52Za56VH+BhndiJ67ZlUv32VL3Cp0JnXYpN0TNZFE58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZtThYIxWuiWkNczNaNIFkQhqa6PB++UVHIns/8xn2jI01OrYIEi26ZubV/8//hc0Xu7W7lQqJ7V4iJWnUImOUzduKPmJKMHopelsVCTUev/tu7ItYtyc51M0IRPIISVOsYIw+5rN4fXC8m2hf80sUnZjANFYaMWj8foOV0/6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WMbiSsJ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g1CQF4V5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WMbiSsJ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g1CQF4V5"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712138947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52Za56VH+BhndiJ67ZlUv32VL3Cp0JnXYpN0TNZFE58=;
	b=WMbiSsJ86b/8jJPXMCDGCQ5X0S1HPQhla7cjqU4uotpOAn7Aiv1Zgi5gNJC66Iso09R8+f
	ssqwXNCtcJ56ALrMWxk0+xAWkcsZLWfwXlqPDC0utTj8NxYJOrdOnri6QuwdWUOclGR/yt
	SiTG2jfLSSB+WEqyfnrvWwj77iHup6VbQ9lbQ0zcMBnbHTSyH4I21fTQboXyCPMaqAmu+A
	F3rKf5cwDI9JGUbhxQEojkka3M4Lp3F4sYbk8bKhOsqk24l73sD5WFXWqkaBgfDNhrNzh9
	Pva7AfBxdIEKc1fsuegMWOTbDZdjpaotDNEk7JYACFPjjmRcQWefzR6QZLkxwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712138947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52Za56VH+BhndiJ67ZlUv32VL3Cp0JnXYpN0TNZFE58=;
	b=g1CQF4V5GgpMBYCkAMrQpYswQswOR1zryXf37tyRDjCFvjkMbjnXgPVo5MBQSAnpAGk9Sk
	OraWCeHOINckosCg==
To: Esben Haabendal <esben@geanix.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-rt-users@vger.kernel.org, Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <87v84yye24.fsf@geanix.com>
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
 <874jckqcxu.fsf@jogness.linutronix.de> <87jzlgf1w2.fsf@geanix.com>
 <87wmpfq4p1.fsf@jogness.linutronix.de> <87zfubesih.fsf@geanix.com>
 <87o7arpza0.fsf@jogness.linutronix.de> <87v84yye24.fsf@geanix.com>
Date: Wed, 03 Apr 2024 12:15:04 +0206
Message-ID: <87o7aqyczj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-03, Esben Haabendal <esben@geanix.com> wrote:
>> Finally, if someone wanted to try porting another driver for PREEMPT_RT
>> (for example, the imx serial console), I would certainly be interested
>> in reviewing and integrating the patches for the PREEMPT_RT tree.
>
> Sounds good. I have looked at porting imx uart driver to nbcon, and have
> something working now. It does smell quite a lot of copy-paste
> behaviour, but I will send it as an RFC for you to see when I have
> tested it a bit more.

Great!

> The write_thread and write_atomic functions share quite a lot of code,
> carrying half of the copy-paste smell.
> The other half is the inner loop of the write_thread function, which is
> almost identical in 8250 and imx drivers.
>
> I guess there is room to refactor this to avoid this amount of
> copy-paste before starting mass-porting.

I certainly hope so. So far my 8250 work has been making sure it is
technically reliable. I expect there can be a lot of improvement to make
it more efficient and generic.

John
