Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AA28DCF
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Nov 2023 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A77AD13E
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Nov 2023 07:25:39 -0800 (PST)
Received: (qmail 950808 invoked by uid 1000); 6 Nov 2023 10:25:38 -0500
Date: Mon, 6 Nov 2023 10:25:38 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Li, Meng" <Meng.Li@windriver.com>, Steven Rostedt <rostedt@goodmis.org>,
  Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: RE: USB: add check to detect host controller hardware removal
Message-ID: <cec71b9d-728f-4491-b14a-1a78ec9542ab@rowland.harvard.edu>
References: <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106082829.iBvQ9hCY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106082829.iBvQ9hCY@linutronix.de>

On Mon, Nov 06, 2023 at 09:28:29AM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-11-06 03:02:42 [+0000], Li, Meng wrote:
> > > Good.  Meng Li, can you test a patch that replaces the
> > > local_irq_disable() - usb_hcd_irq() - local_irq_enable() lines with a single call to
> > > generic_handle_irq_safe()?
> > 
> > It needs an irq number as parameter, what I should pass to this
> > function, 0 or dev->irq or other value?
> 
> dev->irq is what it asks for.

In fact it should be hcd->irq -- see usb_hcd_request_irqs().  Maybe this 
is the same value as dev->irq; I don't know.

> I would really appreciate if you would
> instead use the sysfs interface to remove the device prior physically
> removing it. This should solve your trouble.

The whole reason for having this code in the first place -- the specific 
use case -- was to handle device removal caused by sudden hardware 
failure.  Obviously there's no way to use the sysfs interface before 
this occurs.

Alan Stern
