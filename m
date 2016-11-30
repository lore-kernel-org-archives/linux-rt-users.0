From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: question about irq_enter()/irq_exit() calling policy
Date: Wed, 30 Nov 2016 10:21:34 +0000
Message-ID: <20161130102134.GB14217@n2100.armlinux.org.uk>
References: <22d0d991-bbe2-ce10-5202-3cdf97a9ecf2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22d0d991-bbe2-ce10-5202-3cdf97a9ecf2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 29, 2016 at 05:47:12PM -0600, Grygorii Strashko wrote:
> 2) Should these function be called for each processed irq?
> 
> 
> HW IRQ:
>  switch (IRQ mode)
>   ...
>   while (irq = get_pending_irq()) {
>   	...
>   	irq_enter()
> 		handle(irq) - execute hw_irq_hadler
>   	irq_exit()
>  }
>  ...
>  switch

We tend to do (2) as a general rule, which isn't much different from what
other architectures do - even if they have a method to directly enter
through vectors (eg, x86) the effect of two pending interrupts is that one
will run after each other, and there will be an intervening exit -> entry.

In the case of ARM CPUs, if the interrupt signal is active, you vector
back to the interrupt handler as soon as you exit back to the parent
context without executing any parent context instructions.

So, we have the choice of going through all the IRQ entry code, processing
one interrupt, and returning only to then re-vector back through the IRQ
entry code, or we can process all the pending IRQs that we can see at that
time.

The former method wastes all the CPU cycles getting from the parent context
to the IRQ context for each and every interrupt.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
