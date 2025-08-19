Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A5283CAF;
	Tue, 19 Aug 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615426; cv=none; b=tGFC2W284dw+Pe9df+CXvzXCA77spL3BZe2JGNz2jQAyHHAQyJx7teaVbFoh0bEsnT/ZnYAsNoly2CTw/lfh3A+KP76Oxqe9hBbjPhsycdr1OEwptTVrZ0DQOATHSJmlBu0HwhIBkuhtKWG/01P9VX4AeHAHUgLdWslcZUfI+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615426; c=relaxed/simple;
	bh=jTRC/CHJntYVtBQIVMAGSv4VOFd+4rvA3L2Yn4gMfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhfw5flNhsITXMwhr1EiW1HoUSAYnIXULRZSrsu10bg5Zw/T3dxShnA0YaNljDABu6SkKD4nPyrty8VJU0FX+1TtUA2f5CjC5XSjDO6HFIjxIylHeyLSnxwjGZqc2hHdMX+0uii3aY+XjZPrTOfOyZHMgRiZG2tquVKYmXLP/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XBPDLe0f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pS+8WlJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XBPDLe0f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pS+8WlJ5"
Date: Tue, 19 Aug 2025 16:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755615423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fcGAbJPPdGZvSLVrtBanIpB5dI4uHVka3XSy/P+gA8=;
	b=XBPDLe0fihzaCCfT5pSO53u96LHBo7uzmoa5bB9bv22RWOZ0eVnRBOIoXe98ff/e8PT0wI
	mhthpjVcYpV90s/o5QvxRvtGnTJcN2H7jwDKz2ezq1IC6DYosgszQSOj8AZR6rCLGl3f7S
	wDAi9K2a/WgdD+YmtNkgL4C9d1KESvtWt5Tv/TqmGtMCasIyY0iaH6bx1Nnhg0n+XPHQIN
	AbItO/ZONX4jDmIskQjHDgGlM8Xwz50tYndwI7c6STP2TxlgdefXTdhlV4CCjQdPawL534
	FqEl7d3x2aGNJchINbfzx4Edsvx8Pm1Hs7UPmG4TF0fZELygfr1SvARXl4KdZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755615423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7fcGAbJPPdGZvSLVrtBanIpB5dI4uHVka3XSy/P+gA8=;
	b=pS+8WlJ5up5SYgONcsS9fwRHHqpFdrbk9QbJm/n8kzF1IRzAe5hMxbfHUKOgN9Zw3Nl5Tn
	AGGboCVmDy/vYiAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Yunseong Kim <ysk@kzalloc.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
Message-ID: <20250819145700.sIWRW7Oe@linutronix.de>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
 <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
 <20250819110457.I46wiKTe@linutronix.de>
 <49ee1b8a-d47a-42df-aa64-d0d62798c45b@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49ee1b8a-d47a-42df-aa64-d0d62798c45b@rowland.harvard.edu>

On 2025-08-19 10:12:31 [-0400], Alan Stern wrote:
> > We could use some API that accidentally does what you ask for. There
> > would be local_lock_t where local_lock_irq() does that.
> > What about moving the completion callback to softirq by setting HCD_BH?
> 
> You're missing the point.
> 
> There are several places in the USB stack that disable local interrupts.  

But *why*? You need locking due to SMP. So it should be simply to avoid
irqrestore()/ irqsave() during unlock/lock or to avoid deadlocks if a
callback is invoked from IRQ and process context and the callback
handler does simply spin_lock() (without the _irq suffix).
The latter shouldn't be problem due to commit
	ed194d1367698 ("usb: core: remove local_irq_save() around ->complete() handler")

So if completing the URB tasklet/ softirq context works for ehci/ xhci
without creating any warning, it should also work for vhci, dummy_hcd.
Only RH code completes directly, everything else is shifted to softirq
context (for ehci/HCD_BH).

> The idea was that -- on a non-RT system, which was all we had at the 
> time -- spin_lock_irqsave() is logically equivalent to a combination of 
> local_irq_save() and spin_lock().  Similarly, spin_lock_irq() is 
> logically equivalent to local_irq_disable() plus spin_lock().
> 
> So code was written which, for various reasons, used local_irq_save() 
> (or local_irq_disable()) and spin_lock() instead of spin_lock_irqsave() 
> (or spin_lock_irq()).  But now we see that in RT builds, this 
> equivalency is not valid.  Instead, spin_lock_irqsave(flags) is 
> logically equivalent to "flags = 0" plus spin_lock() (and 
> spin_lock_irq() is logically equivalent to a nop plus spin_lock()).  At 
> least, that's how the material quoted earlier by Yunseong defines it.
> 
> Therefore, throughout the USB stack, we should replace calls to 
> local_irq_save() and local_irq_disable() with functions that behave like 
> the original in non-RT builds but do nothing in RT builds.  We shouldn't 
> just worry about this one spot.

| git grep -E 'local_irq_save|local_irq_disable' drivers/usb/ | wc -l
| 21
of which 10 are in pxa udc. The only one I am a bit concerned about is
the one in usb_hcd_pci_remove() and I think we had reports and patches
but somehow nothing did happen and I obviously forgot.

> I would expect that RT already defines functions which do this, but I 
> don't know their names.

We don't have anything where
	local_irq_disable()
	spin_lock()

can be mapped to something equivalent other than
	spin_lock_irq()

I was running around and kept changing code so that we don't end up in
this scenario where we need to disable interrupts for some reason but on
RT we don't.

The closest thing we have is local_lock_irq() which maps to
local_irq_disable() on !PREEMPT_RT systems. But I would prefer to avoid
it because it serves a different purpose.
What works is something like
	spin_lock_irqsave();
	spin_unlock();
	$SOMETHING
	spin_lock();
	spin_unlock_irqestore().

The question is why should $SOMETHING be invoked with disabled
interrupts if the function was called from process context.

If your concern is a missing _irqsave() in the callback then this
shouldn't be an issue. If it is the wrong context from kcov's point of
view then making the driver complete in tasklet should fix it since it
would match what ehci/ xhci does. 

> Alan Stern

Sebastian
