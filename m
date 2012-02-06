From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt-rt: Real Time hogging task
Date: Mon, 06 Feb 2012 11:03:56 -0500
Message-ID: <1328544236.2200.4.camel@gandalf.stny.rr.com>
References: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
	 <1328191924.5882.86.camel@gandalf.stny.rr.com>
	 <CAPB=Z-pbkg1mp+WFjQUAyWAU+c8CuM8WoAN4==h-FNVaZYJmzQ@mail.gmail.com>
	 <CAPB=Z-qNCq9kuqsgrC5vdF9q4tpXnZuH+17c378GmaZD3P9FVQ@mail.gmail.com>
	 <CAPB=Z-qu+T0Zy0YFWP5YyPstGK+FsWqwqpx8PU8jorC_sWi=ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:46538 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2BFQD6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Feb 2012 11:03:58 -0500
In-Reply-To: <CAPB=Z-qu+T0Zy0YFWP5YyPstGK+FsWqwqpx8PU8jorC_sWi=ow@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2012-02-05 at 14:49 +0200, Raz wrote:
> I think it would be nice if load_module in ftrace mode will report that
> the driver should be recompiled. same as where it screams about version
> or license.

Did you have CONFIG_MODVERSIONS enabled?

> So, i managed to use ftrace, problem is that i cannot get the trace
> out of the machine,
> neither by scp nor by sz. i cannot cp it since it will flush to drive.
> ( even though i set
> flush to RT 99).

Why doesn't scp work?

You can also use trace-cmd to send the trace to another box.

On another host run:

	trace-cmd listen -p <port>

On this box run:

	trace-cmd record -p function -N <host>:<port>


The you can send me the "trace.*.dat" file generated.

> Here is part of the trace  file.
> 
>       tEthernInp-1173  [000]   133.002614: sub_preempt_count <-unmask_8259A_irq
>       tEthernInp-1173  [000]   133.002614: sub_preempt_count <-handle_level_irq
>       tEthernInp-1173  [000]   133.002614: irq_exit <-do_IRQ
>       tEthernInp-1173  [000]   133.002615: sub_preempt_count <-irq_exit
>       tEthernInp-1173  [000]   133.002615: wakeup_softirqd <-irq_exit
>       tEthernInp-1173  [000]   133.002615: wake_up_process <-wakeup_softirqd
>       tEthernInp-1173  [000]   133.002616: try_to_wake_up <-wake_up_process
>       tEthernInp-1173  [000]   133.002616: add_preempt_count <-try_to_wake_up
>       tEthernInp-1173  [000]   133.002616: add_preempt_count <-try_to_wake_up
>       tEthernInp-1173  [000]   133.002617: activate_task <-try_to_wake_up
>       tEthernInp-1173  [000]   133.002617: enqueue_task <-activate_task
>       tEthernInp-1173  [000]   133.002617: update_rq_clock <-enqueue_task
>       tEthernInp-1173  [000]   133.002618: enqueue_task_rt <-enqueue_task
>       tEthernInp-1173  [000]   133.002618: dequeue_rt_stack <-enqueue_task_rt
>       tEthernInp-1173  [000]   133.002618: ttwu_do_wakeup.clone.139 <-try_to_wa

Would you be able to send more than this?


-- Steve


