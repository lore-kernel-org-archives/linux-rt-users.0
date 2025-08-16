Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2953176F0;
	Sat, 16 Aug 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327587; cv=none; b=SBUgDIJ2YR6TY6UJvdUAnphAeHBTnTnw0To8Cn6WmrHxb95hW84QxtOhS0FnTjmLtjz327pw0f7NRdHz6GXgSLb51HyhGeNSlEgmJO9ZOxLfQTwi0hPXRwRLY/dxokaFFb/H9SH0CbD9zefu0aO9+j2g+4JfjWji8fj2ufKbGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327587; c=relaxed/simple;
	bh=WlA2MdWzrUL96f7KUYM6sdeESTS9cAPMHbk5ZlsxiSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7bQZhh6aFjWpwNPyFT3GBhsGOt3drof7h3aPICiBXRAr4H8ITKNRbleaeG9asP2J0sEx6BvO/kj+ExpNUA+jE2e1adn46Z9F0vl3mbTXMcvRqZ4+NPFUTZtdz62pMfdQGmmAW46iuoiv3J5zg/rXMUdUTdtCOFxQRkzKGvH/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOlEzCDs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9IRpo1lA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOlEzCDs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9IRpo1lA"
Date: Sat, 16 Aug 2025 08:59:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755327582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+XdKT3RbO38yzmJe2zUDEOluaw1lQbYnVyhey9SPCE=;
	b=pOlEzCDsFStS31E40StT1IcwZwxm66QdSZCgsE0MfPOJdUbf1P8u7xa02mCFNpXhXHs25Y
	B53BhSzS65HVm68WEqMe61djldpLTnJlZxd4R5lTYJhCpiobWFlFe22wV4ymaa0oWwIoUY
	IP/tJqNncYFm9p9IGrIKJJhz8OoVjOo9/nelhOLCJlENuthG9Ti+NyJjXxA2T5VnU2AlKP
	v4F6lZSYDtQx52XXZOLNzrNxm+LCwsq1nTS4jQ2tdN/Cgq/WhgFfsUxqvyEN/dNmYYESXk
	Me3tLfjB0MFfHGwOlICgvQw01BN2hZLp4an6NFgS0jPXcTMo43xPi2Fe5yxSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755327582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+XdKT3RbO38yzmJe2zUDEOluaw1lQbYnVyhey9SPCE=;
	b=9IRpo1lA20bMsMMBZgZrdkRdS3ox1N+EY4B1DKHyzjTAQk8lhYnlwN7yjclndCyepDgiqE
	uk3ByFCZaRqtVYCw==
From: Nam Cao <namcao@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Al Viro <viro@zeniv.linux.org.uk>, andreyknvl@gmail.com,
	Austin Kim <austindh.kim@gmail.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [BUG] usb: gadget: dummy_hcd: Sleeping function called from
 invalid context in dummy_dequeue on PREEMPT_RT
Message-ID: <20250816065933.EPwBJ0Sd@linutronix.de>
References: <5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com>

On Sat, Aug 16, 2025 at 11:38:14AM +0900, Yunseong Kim wrote:
> While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
> I encountered a "BUG: sleeping function called from invalid context" error
> originating from the dummy_dequeue function in the dummy USB driver.
...
> The pattern of manually disabling IRQs and then taking a spinlock
> local_irq_save() + spin_lock() is unsafe on PREEMPT_RT, the current code
> structure keeps IRQs disabled even after spin_unlock(&dum->lock) while
> calling usb_gadget_giveback_request(). This extended atomic context can
> also be problematic if the completion handler attempts to acquire another
> sleepable lock.

I don't know the USB subsystem well, but the comments above struct
usb_request says:

 * @complete: Function called when request completes, so this request and
 *	its buffer may be re-used.  The function will always be called with
 *	interrupts disabled, and it must not sleep.

Therefore it shouldn't be a concern that "completion handler attempts to
acquire another sleepable lock".

> I request a review and correction of this locking mechanism to ensure
> stability on PREEMPT_RT configurations.  Kernel config, full logs, and
> reproduction steps can be provided on request.

This was introduced by b4dbda1a22d2 ("USB: dummy-hcd: disable interrupts
during req->complete") which split the spin_lock_irqsave() into
local_irq_save() and spin_lock().

The untested patch below should help?

Enabling interrupt (spin_unlock_irqrestore) and then immediately disabling
interrupt (local_irq_save) is not the nicest thing. But then I don't see
how to avoid that while being non-hacky and human-readable.

Nam

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 21dbfb0b3bac..a4653c919664 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -765,8 +765,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 	list_for_each_entry(iter, &ep->queue, queue) {
 		if (&iter->req != _req)
 			continue;
@@ -776,15 +775,16 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		retval = 0;
 		break;
 	}
-	spin_unlock(&dum->lock);
+	spin_unlock_irqrestore(&dum->lock, flags);
 
 	if (retval == 0) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
+		local_irq_save(flags);
 		usb_gadget_giveback_request(_ep, _req);
+		local_irq_restore(flags);
 	}
-	local_irq_restore(flags);
 	return retval;
 }
 
