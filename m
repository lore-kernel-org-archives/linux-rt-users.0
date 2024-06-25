Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECA1B7F7;
	Tue, 25 Jun 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324598; cv=none; b=KbEeHTrvCRTrHZXYTYvBzBb3sPoyA+WCt/JaTeEghR2T+dT/GI9mLa3+T8x/KVBgfmiyTGoL1a/aVI35uGbZmNwB/OFL5WDQ79pJ/J+A55ipQGvs3wqcr1vUiSgmjKNmt/Tt/n6f7TI5YADJHYVeFgaXT53oRW1+AAbi2JvprKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324598; c=relaxed/simple;
	bh=YAITqrRrzZ6v3MsH8//+1u3BgJ69ZP2A0keeXhwDXis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9ALo8U6/rC1KCQXADqlg/X7/jz0QbCAmKA/0jfxlKNB1J3JHFGWxeyDiPb4iW6HAc+qilsLpkut58s1Ze5wGA4qMnTFK/7VU7fyRBnfdVAyXZCXtYJRkvYMKcC9RTmoYHPxiRyD7taCuUHi7sS3BqjHehIsxU8MbXQlGGuBgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrfeJvW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AKlBEBF6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrfeJvW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AKlBEBF6"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719324594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLRAASEKt9cSOd1wXV/lLTFBcxPcrp1VcIrjbo3059o=;
	b=OrfeJvW+zdt0BEzq1QAtGLtUuAfkqiDcjp/pFK2jBbC02SBYdQEUbmXPuT3i/oojMuNmay
	DIYIKJkXNgAgaeI3UjJ5lg//t2+sc5JNFGSvNzytm+myc9VoN1XqrhwkPFoi9BGSweJP3s
	nQ2hIewxiUoMyfCB9U//peK31QqD1GJdDgRiaK+drii7gYeNMwiZNCJbO9q4R39E7Z5szL
	mY45lNKyRV+3n03YkHSiLzP3z5AQfrIu0G1BnErJiorMkGP2l4kTz6iQTqsO1sy+E7LGnI
	gh/V9iR9qDLgUnvJKTnJZKIkX8mjzXHDR9jl96v/znEw8Xhp8kz0sk0JSWXIhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719324594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLRAASEKt9cSOd1wXV/lLTFBcxPcrp1VcIrjbo3059o=;
	b=AKlBEBF6U+ssOn61YRfNpEYFD6j5Oa45b5bv5usDGCyZVSXSqi34E6kEdlq6ebUzMX7BfG
	exeeWj2KlSNRa1Cg==
To: Steven Rostedt <rostedt@goodmis.org>, Andrew Halaney <ahalaney@redhat.com>
Cc: Song Chen <chensong_2000@189.cn>, Derek Barbosa <debarbos@redhat.com>,
 pmladek@suse.com, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
Subject: Re: a question about how to debug this case in ftrace
In-Reply-To: <20240625094406.42acfacf@rorschach.local.home>
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <20240625094406.42acfacf@rorschach.local.home>
Date: Tue, 25 Jun 2024 16:15:54 +0206
Message-ID: <87h6dhxgel.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-25, Steven Rostedt <rostedt@goodmis.org> wrote:
> You may be interested in some work I'm doing that allows you to read
> the ring buffer from a previous kernel after a crash.
>
> https://lore.kernel.org/linux-trace-kernel/20240612231934.608252486@goodmis.org/
>
> I also have a way to ask for any memory, that should be able to get the
> same location most times, via a "reserve_mem=" kernel command line
> parameter.
>
> https://lore.kernel.org/linux-trace-kernel/20240613233415.734483785@goodmis.org/
>
> They are both destined for the next merge window. After that, I have
> one more patch that ties the two together, so that you can have a
> kernel command line of:
>
>  reserve_mem=12M:4096:trace trace_instance=bootmap@trace
>
> and then when you boot up, you would have a trace instance that would
> be mapped to that memory. If your machine doesn't clear memory after a
> crash, you can read the data from the crash on the next boot.

Nice. Thanks for the heads up. It will be nice to implement a "printk"
label as well. ;-)

John Ogness
