Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A6347B9
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 3AB8C98
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 08:20:47 -0700 (PDT)
Received: (qmail 224344 invoked by uid 1000); 18 Oct 2023 11:20:46 -0400
Date: Wed, 18 Oct 2023 11:20:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Li, Meng" <Meng.Li@windriver.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
  USB mailing list <linux-usb@vger.kernel.org>,
  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 05:00:58AM +0000, Li, Meng wrote:
> > Were you able to locate the original bug report?
> > 
> This is original bug report
> https://bugzilla.redhat.com/show_bug.cgi?id=579093

The Red Hat Bugzilla says:

	You are not authorized to access bug #579093.

So I can't tell exactly what happened back then.  :-(

But I do vaguely remember the discussion with Stratus Technologies.  
They had special hardware in their systems, which allowed them to do 
hot-swapping of PCI components.

> my latest debug information as below:
> when I removed the PCIe-USB card, there is below exception calltrace when operating host controller register.
> Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT_RT SMP
> Modules linked in:
> CPU: 3 PID: 329 Comm: usb-storage Tainted: G        W          6.1.53-rt10-yocto-preempt-rt #1
> Hardware name: LS1043A RDB Board (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : xhci_ring_ep_doorbell+0x78/0x120
> lr : xhci_queue_bulk_tx+0x3b0/0x8a4
> sp : ffff80000b0e3960
> x29: ffff80000b0e3960 x28: ffff000004ce2290 x27: ffff000008e71100
> x26: ffff000005718a80 x25: 0000000000000421 x24: 000000000000001f
> x23: ffff000008e71108 x22: 0000000000000000 x21: ffff8000099e5100
> x20: 0000000000000002 x19: 0000000000000004 x18: 0000000000000000
> x17: 0000000000000008 x16: ffff00007b5cfb00 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
> x11: 0000000000000001 x10: 0000000000000a40 x9 : ffff8000089b0b50
> x8 : ffff0000057c9a00 x7 : 000000000000001f x6 : ffff0000056c8000
> x5 : ffff800009714ca0 x4 : 0000000000000004 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff8000099e5108 x0 : ffff000004ce2290
> Call trace:
>  xhci_ring_ep_doorbell+0x78/0x120
>  xhci_queue_bulk_tx+0x3b0/0x8a4
>  xhci_urb_enqueue+0x274/0x510
>  usb_hcd_submit_urb+0xc0/0x8b0
>  usb_submit_urb+0x29c/0x5c0
>  usb_stor_msg_common+0x9c/0x190
>  usb_stor_bulk_transfer_buf+0x58/0x110
>  usb_stor_Bulk_transport+0xdc/0x380
>  usb_stor_invoke_transport+0x40/0x530
>  usb_stor_transparent_scsi_command+0x18/0x24
>  usb_stor_control_thread+0x20c/0x2a0
>  kthread+0x12c/0x130
>  ret_from_fork+0x10/0x20
> Code: 540001cc 8b140aa1 d5033ebf b9000033 (b9400021) 
> ---[ end trace 0000000000000000 ]---
> Because of the exception, the xhci->lock in xhci_urb_enqueue is released normally.
> In this situation, if remove the pcie device with below command
> # echo 1 > /sys/bus/pci/devices/<PCIe ID>/remove
> The code will hang at the xhci->lock in xhci_urb_dequeue() function.
> Even if I refer to commit c548795abe0d, move usb_hcd_irq(0, hcd) to function xhci_pci_remove(),
> there is also an exception calltrace("Internal error: synchronous external abort") when executing readl(&xhci->op_regs->status);
> although the code doesn't hang, the exception causes that code is broken from xhci_pci_remove(), the flowing code is not executed.
> Because usb_hcd_irq(0, hcd) causes exception, I think it should be removed. 
> In additional, removing PCIe card suddenly is not a reasonable operation, it may destroy the hardware.

If you hadn't removed the card suddenly, the exception would not have 
occurred.  So the logical conclusion isn't that we should get rid of the 
usb_hcd_irq(0, hcd) call -- the logical conclusion is that you shouldn't 
remove PCIe cards while the system is running.  Not unless your computer 
uses the special hardware from Stratus Technologies.

> so I think we don't need to add usb_hcd_irq(0, hcd) on the logical path of unbinding pcie driver.

What about cardbus or PCMCIA cards?  Removing one of those cards 
suddenly, while the system is running, is a perfectly reasonable thing 
to do and it will not cause any hardware damage.  So I think we should 
keep the usb_hcd_irq(0, hcd) call.

Alan Stern
