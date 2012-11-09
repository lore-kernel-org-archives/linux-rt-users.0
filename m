From: Till Straumann <strauman@slac.stanford.edu>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Fri, 09 Nov 2012 11:27:52 -0600
Message-ID: <509D3D18.5040902@slac.stanford.edu>
References: <509C3220.2050601@slac.stanford.edu> <201211090012.32207.tim01@vlsi.informatik.tu-darmstadt.de> <509C540F.3050108@slac.stanford.edu> <201211091518.36344.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.alumni.tu-berlin.de ([130.149.4.13]:58720 "EHLO
	mailbox.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755117Ab2KIR15 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Nov 2012 12:27:57 -0500
In-Reply-To: <201211091518.36344.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tim.

Thanks very much for the example. Being paranoid, it raises
one more question, though:

You say

     priv->wakeupTask=current;
     set_current_state(TASK_INTERRUPTIBLE);
     schedule();

but is it not necessary to take a raw_spin_lock_irqsave()
around storing the task pointer and changing the task
state? To be more precise: around starting the device
and setting the task state. I would have thought I would
have to code like this:

      priv->wakeupTask = current;
      raw_spin_lock_irqsave(...)
        start_device();
        /* What happens if a fast device would interrupt here
         * without the raw spinlock? Would I not sleep forever?
         */
        set_current_state(TASK_INTERRUPTIBLE);
      raw_spin_unlock_irqrestore(...)
      schedule();

Assuming that an IRQ could happen any time once the device
is started - don't I have to avoid giving the the hard-isr the
chance of executing wake_up_process() before
set_current_state(TASK_INTERRUPTIBLE) has finished?

Thanks again
- Till

On 11/09/2012 08:18 AM, Tim Sander wrote:
> Hi Till
>>>> What *is* the recommended mechanism to wake up a thread from
>>>> a hard-isr?
>>> I think its the waitqueue mechanism with the drawbacks you mentioned.
>> I thought I can't wake_up() from a hard-isr so that can hardly be
>> the recommended mechanism (unless you mean I *should* go
>> via the 'irq_thread' (kernel/irq/management.c) and wake my
>> user-land thread from there).
> For multiple waiters i don't know any other solution than the irq-thread
> mechanism with the additional delay.
>
>> The IRQ management code must use something to let the
>> hard-isr unblock the irq-handler kthread - I'd like to use the same
>> (or a similar) method to let the hard-isr unblock a user-land
>> thread.
>>
>>> If you only want to wake up *one* usermode thread there is a hack
>>> possible to save the context switch times to the bottom half interrupt
>>> thread?
>> What would such a hack be?
> Credits go to Thomas Gleixner for this hack (Keep in mind it only works
> for a *single* waiter, so your driver should probably only allow exclusive
> opens of this device.)
> Define a structure:
>
>      struct task_struct *wakeupTask;
>
> In the read routine which should wait for the interrupt pulse:
> 	priv->wakeupTask=current;
>      set_current_state(TASK_INTERRUPTIBLE);
>      schedule();
> 	//i'll be back :-)
> 	retval = copy_to_user(...);
> 	__set_current_state(TASK_RUNNING);
>
> And in isr context just do a:
> 	wake_up_process(current_instance->wakeupTask);
>
> Best regards
> Tim

