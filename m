Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B491741D2;
	Fri, 16 Aug 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804123; cv=none; b=mSfviZ+Td5IpJ4VoRh4wYo1oKWTeXuPEtRKi5llFlP//N6O2UlN/q3zs0KXocS4BFuNWEsiF1ZF97QnMknTR/MQclMjIcaGVdTeYciOpnVwUt+sR9U3Gjji9QO3QYOBA7W5TLwaeEH8CtUrYLiOH+85UWnzgCQRkAPeNftEBDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804123; c=relaxed/simple;
	bh=XI5uaTrsqvGPRrsijVCc30F1WVkmsrklnZ8xsIeVfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2NStmTDjn8vhaeIEPqhy+F8D9/8VuBHLH59w35arXeSq2u7yayPZZqGHwJNrfS3pk4Kaq9N8HU+p1EtPep6sCvIObq+YIh99EhLqrgNoCNjxQIdJ3nTYKwYxnZDmKBhaL6aFiFFphWlCXuVi1j/utm9NtochfQI/rjVZs+x7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+yy//gC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CBpDzmXU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+yy//gC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CBpDzmXU"
Date: Fri, 16 Aug 2024 12:28:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723804119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQWxb5coQ6Yv3bJITDVRiuSY8d5qELlNem6mdnS5Wc=;
	b=w+yy//gCOFDOEi0Dgmam3qquyDnSLiYRMGyjRqqlDQPsN+FM06c8xeBzUDVz8EVrhliXvl
	9umhfZ1eJ173As9DmwElbKThb3IeOa7uomTDagjOn0yMPkOOj3+OOCgVlAsZxpIHakT/J5
	1szkFBNoP6X1p/FqUicoTVNcoSdp39C39vbdXCdg6n9sU+nFzv0eOCnF4I3fUviyE7mMD6
	xs4Oca6UGJ14/mqtqsi8k6VzUta2xrA1o7pUxDFyiYfeIydW1kr+Fd6eM5Q6HwNUtiOPXb
	8w+lSGFhEVRQEbaKSPiRaEMTSgt6quT6QUfGgXjpfR9R0qeuKUVcHLQVGnkKjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723804119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQWxb5coQ6Yv3bJITDVRiuSY8d5qELlNem6mdnS5Wc=;
	b=CBpDzmXUrWDUM5ibstQMXJIoBTNJHyUPbLOVG28bE5F4GFqcYWqZdBP9hEopysXjK5vjjb
	JJOasUBYTOVPqPDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [PATCH v5.10-rt] rt: dma: fix build issue in at_hdmac
Message-ID: <20240816102837.8XZfA2fM@linutronix.de>
References: <Zr6gH7SNsAD0LHWV@uudg.org>
 <20240816064625.J6zQVz6r@linutronix.de>
 <Zr8fddZYw5iYufd-@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr8fddZYw5iYufd-@uudg.org>

On 2024-08-16 06:44:21 [-0300], Luis Claudio R. Goncalves wrote:
> > If I see this right, then this code has been replaced by commit
> >   ac803b56860f6 ("dmaengine: at_hdmac: Convert driver to use virt-dma")
> > 
> > which has been merged in v6.2-rc1. This has been introduced in commits
> >   fcd37565efdaf ("dmaengine: at_hdmac: Fix premature completion of desc in issue_pending")
> >      v6.1-rc5
> >   c6babed879fbe ("dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()")
> >      v6.1-rc5
> > 
> > This means v6.1 is affected and the earlier version got it via the
> > stable queue.
> > This compiles here with and without RT on v6.1 with gcc version 14.2.0.
> > The question would, while it is bad in your case and I don't see. Also
> > if this is visible in your RT queue, it should be visible in the stable
> > queue without -RT, too. And then once all details known I would like a
> > patch that goes upstream and fixes the breakage at its root.
> 
> Sebastian, I do believe this problem is unique to v5.10-rt. My bad for not
> stating that clearly on the description. Also, specific to aarch64 AT91-based
> boards as AT_HDMAC requires ARCH_AT91 to build.

It is also part of one of ARM's defconfig which I tested with. So this
is not so unique.

> The definition of spin_unlock_irqrestore() at include/linux/spinlock_rt.h
> is slightly different between v5.10-rt and v5.15-rt:
> 
> $ git diff origin/v5.10-rt origin/v5.15-rt include/linux/spinlock_rt.h
> ...
>  
> -#define spin_unlock_irqrestore(lock, flags)		\
> -	do {						\
> -		typecheck(unsigned long, flags);	\
> -		(void) flags;				\
> -		spin_unlock(lock);			\
> -	} while (0)
> +static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
> +						   unsigned long flags)
> +{
> +	rt_spin_unlock(lock);
> +}
>  
> ...
> 
> And that seems to be why the problem pops up v5.10 and not on newer RT
> versions.
> 
> I see that there was a revamp of the rtmutex code between v5.10-rt and
> v5.15-rt, but given the advanced stage of v5.10-rt in its lifetime it
> sounded more reasonable to simply fix the symptom.
> 
> Do you have any suggestion on how to proceed?

I would start by explaining that this only affects <= v5.10 because of
the different spin_unlock_irqrestore() implementation (macro vs
function) and the compiler does not complain about the latter.
This would also make clear why it affects certain RT versions and why
mainline is not affected in general. Also a reference to why this is an
issue now and not earlier.
This information looks more important to me than one line of compiler's
complain/ warning.
That said, with this additional information I don't mind getting this
into the affected kernels.

> Thanks in advance,
> Luis

Sebastian
