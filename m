From: "Rolenc, Dave" <drolenc@rtlogic.com>
Subject: Re: latency issue on wait_event/wake_up calls.
Date: Wed, 2 May 2012 20:02:00 -0600
Message-ID: <F63D7A2C-593C-44C4-AD1D-5FFC82F5D5F2@rtlogic.com>
References: <4F9BC6D3.8030203@tribudubois.net>
 <4FA1819F.5060407@tribudubois.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 207-109-164-49.dia.static.qwest.net ([207.109.164.49]:42660
	"EHLO spam.rtlogic.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755757Ab2ECCUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 22:20:53 -0400
Received: from spam.rtlogic.com (127.0.0.1) id hk7loa0171su for <linux-rt-users@vger.kernel.org>; Wed, 2 May 2012 20:02:04 -0600 (envelope-from <drolenc@rtlogic.com>)
In-Reply-To: <4FA1819F.5060407@tribudubois.net>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It sounds like what you really want it to set yours to sched_fifo 50 to match the IRQ handlers priority, since you are not wanting it to be interrupted when it has data to process.

Dave



On May 2, 2012, at 12:49, "Jean-Christophe DUBOIS" <jcd@tribudubois.net> wrote:

> Hi,
> 
> Sorry to insist but would anybody have a clue on the fact that this 
> behavior is expected and/or if there is a way arround it beside changing 
> the priority dynamically.
> 
> Thanks
> 
> JC
> 
> On 28/04/2012 12:30, Jean-Christophe DUBOIS wrote:
>> Hello,
>> 
>> I need help/advice on a little "performance" problem I have:
>> 
>> I am using linux 3.0.3 with the related RT patch on an ARM9 processor.
>> 
>> I have a RT task which is reading from a driver. The RT task is 
>> blocked on wait_event_interruptible() and the driver interrupt handler 
>> is releasing the waiting task using wake_up_interruptible() when there 
>> is data available.
>> 
>> By default on linux RT, driver IRQ handlers are run in threads with a 
>> priority of 50.
>> 
>> At first I setup my RT task with a priority of 10.
>> 
>> When some data are received by the system, I can see the following 
>> scheduling (using LTTng).
>> 
>> - irq_handler
>> - my_driver_irq_handler (priority 50)
>> - my_task (priority 10)
>> 
>> This is all good but I really need "my_task" to be high priority. Once 
>> an event is received, it need to process it immediately without being 
>> interrupted by further events coming on the device.
>> 
>> So now, I set my_task priority to 80. Now when data is received, I can 
>> see the following scheduling (still using LTTng).
>> 
>> - irq_handler
>> - my_driver_irq_handler (priority 50)
>> - my_task (priority 80) // this is a short run. I assume the task is 
>> checking the wait() "condition"
>> - my_driver_irq_handler (priority 80) // here there seems to be an 
>> "automatic" priority inversion to allow the handler to run and finish 
>> the wake_up call
>> - my_task (priority 80) // run until it blocks again
>> - my_driver_irq_handler (priority 50) // end of the interrupt handler.
>> 
>> What is good is that now, "my_task" cannot be interrupted by another 
>> interrupt handler processing when it runs. But because of the 2 
>> additional context switches when the interrupt handler wake_up() 
>> "my_task", I now experience an additional latency and this is not 
>> expected.
>> 
>> On average the latency performance is better when "my_task" priority 
>> is 10 but the real-time behavior is better when "my_task" priority is 80.
>> 
>> The latency difference is mainly due to the additional context 
>> switches we have when the interrupt handler wake_up() "my_task". So 
>> the question I have: Are these additional context switches mandatory? 
>> Is there a way to avoid them.
>> 
>> As an exercise I raised (programatically) the interrupt handler 
>> priority to 99 before doing the wake_up() and lower it to 50 just 
>> after the wake_up. With this change, I now have (with LTTng):
>> 
>> - irq_handler
>> - my_driver_irq_handler (priority 50 then 99) // run until the 
>> priority is set back to 50
>> - my_task (priority 80) // run until it blocks again
>> - my_driver_irq_handler (priority 50) // end of the interrupt handler.
>> 
>> Setting the irq handler priority is fast and cost almost nothing 
>> (compared to context switch). As a result, I don't have the additional 
>> latency cause by the 2 context switches of the previous example and I 
>> get the best of both worlds: A short latency and the expected 
>> real-time behavior (I am not interrupted by later interrupt handler).
>> 
>> But I feel that changing explicitly/dynamically the driver irq handler 
>> priority to get the expected behavior might not be the appropriate 
>> solution.
>> 
>> Am I missing something? Is there a better way to prevent the 
>> additional context switches?
>> 
>> Thanks for any advice/hint you may have.
>> 
>> JC
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
