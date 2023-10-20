Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739661DA32
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Oct 2023 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id F201CD5F
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Oct 2023 08:19:50 -0700 (PDT)
Received: (qmail 299621 invoked by uid 1000); 20 Oct 2023 11:19:49 -0400
Date: Fri, 20 Oct 2023 11:19:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Li, Meng" <Meng.Li@windriver.com>, Steven Rostedt <rostedt@goodmis.org>,
  Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
References: <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020095238.Z4m-M_oS@linutronix.de>

On Fri, Oct 20, 2023 at 11:52:38AM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-10-19 11:27:54 [-0400], Alan Stern wrote:
> > 
> > Perhaps that what we should do.
> 
> Perfect.

Hmmm...  This turns out not to be as easy as one might think.

Sebastian, if you can instead suggest a way to call drivers' interrupt 
handlers (i.e., simulate an interrupt) without causing problems for RT 
kernels, I think that would be a better approach.

The fundamental problem here is that the uhci-hcd driver was not written 
with unexpected hardware removal in mind.  It doesn't have timeouts to 
handle situations where the device doesn't generate an IRQ to indicate 
completion of an I/O operation.  And since it's been ten years since 
I've done any significant work on the driver, I'd really like to avoid 
the need for such a far-reaching change (not least because I don't have 
any way to test it).

I suppose an alternative approach would be to add a new callback pointer 
to the hc_driver structure -- something that could tell the driver to 
check for hardware removal.  I'll do that if there's no other choice.  
But simulating an interrupt seems easier, provided it can be done at 
all.

Alan Stern
