Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152601D557
	for <linux-rt-users@vger.kernel.org>; Fri,  3 Nov 2023 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 36384A2
	for <linux-rt-users@vger.kernel.org>; Fri,  3 Nov 2023 13:42:19 -0700 (PDT)
Received: (qmail 862562 invoked by uid 1000); 3 Nov 2023 16:42:18 -0400
Date: Fri, 3 Nov 2023 16:42:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Li, Meng" <Meng.Li@windriver.com>, Steven Rostedt <rostedt@goodmis.org>,
  Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
References: <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103154624.WEWPMHTp@linutronix.de>

On Fri, Nov 03, 2023 at 04:46:24PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-10-20 11:19:49 [-0400], Alan Stern wrote:
> > Hmmm...  This turns out not to be as easy as one might think.
> > 
> > Sebastian, if you can instead suggest a way to call drivers' interrupt 
> > handlers (i.e., simulate an interrupt) without causing problems for RT 
> > kernels, I think that would be a better approach.
> 
> So there is generic_handle_irq_safe(). It should get all the details
> right like incrementing the counter in /proc/interrupts, doing nothing
> if the interrupt has been masked or waking the interrupt thread if the
> interrupt has happen to be threaded.
> It triggers the interrupt so for a shared handler it will invoke _all_
> registered interrupt handler and for threaded interrupts it will return
> before the thread had a chance to run (free_irq() will handle it
> properly and wait for the interrupt thread/handler to complete).

Good.  Meng Li, can you test a patch that replaces the
local_irq_disable() - usb_hcd_irq() - local_irq_enable() lines with a
single call to generic_handle_irq_safe()?

> > The fundamental problem here is that the uhci-hcd driver was not written 
> > with unexpected hardware removal in mind.  It doesn't have timeouts to 
> > handle situations where the device doesn't generate an IRQ to indicate 
> > completion of an I/O operation.  And since it's been ten years since 
> > I've done any significant work on the driver, I'd really like to avoid 
> > the need for such a far-reaching change (not least because I don't have 
> > any way to test it).
> 
> I see. Don't over complicate or "correct" things here. What should work
> is that the removal callback can be called at any time and things
> continue work. That means it will purge all queues, cancel all requests,
> timers, whatever and free all resources associated with the driver/
> device.

The driver _does_ work under those circumstances -- provided the
hardware is still present and accessible.

> If it comes to PCI-hotplug you have to have a so called PCI-hotplug
> slot. This "slot" will let the OS know if the hardware has been removed
> or added. If you don't have such a thing you have to maintain the state
> yourself by using the "remove" and "rescan" sysfs files of the PCI slot.
> 
> I'm not aware of any requirement for a PCI-driver to check if its device
> has been removed.

That's the problem: The driver doesn't really support PCI-hotplug.
The code that Meng Li wants to change was sort of a half-baked way to
add such support.

Alan Stern
