From: Manfred Gruber <m.gruber@unverspurt.at>
Subject: Re: pca953x - warning on irq
Date: Tue, 27 Dec 2011 10:33:04 +0100
Message-ID: <201112271033.17286.m.gruber@unverspurt.at>
References: <201112251740.11066.m.gruber@unverspurt.at> <CAM2zO=DdGSJm0J2RNaWQ4ROx2-sK8_qT9QBbT5po9uW=SHR8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.hessware.de ([78.46.97.14]:35433 "EHLO mail.hessware.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab1L0JdZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Dec 2011 04:33:25 -0500
In-Reply-To: <CAM2zO=DdGSJm0J2RNaWQ4ROx2-sK8_qT9QBbT5po9uW=SHR8ng@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Yong Zhang!

Thx a lot, that fix removed the warning on 3.0.14-rt31+.

Regards Manfred

Am Tuesday 27 December 2011 schrieb Yong Zhang:
> On Mon, Dec 26, 2011 at 12:40 AM, Manfred Gruber <m.gruber@unverspurt.at> 
wrote:
> > Hello RT developers!
> > 
> > Great work on Preempt RT!
> > 
> > I get a warning at 3.0.9-rt25+ in a i2c pca953x chip when using IRQs at
> > the gpio lines. It appears only once when the first irq happens, after
> > that the warning is away. On 3.2.0-rc7 the warning does not happen.
> > 
> > I do not know how to remove/solve the warning, has someone an idea what I
> > do wrong?
> 
> Could you please try upstream commit [6dd599f8: gpio/pca953x: Fix warning
> of enabled interrupts in handler] ?
> 
> BTW, I think that commit should go to -stable.
> 
> Thanks,
> Yong
> 
> > [   28.616000] sd 1:0:0:0: [sdb] Attached SCSI removable disk
> > [   45.240000] ------------[ cut here ]------------
> > [   45.240000] WARNING: at kernel/irq/handle.c:130
> > handle_irq_event_percpu+0x68/0x168()
> > [   45.240000] irq 130 handler irq_default_primary_handler+0x0/0x8
> > enabled interrupts
> > [   45.242000] Modules linked in:
> > [   45.242000] [<c0039cd8>] (unwind_backtrace+0x0/0xec) from [<c00473d4>]
> > (warn_slowpath_common+0x4c/)
> > [   45.242000] [<c00473d4>] (warn_slowpath_common+0x4c/0x64) from
> > [<c0047480>] (warn_slowpath_fmt+0x3)
> > [   45.242000] [<c0047480>] (warn_slowpath_fmt+0x30/0x40) from
> > [<c0078264>] (handle_irq_event_percpu+)
> > [   45.242000] [<c0078264>] (handle_irq_event_percpu+0x68/0x168) from
> > [<c00783b8>] (handle_irq_event+)
> > [   45.242000] [<c00783b8>] (handle_irq_event+0x54/0x78) from
> > [<c007a828>] (handle_simple_irq+0x84/0x)
> > [   45.242000] [<c007a828>] (handle_simple_irq+0x84/0xac) from
> > [<c0077eb0>] (generic_handle_irq+0x30/)
> > [   45.242000] [<c0077eb0>] (generic_handle_irq+0x30/0x48) from
> > [<c0168508>] (pca953x_irq_handler+0x9)
> > [   45.242000] [<c0168508>] (pca953x_irq_handler+0x98/0xac) from
> > [<c0078930>] (irq_thread_fn+0x1c/0x3)
> > [   45.242000] [<c0078930>] (irq_thread_fn+0x1c/0x38) from [<c00787ec>]
> > (irq_thread+0xc8/0x1f0)
> > [   45.242000] [<c00787ec>] (irq_thread+0xc8/0x1f0) from [<c006082c>]
> > (kthread+0x7c/0x84)
> > [   45.242000] [<c006082c>] (kthread+0x7c/0x84) from [<c00358dc>]
> > (kernel_thread_exit+0x0/0x8)
> > [   45.242000] ---[ end trace 0000000000000002 ]---
> > 
> > # cat /proc/interrupts
> >           CPU0
> >  1:       8340       AIC  ttyS0
> >  7:          2       AIC  ttyS2
> >  9:        327       AIC  mmc0
> >  12:      22381       AIC  atmel_spi.0
> >  13:      74311       AIC  atmel_spi.1
> >  19:     245940       AIC  tc_clkevt
> >  20:        541       AIC  ohci_hcd:usb1
> >  21:          2       AIC  eth0
> > 103:          5      GPIO  0-0070
> > 128:          0   pca953x  gpiolib
> > 129:          0   pca953x  gpiolib
> > 130:          2   pca953x  gpiolib
> > 131:          0   pca953x  gpiolib
> > 132:          0   pca953x  gpiolib
> > 
> > thx, regards manfred gruber
> > 
> > --
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
mfg
	Manfred Gruber
	m.gruber@unverspurt.at
	http://www.unverspurt.at
