From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.1.10-rt10][PATCH 0/2] PCI: dra7xx/dwc: fix "WARNING: CPU: 1
 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu"
Date: Tue, 3 Nov 2015 21:11:10 +0200
Message-ID: <563906CE.6090707@ti.com>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
 <5638BAAE.6050909@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5638BAAE.6050909@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/03/2015 03:46 PM, Sebastian Andrzej Siewior wrote:
> On 11/02/2015 08:30 PM, Grygorii Strashko wrote:
>> On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
>> will be forced threaded (by default) and, as result, generic_handle_irq()
>> will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
>> be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).
> 
> and what happens without -RT if you boot threadedirqs?
> 

Yep. It will still warn :( Can be reworked to cover this case also, i think
(if overall concept will be accepted) 


Thanks.
-- 
regards,
-grygorii
