Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D1277815;
	Tue, 19 Aug 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601503; cv=none; b=ZWb5DjQr8inPjY0dF/KMiXWZMYcfZp0gr1EbRWYjSujMooqnFMpDqxTOs9E9/Iwp6mC6pAjhWEkn5MeWpnQ1/01WUK+ioUMXkhlOnqqG9oDv/PDHCKyPTCOj1yi19pQ+kB8MMtEh3hh93xtuLx+XdwJZZPgdbkwIb+netmqqH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601503; c=relaxed/simple;
	bh=rHEaaqol+wq/PQNpycnOEkWJjXBDEIgMozYeYNpptek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw8zfuzxM7hDu7ouIbZPQfwpqBUOCj4eRfcokAcDXDtklh6jQIdzM+pEJueHT9+5gnGiA1aFH71OGo32++zOHUazLvM8sKBvXRyyQjSQ3k3hC+chcHhkWiwEKlXD0M95NyFCXr3O37eQMKQhLbSI+PGZPK/z7N3ZdAPHaK8Gfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PGxiU+u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5se6tVPg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PGxiU+u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5se6tVPg"
Date: Tue, 19 Aug 2025 13:04:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755601499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh3iYHKlyPINsf7PNaMKXhkXHfqA7fwYANjIihyFuo=;
	b=2PGxiU+uGZFhhZWRgEV6eDHVadp7vpBOd/pefe7KSysvMbHwAbF4+NXL5oABADTgbMpkjU
	TyKYJWyE4BWkezRelUcknyX0OZFo19U0oH2H1z4EOB+Qpneh43nt5Z7iBPXeZtaAhe8CgG
	5Ti0slD3PtCuCIHgXST7K1Vf8FYyI2TNU80belu8Vk3Tqmw69ZwGDFdMhaITLjVJfCb+Fr
	J+lB5FuodjS9NTj//aU3bYOsSHQ7RWBE51NeoEzD8cH5/NWBuKRP/UExrDxM6D/m6hNM/A
	g8cej4XsXNonz3/Si8Co99KN1caAlal3vHP+XUAKLppqhbq/KuIgEUyNZPh/OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755601499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqh3iYHKlyPINsf7PNaMKXhkXHfqA7fwYANjIihyFuo=;
	b=5se6tVPgpJvj7sc17yngQFEUN4QaEDbpZOW0Pgsk2c0A0XpF+IolQhNVQOHmHuYywA7PHJ
	AAtH0F/yK0ZBrnCg==
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
Message-ID: <20250819110457.I46wiKTe@linutronix.de>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
 <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>

On 2025-08-17 10:27:11 [-0400], Alan Stern wrote:
> On Sat, Aug 16, 2025 at 10:16:34AM -0400, Alan Stern wrote:
> > So it looks like we should be using a different function instead of 
> > local_irq_disable().  We need something which in a non-RT build will 
> > disable interrupts on the local CPU, but in an RT build will merely 
> > disable preemption.  (In fact, every occurrence of local_irq_disable() 
> > in the USB subsystem probably should be changed in this way.)
> 
> Or maybe what we need is something that in a non-RT build will disable 
> local interrupts and in an RT build will do nothing.  (I suspect that RT 
> kernels won't like it if we call spin_lock() while preemption is 
> disabled.)

This is the local_irq_disable() in vhci_urb_enqueue() before
usb_hcd_giveback_urb() is invoked. It was added in 9e8586827a706
("usbip: vhci_hcd: fix calling usb_hcd_giveback_urb() with irqs
enabled").
The warning that fixed back then was 
|         if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
which was kernel/kcov.c:834 as of v5.9-rc8 (as of report the mentioned
in the commit).
local_irq_disable() does not change the preemption counter so I am a bit
puzzled why this did shut the warning.

> > Is there such a function?

We could use some API that accidentally does what you ask for. There
would be local_lock_t where local_lock_irq() does that.
What about moving the completion callback to softirq by setting HCD_BH?

> Alan Stern

Sebastian
