Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37E315B3
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 01197124
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 08:27:54 -0700 (PDT)
Received: (qmail 261355 invoked by uid 1000); 19 Oct 2023 11:27:54 -0400
Date: Thu, 19 Oct 2023 11:27:54 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Li, Meng" <Meng.Li@windriver.com>, Steven Rostedt <rostedt@goodmis.org>,
  Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>

On Thu, Oct 19, 2023 at 11:09:57AM -0400, Alan Stern wrote:
> On Thu, Oct 19, 2023 at 02:38:23PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2023-10-18 11:20:46 [-0400], Alan Stern wrote:
> > > 
> > > If you hadn't removed the card suddenly, the exception would not have 
> > > occurred.  So the logical conclusion isn't that we should get rid of the 
> > > usb_hcd_irq(0, hcd) call -- the logical conclusion is that you shouldn't 
> > > remove PCIe cards while the system is running.  Not unless your computer 
> > > uses the special hardware from Stratus Technologies.
> > 
> > So the card was removed and the kernel complained that it can't access
> > the memory behind the PCI-bar?
> > 
> > How odd…
> > 
> > > > so I think we don't need to add usb_hcd_irq(0, hcd) on the logical path of unbinding pcie driver.
> > > 
> > > What about cardbus or PCMCIA cards?  Removing one of those cards 
> > > suddenly, while the system is running, is a perfectly reasonable thing 
> > > to do and it will not cause any hardware damage.  So I think we should 
> > > keep the usb_hcd_irq(0, hcd) call.
> > 
> > Don't you invoke pci_driver::remove in such case to properly let the
> > physical device go? This can also be tested via unbind from sysfs.
> 
> I don't know any more.  The code in question was added in 2010 in order 
> to handle a specially designed high-availability hot-swap-capable 
> system, and it may not be relevant now.
> 
> The original problem: When a particular PCI device was disabled (to 
> simulate a failure), pci_driver::remove did not get called.

Oops...  Correction: pci_driver::remove _did_ get called, and the code 
in question is part of the remove handler.

Perhaps putting it there was a mistake.  At the time, I probably thought 
the problem was a general one which might affect all the PCI USB 
controller drivers, but looking back now, it might have been better to 
put in the individual device driver.

Perhaps that what we should do.

Alan Stern

>  Maybe 
> they wanted to have it fail over to a backup device and appear to the 
> kernel as though nothing had happened?  It's hard to tell exactly what 
> was going on thirteen years ago.
> 
> So while this function call may not be needed any more, I prefer to keep 
> it around if that's not too much trouble.
> 
> Alan Stern
> 
