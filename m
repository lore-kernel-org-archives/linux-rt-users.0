Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CE1C2B6;
	Fri,  3 Nov 2023 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9jZs2it";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtn8Zxm7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE625A6;
	Fri,  3 Nov 2023 08:46:26 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:46:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699026385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+1CRt1917HHw3pLNlKBXO0zVNN0Ea4qtcbWbWLFu/Y=;
	b=i9jZs2itnJsYLKKR+bl4MfVIjX4RZW0rdDJ3CTlsfWrhXDtbjl+ZimGG1Vj50cBNpQjbhi
	EHlnlk0B20he+oac6ZeoWs/ThI4VwvPsJaMvQ4hOzHvwE+qM7Y0X4Mf+Y/6cj+L3mf6Eh2
	hArJiLos5KylASvZCbbKea5Bkm9OKyg1IlMl0q73xBDAtRwac8GTdfgAbP0c5d0Yf6mYI+
	3ESyOeedoLKTM9lsHs4cg9O53b0d945aP2odeDExdt7OeqvhrvjMC3IISn0OUMlnq190WP
	lCQwxu2ulnL1JQTCPuI6gWrQvTNICvkI8BvGi112bKZ6Vf56D0OvW7wXYYRTBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699026385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+1CRt1917HHw3pLNlKBXO0zVNN0Ea4qtcbWbWLFu/Y=;
	b=mtn8Zxm7oxzCzqwD0LyJUqGmWYO/Xtb2G1VSKYhgkd0GrzNgI+7FjZJjaw/5unFDZEbsnc
	2WfU4R+IA2PkHpCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Meng" <Meng.Li@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231103154624.WEWPMHTp@linutronix.de>
References: <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>

On 2023-10-20 11:19:49 [-0400], Alan Stern wrote:
> Hmmm...  This turns out not to be as easy as one might think.
> 
> Sebastian, if you can instead suggest a way to call drivers' interrupt 
> handlers (i.e., simulate an interrupt) without causing problems for RT 
> kernels, I think that would be a better approach.

So there is generic_handle_irq_safe(). It should get all the details
right like incrementing the counter in /proc/interrupts, doing nothing
if the interrupt has been masked or waking the interrupt thread if the
interrupt has happen to be threaded.
It triggers the interrupt so for a shared handler it will invoke _all_
registered interrupt handler and for threaded interrupts it will return
before the thread had a chance to run (free_irq() will handle it
properly and wait for the interrupt thread/handler to complete).

> The fundamental problem here is that the uhci-hcd driver was not written 
> with unexpected hardware removal in mind.  It doesn't have timeouts to 
> handle situations where the device doesn't generate an IRQ to indicate 
> completion of an I/O operation.  And since it's been ten years since 
> I've done any significant work on the driver, I'd really like to avoid 
> the need for such a far-reaching change (not least because I don't have 
> any way to test it).

I see. Don't over complicate or "correct" things here. What should work
is that the removal callback can be called at any time and things
continue work. That means it will purge all queues, cancel all requests,
timers, whatever and free all resources associated with the driver/
device.

If it comes to PCI-hotplug you have to have a so called PCI-hotplug
slot. This "slot" will let the OS know if the hardware has been removed
or added. If you don't have such a thing you have to maintain the state
yourself by using the "remove" and "rescan" sysfs files of the PCI slot.

I'm not aware of any requirement for a PCI-driver to check if its device
has been removed.

> I suppose an alternative approach would be to add a new callback pointer 
> to the hc_driver structure -- something that could tell the driver to 
> check for hardware removal.  I'll do that if there's no other choice.  
> But simulating an interrupt seems easier, provided it can be done at 
> all.
> 
> Alan Stern

Sebastian
