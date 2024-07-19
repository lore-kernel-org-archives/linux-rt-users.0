Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED34B660
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400914; cv=none; b=IdfXLLTl6fHK5JOg0jMXewIlNB38b+PjH3ynepFu5n76Zy76hSuX0NwZNka8u28gvO/feRDUqyksenDjFY+YblsO5Cx+7DwD0QXykD6I0a1LVpuIpEIlZeCf2MSu/0X7VA2FXkeFcQn2DcxZSugLKjfevr7mtc8iXXorlxrZyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400914; c=relaxed/simple;
	bh=PFzUXLr2/yALo990FkQ2QDF5O2PzYhQJEs4gMrZISZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDe1U4OqiH5wivQGaeJ+qBUEOU0Egv5OfSMTM6HlY6pGSlm8tkiesdWPCU8Iu8CU8bOWmuwM5XljYhY5T3E5X4KB781LhdfZs5EyIuNt8l5UwyiGRrBin+zbpEerTG4TrpZWa64n5GEsXbmZAx7mNbnfi5JbZjTV22XAz520gZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3RuwRiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfwRj4s4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3RuwRiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfwRj4s4"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721400911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw8kciyHPzVi8pszzCEIhgoe0SL2OLBRAVuwP3WpnxI=;
	b=c3RuwRiU/lbje9aKFcT9kFa1aX+wl28Xx/TaX8zYCMUL/Dd0OGA5fHnxCE/Oz+R//94N/Y
	83NM0SYiG5tklkEcnbbi5CqWyEScGqEIKxtaN7TOhFL5xNWu3XDgcwTQwrZO7a2mRFF9Cy
	CLWLGSbDubgYddsDHB4z9/jPOY1f+1Xdwinv/fEiEkNqh5mKvXapSLllTaqoEYGbavZC/Z
	H3YhglzYWFakgrx4GMbfsuW11Z7wOdknuUuPZ4urZZLXNQLW9NpZJAU+1XmHXfLrjB/dqV
	rTqD95hAA4MRFOBKDEB9uxGpGpdiFVd5t6BvSxZQE4XjBqtqHgfkwYwhexslAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721400911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw8kciyHPzVi8pszzCEIhgoe0SL2OLBRAVuwP3WpnxI=;
	b=MfwRj4s4tfEahXECyIqs3XKERY6akf/ihvGhzUBmutWB+tu5XYkS579oBwB23JTbzhohp4
	Z5UJtmMLWK16QTBg==
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, pmladek@suse.com,
 senozhatsky@chromium.org, debarbos@redhat.com, williams@redhat.com,
 jlelli@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
In-Reply-To: <q2ph3icjjyg2ca6cj32fdtxo3qaap2cs3s53zp42icluve5pct@hut7qbcpqxxi>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
 <20240718115704.0cd768bc@rorschach.local.home>
 <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
 <87cyn9lssy.fsf@jogness.linutronix.de>
 <q2ph3icjjyg2ca6cj32fdtxo3qaap2cs3s53zp42icluve5pct@hut7qbcpqxxi>
Date: Fri, 19 Jul 2024 17:01:10 +0206
Message-ID: <874j8ll9dd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-19, Andrew Halaney <ahalaney@redhat.com> wrote:
>> Your thinking is not naive. It is correct (for PREEMPT_RT). printk()
>> stores messages locklessly into its ringbuffer and must work in all
>> cases (including NMI and scheduler). And AFAIK it does.
>> 
>> However, printk() is also responsible for reliably triggering or
>> performing console printing. This separate responsibility is tricky. For
>> PREEMPT_RT the problem is supposed to be solved. Obviously it still has
>> some issues, so thank you for the report.
>> 
>> For PREEMPT_RT, if you can put a printk() anywhere after the Linux
>> banner and cause a problem, the printk-folks need to know about it.
>
> Just to be sure I'm following correctly, when you say PREEMPT_RT above,
> are you meaning "the printk/nbcon/console solution in PREEMPT (independent of
> the current CONFIG_PREEMPT* setting)"? Or do you mean that + CONFIG_PREEMPT_RT?

First, the _complete_ printk/nbcon/console solution must be present in
the kernel (most likely by simply applying the PREEMPT_RT patchset).

Then, either

  1. Enabling CONFIG_PREEMPT_RT

or

  2. Enabling some other preemption model but only using nbcon consoles
     (which currently is only the 8250 uart driver)

For !CONFIG_PREEMPT_RT using legacy consoles the
non-interference/reliability properties of the console printing is not
changed from current mainline. This is on purpose.

John
