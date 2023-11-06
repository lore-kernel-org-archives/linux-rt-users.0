Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F414A8B;
	Mon,  6 Nov 2023 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEdpaU7N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PQL0GVA"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1CD57;
	Mon,  6 Nov 2023 00:28:32 -0800 (PST)
Date: Mon, 6 Nov 2023 09:28:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699259310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnuRlbofG+XYu59WDYylv/HXxOnMRaiF/0sGwUk9oKs=;
	b=eEdpaU7NDjZbGKhVTQFKRXMwPp2Agc2tEeCDjt9VHpQ5BytbDtgZtO5qqnH5k4ArHut6qK
	yZc5vvqtPmX1BUVjnwnESob1TY1bRsXmA2PamGOzj5LiqK5oA3Du4njHMIJwdiK5ku0VhK
	Y0GB4p01Z+7hF46LecGySraKZ8LkJ+16/1DrAx3W0XE8+zRcVXzU7lVzkLZDEAwBC8Xw7f
	apr7sPofqs1g4B14M+WTHKod8nhMbnMAtjAYHspq+RMaE0l8IS82m9sOhgO4+3zlCgp/Ay
	2oCcM2QqMCDRZQHEJvapwUqj4s3LEO3le+Rc7s6o5Iw9SEnznMcFG2B/caAGbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699259310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnuRlbofG+XYu59WDYylv/HXxOnMRaiF/0sGwUk9oKs=;
	b=8PQL0GVA+sjuwC6Af4+8R7kxpvA1LpcwTLuQ7cEcZkH9jC9E9C2LElRwhc9Y00sTGy6plS
	pTFqY1PN4chubeDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Li, Meng" <Meng.Li@windriver.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: RE: USB: add check to detect host controller hardware removal
Message-ID: <20231106082829.iBvQ9hCY@linutronix.de>
References: <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>

On 2023-11-06 03:02:42 [+0000], Li, Meng wrote:
> > Good.  Meng Li, can you test a patch that replaces the
> > local_irq_disable() - usb_hcd_irq() - local_irq_enable() lines with a single call to
> > generic_handle_irq_safe()?
> 
> It needs an irq number as parameter, what I should pass to this
> function, 0 or dev->irq or other value?

dev->irq is what it asks for. I would really appreciate if you would
instead use the sysfs interface to remove the device prior physically
removing it. This should solve your trouble.

> Thanks,
> Limeng

Sebastian
