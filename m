Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB85746E
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318227; cv=none; b=FQsD627NCeLU+9A0RXt+cO/vAuLVYDkKoHrWMYsf0vkXcHm8GZNT4sBlgHsRVxEMrm3qJXo3wY6l3rZN8USx2tuAmoLFlVdbx6qQb5nKAXmpdXWuvqM5THjkkLFfl72g3uUNIEv018jNuSjXpUE4I2QfaTjQopzvhjQWk2r9O08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318227; c=relaxed/simple;
	bh=Ko3KQlffamskhJiaXq2Hg28wR2Ekr5eyn4vChq0P4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0pLhRRdMYDfmVvxBAIH8sGjocW365OF9T+I1c/f8/JuknVkSvQnquXZ1ZyD41+KAsJmsusIMJHoy4w8ff6SOjzztQ8Izus5qrsyffU3ODXen35ctTQI2jz1lFg19HiLNl4JNUWLMaU77nXMFT9vTc3MN3jz17A/TvDSSC6rCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B00C116B1;
	Thu, 18 Jul 2024 15:57:06 +0000 (UTC)
Date: Thu, 18 Jul 2024 11:57:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <20240718115704.0cd768bc@rorschach.local.home>
In-Reply-To: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 10:41:25 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:

> Hi,
> 
> Recently I was made aware of an issue when running 6.10.0-rc6-rt11+
> (with a !PREEMPT_RT config, although I'm not sure it matters here).
> 
> Its easy to reproduce, just printk on a CPU that's coming online (I got
> pointed to a real splat, but this suffices to reproduce).

I'm more interested in the real splat. Where was the printk() that
triggered it?

> For example:
> 
>     diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>     index 0c35207320cb..eb75a7cffe31 100644
>     --- a/arch/x86/kernel/smpboot.c
>     +++ b/arch/x86/kernel/smpboot.c
>     @@ -274,6 +274,10 @@ static void notrace start_secondary(void *unused)
>             cpuhp_ap_sync_alive();
> 
>             cpu_init();
>     +
>     +       /* Let's printk() and see if RCU whines */
>     +       printk(KERN_ERR "RCU, what do you think?!\n");
>     +

prink() is normally OK to use on boot up before SMP starts. That's
because it has nothing to race against. But this is the secondary CPU,
where we are entering SMP. RCU has to be active to use pretty much
anything (printk, tracing, etc).

This is why I'm interested in knowing what the real splat was. It could
be that it is used in an incorrect location.

But if you are just debugging, then you should be safely able to ignore
this.

-- Steve


>             fpu__init_cpu();
>             rcutree_report_cpu_starting(raw_smp_processor_id());
>             x86_cpuinit.early_percpu_clock_init();
> 
