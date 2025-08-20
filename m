Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02413277BD;
	Wed, 20 Aug 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707186; cv=none; b=bjSN+WMJiHk5JrawFxxWb5waECcLHVVG5Tn7sRPiX4iuuwuMGxOsXOYsrwudniyMRWDIsoCbESXaqJSWJ1Vwb+y4fy1n8JveWPmkZthts2ek3dQx/GeHY1zWGA7aNvKFkFXc8EXbNJRRwku8gJfhYbhUSeV5Zjg9z/kdhcHyMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707186; c=relaxed/simple;
	bh=T8j6isqYSCKhlG+L6afhHUWz7byFS3gj8o60l0dyXnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRzFvpEM2FF6Qw35mfO2WD4V7YdA0XxvJxOBh8ne/er4lqj3GVeU+YKd4Ntun8IGnfFuWcXkYm2+N74iy+vqpLsdV4mmw2zuHAxAfcm6X5C/FGYoiCyCWhjDTdfvEp6kyadcVks7SMx7DzMbQ9APkoPVyW+gM9VqdRFKXq7Crr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WuxZKwQY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWwwQLx3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WuxZKwQY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWwwQLx3"
Date: Wed, 20 Aug 2025 18:26:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755707182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo8UrdLdOHJ5drKafQN3wALdlJqAJ1s63USmQ7QpBU4=;
	b=WuxZKwQY3lG0qjgGSv/rkeqIV7PvX+cuQ8y+FQ0Z/XMWpFl6lpmKAMBMOPJMU4zskUY/eO
	xGB5nZbYSgXMOcpMgt/ky+hS3p1fszDEK/O6HEskmKnVjdu/vOPMxCL5sHAXW8zhayUjX1
	0xpwhGMJ6Vg1zZrmL7wBOe8QeZNOdwvhkv0OVSzvkF0yRH9Og0d+8nSWeu5xKDUo+rya++
	FDh+mEyW5Ewchkyo+3jp/KduRs26ixt7WnXPQwvI2C7aL+h7x1kElHlb6xY3hAQJ+nlfgp
	qXCWY6aUxeJcJCwghC/t/FfpLF37bJVMoP7+xfbt3lZ60W4J7F1MPR2R61mCrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755707182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo8UrdLdOHJ5drKafQN3wALdlJqAJ1s63USmQ7QpBU4=;
	b=LWwwQLx3hva14oK38WOxyy/BZLuz6O3TYZFJ3kyxlLediNtw/cDmqTEMKkzABRCruzuShM
	6elfKYb+aHQZIXAA==
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
Message-ID: <20250820162621.UiUQUcp1@linutronix.de>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
 <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
 <20250819110457.I46wiKTe@linutronix.de>
 <49ee1b8a-d47a-42df-aa64-d0d62798c45b@rowland.harvard.edu>
 <20250819145700.sIWRW7Oe@linutronix.de>
 <bb7e34b7-c06b-4153-ba6c-009b9f1b34d0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bb7e34b7-c06b-4153-ba6c-009b9f1b34d0@rowland.harvard.edu>

On 2025-08-19 11:44:52 [-0400], Alan Stern wrote:
> dummy-hcd is different from the others; its use of local_irq_save() is=20
> in the gadget giveback path, not the host giveback path.  We would need=
=20
> another audit similar to the one you did for ed194d136769, but this=20
> time checking gadget completion handlers.

ach right.=20

> > Only RH code completes directly, everything else is shifted to softirq
> > context (for ehci/HCD_BH).
>=20
> Correct (except that RH code always uses softirq context; it never=20
> completes directly -- the kerneldoc is wrong and Greg just accepted a=20
> patch to change it).

Ach okay. I assumed it because the completion handler skips it. But that
might be a shortcut because it already is in softirq context.

> There are other places that disable local interrupts.  ehci-brcm.c does=
=20
> it in order to meet a timing constraint.  ohci-omap.c and ohci-s3c2410.c=
=20
> do it for reasons I'm not aware of (no comment about it in the source). =
=20
> gadget/legacy/inode.c does it in ep_aio_cancel() -- I can only guess=20
> that this is somehow related to aio and not to anything in USB.

the inode.c looks interesting.c. It got there in 75787d943ab37 ("[PATCH]
USB: gadgetfs AIO support") which is 2004. So it might assume !SMP in
terms of locking. Anyway=E2=80=A6

> > The closest thing we have is local_lock_irq() which maps to
> > local_irq_disable() on !PREEMPT_RT systems. But I would prefer to avoid
> > it because it serves a different purpose.
> > What works is something like
> > 	spin_lock_irqsave();
> > 	spin_unlock();
> > 	$SOMETHING
> > 	spin_lock();
> > 	spin_unlock_irqestore().
>=20
> That's just silly.  We should have something like this:
>=20
> #ifdef CONFIG_PREEMPT_RT
> static inline void local_irqsave_nonrt(unsigned long flags) {}
> static inline void local_irqrestore_nonrt(unsigned long flags) {}
> static inline void local_irq_disable_nonrt() {}
> static inline void local_irq_enable_nonrt() {}
> #else
> #define local_irqsave_nonrt	local_irqsave
> #define local_irqrestore_nonrt	local_irqrestore
> #define local_irq_disable_nonrt	local_irq_disable
> #define local_irq_enable_nonrt	local_irq_enable
> #endif

We managed over the years to get rid of each one of this instances/
requirements. The RT tree used to have
|#ifdef CONFIG_PREEMPT_RT_FULL
|# define local_irq_disable_nort()     do { } while (0)
|# define local_irq_disable_rt()               local_irq_disable()
|#else
|# define local_irq_disable_nort()     local_irq_disable()
|# define local_irq_disable_rt()               do { } while (0)
|#endif

which was removed as of v4.16.7-rt1.
The problem is usually that nobody knows why exactly interrupts are
disabled an what purpose it serves. Often the reasons is no longer there
but the code still does it.

> > The question is why should $SOMETHING be invoked with disabled
> > interrupts if the function was called from process context.
>=20
> More to the point, out of all the possible reasons why $SOMETHING might=
=20
> be invoked with disabled interrupts, which of these reasons remain valid=
=20
> in RT builds and which don't?

None (in most cases) because interrupt handler are threaded. So
interrupts are never truly disabled.
Adding the macros as you suggest would gain probably three users:
- inode
- dummy_hcd
- vhci-hcd

Instead I would:
- vhci I would suggest to remove the disabling and move its completion
   to BH.
- dummy_hcd I would suggest to either do the thing you called silly or
  audit the gadgets and remove it.
- inode I would suggest to keep it as-is and audit it properly later
  once someone intends to use it. It would also give the opportunity to
  clean up the commented locking statement.

> Alan Stern

Sebastian
