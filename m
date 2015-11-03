From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new
 generic_handle_irq_rt_wa() api
Date: Tue, 3 Nov 2015 21:11:01 +0200
Message-ID: <563906C5.8030801@ti.com>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
 <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
 <alpine.DEB.2.11.1511022036500.4032@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1511022036500.4032@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/02/2015 09:38 PM, Thomas Gleixner wrote:
> On Mon, 2 Nov 2015, Grygorii Strashko wrote:
>> Now in kernel below code pattern is used by many drivers:
>> static irqreturn_t driver_xx_hw_irq_handler(int irq, void *arg)
>> {
>> 	<read IRQ status register>
>>    	<perform HW specific operations>
>>
>> 	for (<each set bit in IRQ status register>) {
>> 		<get Linux IRQ number>
>> 		generic_handle_irq(<Linux IRQ number>);
>> 		|- handle_simple_irq()
>> 		|-or- handle_level_irq()
>> 		|-or- handle_edge_irq()
>> 		   |-handle_irq_event()
>> 		     |-handle_irq_event_percpu()
>> ===
>> "WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
>>   irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts"
>> ===
>> 	}
>> }
>>
>> On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
>> will be forced threaded (by default) and, as result, generic_handle_irq()
>> will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
>> be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).
>>
>> Instead of spreading this W/A directly in many drivers this patch
>> introduces -RT specific version of generic_handle_irq() API -
>> generic_handle_irq_rt_wa(). This new generic_handle_irq_rt_wa() just calls
>> generic_handle_irq() surrounded by raw_spin_lock_irqsave/irqrestore().
>> If -RT is disabled It will fallback to generic_handle_irq().
> 
> Why aren't you simply marking these demultiplex handlers with IRQ_NO_THREAD?
> 

In general, it's possible. But, in this case, worst scenario will look like:
dra7xx_pcie_msi_irq_handler()
-> dw_handle_msi_irq()
   [code simplified]
   -> for (i = 0; i < MAX_MSI_IRQS; i++) {
	...
	generic_handle_irq(Y(i));
	...
   }
where MAX_MSI_IRQS = 32 now, but potentially can be increased up to 256.

Thanks.
-- 
regards,
-grygorii
