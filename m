From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Subject: Re: latency issue on wait_event/wake_up calls.
Date: Wed, 02 May 2012 20:49:03 +0200
Message-ID: <4FA1819F.5060407@tribudubois.net>
References: <4F9BC6D3.8030203@tribudubois.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zose-mta11.web4all.fr ([178.33.204.87]:59203 "EHLO
	zose-mta11.web4all.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab2EBStH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 14:49:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by zose-mta11.web4all.fr (Postfix) with ESMTP id F2B8846051
	for <linux-rt-users@vger.kernel.org>; Wed,  2 May 2012 20:52:53 +0200 (CEST)
Received: from zose-mta11.web4all.fr ([127.0.0.1])
	by localhost (zose-mta11.web4all.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZV47qEvdfsX5 for <linux-rt-users@vger.kernel.org>;
	Wed,  2 May 2012 20:52:53 +0200 (CEST)
Received: from [192.168.1.106] (smm49-1-78-235-240-156.fbx.proxad.net [78.235.240.156])
	by zose-mta11.web4all.fr (Postfix) with ESMTPA id 68E1D4604E
	for <linux-rt-users@vger.kernel.org>; Wed,  2 May 2012 20:52:53 +0200 (CEST)
In-Reply-To: <4F9BC6D3.8030203@tribudubois.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Sorry to insist but would anybody have a clue on the fact that this 
behavior is expected and/or if there is a way arround it beside changing 
the priority dynamically.

Thanks

JC

On 28/04/2012 12:30, Jean-Christophe DUBOIS wrote:
> Hello,
>
> I need help/advice on a little "performance" problem I have:
>
> I am using linux 3.0.3 with the related RT patch on an ARM9 processor.
>
> I have a RT task which is reading from a driver. The RT task is 
> blocked on wait_event_interruptible() and the driver interrupt handler 
> is releasing the waiting task using wake_up_interruptible() when there 
> is data available.
>
> By default on linux RT, driver IRQ handlers are run in threads with a 
> priority of 50.
>
> At first I setup my RT task with a priority of 10.
>
> When some data are received by the system, I can see the following 
> scheduling (using LTTng).
>
> - irq_handler
> - my_driver_irq_handler (priority 50)
> - my_task (priority 10)
>
> This is all good but I really need "my_task" to be high priority. Once 
> an event is received, it need to process it immediately without being 
> interrupted by further events coming on the device.
>
> So now, I set my_task priority to 80. Now when data is received, I can 
> see the following scheduling (still using LTTng).
>
> - irq_handler
> - my_driver_irq_handler (priority 50)
> - my_task (priority 80) // this is a short run. I assume the task is 
> checking the wait() "condition"
> - my_driver_irq_handler (priority 80) // here there seems to be an 
> "automatic" priority inversion to allow the handler to run and finish 
> the wake_up call
> - my_task (priority 80) // run until it blocks again
> - my_driver_irq_handler (priority 50) // end of the interrupt handler.
>
> What is good is that now, "my_task" cannot be interrupted by another 
> interrupt handler processing when it runs. But because of the 2 
> additional context switches when the interrupt handler wake_up() 
> "my_task", I now experience an additional latency and this is not 
> expected.
>
> On average the latency performance is better when "my_task" priority 
> is 10 but the real-time behavior is better when "my_task" priority is 80.
>
> The latency difference is mainly due to the additional context 
> switches we have when the interrupt handler wake_up() "my_task". So 
> the question I have: Are these additional context switches mandatory? 
> Is there a way to avoid them.
>
> As an exercise I raised (programatically) the interrupt handler 
> priority to 99 before doing the wake_up() and lower it to 50 just 
> after the wake_up. With this change, I now have (with LTTng):
>
> - irq_handler
> - my_driver_irq_handler (priority 50 then 99) // run until the 
> priority is set back to 50
> - my_task (priority 80) // run until it blocks again
> - my_driver_irq_handler (priority 50) // end of the interrupt handler.
>
> Setting the irq handler priority is fast and cost almost nothing 
> (compared to context switch). As a result, I don't have the additional 
> latency cause by the 2 context switches of the previous example and I 
> get the best of both worlds: A short latency and the expected 
> real-time behavior (I am not interrupted by later interrupt handler).
>
> But I feel that changing explicitly/dynamically the driver irq handler 
> priority to get the expected behavior might not be the appropriate 
> solution.
>
> Am I missing something? Is there a better way to prevent the 
> additional context switches?
>
> Thanks for any advice/hint you may have.
>
> JC
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

