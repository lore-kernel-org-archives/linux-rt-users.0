Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4530D1E;
	Mon, 16 Oct 2023 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E6C433C9;
	Mon, 16 Oct 2023 16:54:49 +0000 (UTC)
Date: Mon, 16 Oct 2023 12:56:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Meng" <Meng.Li@windriver.com>, Ingo Molnar <mingo@redhat.com>, USB
 mailing list <linux-usb@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231016125624.1096766a@gandalf.local.home>
In-Reply-To: <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
	<9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 13:17:52 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -292,6 +292,14 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
>         if (!hcd)
>                 return;
>  
> +       /* Fake an interrupt request in order to give the driver a chance
> +        * to test whether the controller hardware has been removed (e.g.,
> +        * cardbus physical eject).
> +        */
> +       local_irq_disable();
> +       usb_hcd_irq(0, hcd);
> +       local_irq_enable();
> +
>         usb_remove_hcd(hcd);
>         if (hcd->driver->flags & HCD_MEMORY) {
>                 iounmap(hcd->regs);
> 
> The local_irq_disable() is there so that the irq handler will be invoked 
> in the state that it expects (i.e., with interrupts disabled).  
> Apparently Meng's RT kernel doesn't like it when the handler then 
> calls spin_lock(); I don't know why.

Because in RT, spin_lock()s are actually mutexes.

In RT, interrupt handlers do not even run with interrupts disabled (they
run as threads), so the assumption that they run with interrupts disabled
on RT is incorrect. One hack would simply be:

	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
		local_irq_disable();
	usb_hcd_irq(0, hcd);
	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
		local_irq_enable();

But that's rather ugly. We use to have that as a wrapper of just:

	local_irq_disable_nort();

but I don't know if we removed that or not.

Sebastian?

-- Steve
