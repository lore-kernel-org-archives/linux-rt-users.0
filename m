From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: question about irq_enter()/irq_exit() calling policy
Date: Wed, 30 Nov 2016 11:07:49 -0600
Message-ID: <9c334b42-6b22-397f-93f6-e19e9163a17c@ti.com>
References: <22d0d991-bbe2-ce10-5202-3cdf97a9ecf2@ti.com>
 <20161130102134.GB14217@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130102134.GB14217@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Russell,

On 11/30/2016 04:21 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 29, 2016 at 05:47:12PM -0600, Grygorii Strashko wrote:
>> 2) Should these function be called for each processed irq?
>>
>>
>> HW IRQ:
>>  switch (IRQ mode)
>>   ...
>>   while (irq = get_pending_irq()) {
>>   	...
>>   	irq_enter()
>> 		handle(irq) - execute hw_irq_hadler
>>   	irq_exit()
>>  }
>>  ...
>>  switch
> 
> We tend to do (2) as a general rule, which isn't much different from what
> other architectures do - even if they have a method to directly enter
> through vectors (eg, x86) the effect of two pending interrupts is that one
> will run after each other, and there will be an intervening exit -> entry.
> 
> In the case of ARM CPUs, if the interrupt signal is active, you vector
> back to the interrupt handler as soon as you exit back to the parent
> context without executing any parent context instructions.
> 
> So, we have the choice of going through all the IRQ entry code, processing
> one interrupt, and returning only to then re-vector back through the IRQ
> entry code, or we can process all the pending IRQs that we can see at that
> time.
> 
> The former method wastes all the CPU cycles getting from the parent context
> to the IRQ context for each and every interrupt.
> 

Thanks a lot for your detailed explanation.
When I've asked this question my intention was to understand possibility of calling 
irq_enter()/irq_exit() only once for the case (2), like:
 HW IRQ:
  switch (IRQ mode)
   ...
  irq_enter()
   while (irq = get_pending_irq()) {
   	...
 	handle(irq) - execute hw_irq_hadler
  }
  irq_exit()
  ...
  switch

-- 
regards,
-grygorii
