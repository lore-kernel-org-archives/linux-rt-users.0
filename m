Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83073451D2;
	Tue, 19 Aug 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598889; cv=none; b=NVSHbh7cpqHLKQfLz4tOoqsFnIQrlyyywyxazKJAJxwBEAh1r9D+Wg/ovo25os2wI0j136Uvg43iR/KLM89W1YRgKop7lCF5RH89wXOH7F4oU7reglGwUgJYVchK48bfflLcS8NifqeDjjDIunkAfXObrjp1JkZ3ick3Yzd5rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598889; c=relaxed/simple;
	bh=rRqk9njGn48z615Rr5gmeoeW2PcgQLl2A9aZ7ED0mu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8DRgE+JzY2KHkfhEmkVk+p7oaNqwAxWvcELnSRbAoIBcldSegeV5bfKZqKl8bD6L18MpbFBU0VgBwomuIC8hFPwYwcer61gQioaLEP4tRg1onraSgPjOF9e7Wj5ewicHA2JbNq0mPGWhQsnDWMXKTrhJlz/YJsayA9o/nydtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQM38gBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3SPVIau; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQM38gBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3SPVIau"
Date: Tue, 19 Aug 2025 12:21:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755598885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sd1NbSqSUSHxU54jSrNDalpf8ONqHH3DQZD09RzfBWM=;
	b=LQM38gBgcRmJF24jHmc27bvLn2Hk60/XBsuvIDxQL1tNWGFMTDOcWKDLI1R1VR+zgEbuDR
	kmgaWDboqqCGL13CztQRHciWdDP3T92S3jMj2Dmzdx6Q2MklTay9ZNbm4rFcXSqvA4+gO6
	YEqqlVA3m1Gzmu9afnW9M/sc8i2NB7TrHcL7m9sxxWFoPWglVQ02FFzQ8vPwuqbf3xYHVR
	YyI2V+hp9wi6wKu2XGFEkW2yyFKg63x9bMwYUkS9Hnh4IlcUwZxiUq++7WUjLYp7nOBd2r
	KBmfZ79K7Bis/G1J43bObMZhvCZHlaIg0GGningphQQcoJ3PGo2lI9g20Ok1OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755598885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sd1NbSqSUSHxU54jSrNDalpf8ONqHH3DQZD09RzfBWM=;
	b=C3SPVIauGLe8408fq+HxrmLRQrTutc2xTJUFDGY1HmP8Y3pwo2fiFWHg/YS7DyJMPwGMr+
	91AEgGX19OnrXPDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Yunseong Kim <ysk@kzalloc.com>, gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Al Viro <viro@zeniv.linux.org.uk>, andreyknvl@gmail.com,
	Austin Kim <austindh.kim@gmail.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [BUG] usb: gadget: dummy_hcd: Sleeping function called from
 invalid context in dummy_dequeue on PREEMPT_RT
Message-ID: <20250819102124.O6E7YfEJ@linutronix.de>
References: <5b337389-73b9-4ee4-a83e-7e82bf5af87a@kzalloc.com>
 <20250816065933.EPwBJ0Sd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250816065933.EPwBJ0Sd@linutronix.de>

On 2025-08-16 08:59:33 [+0200], Nam Cao wrote:
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 21dbfb0b3bac..a4653c919664 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -765,8 +765,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  	if (!dum->driver)
>  		return -ESHUTDOWN;
>  
> -	local_irq_save(flags);
> -	spin_lock(&dum->lock);
> +	spin_lock_irqsave(&dum->lock, flags);
>  	list_for_each_entry(iter, &ep->queue, queue) {
>  		if (&iter->req != _req)
>  			continue;
> @@ -776,15 +775,16 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  		retval = 0;
>  		break;
>  	}
> -	spin_unlock(&dum->lock);
> +	spin_unlock_irqrestore(&dum->lock, flags);

The two above are fine.

>  	if (retval == 0) {
>  		dev_dbg(udc_dev(dum),
>  				"dequeued req %p from %s, len %d buf %p\n",
>  				req, _ep->name, _req->length, _req->buf);
> +		local_irq_save(flags);
>  		usb_gadget_giveback_request(_ep, _req);
> +		local_irq_restore(flags);

This is not. I don't see the need for it. The queue part does
	spin_lock_irqsave()
	spin_unlock();
	usb_gadget_giveback_request()
	spin_lock();
	spin_unlock_irqrestore();

and keeps the interrupts disabled during callback invocation. This seems
to be just to unify the code vs the else path.

>  	}
> -	local_irq_restore(flags);
>  	return retval;
>  }

Sebastian
