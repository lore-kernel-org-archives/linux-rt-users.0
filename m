From: Till Straumann <strauman@slac.stanford.edu>
Subject: Re: How to unblock a thread from  a hard isr (IRQF_NO_THREAD)
Date: Thu, 08 Nov 2012 18:53:35 -0600
Message-ID: <509C540F.3050108@slac.stanford.edu>
References: <509C3220.2050601@slac.stanford.edu> <201211090012.32207.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailbox.alumni.tu-berlin.de ([130.149.4.13]:45259 "EHLO
	mailbox.alumni.tu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757256Ab2KIAxk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 19:53:40 -0500
In-Reply-To: <201211090012.32207.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/08/2012 05:12 PM, Tim Sander wrote:
> Hi Till
>> What *is* the recommended mechanism to wake up a thread from
>> a hard-isr?
> I think its the waitqueue mechanism with the drawbacks you mentioned.
I thought I can't wake_up() from a hard-isr so that can hardly be
the recommended mechanism (unless you mean I *should* go
via the 'irq_thread' (kernel/irq/management.c) and wake my
user-land thread from there).

The IRQ management code must use something to let the
hard-isr unblock the irq-handler kthread - I'd like to use the same
(or a similar) method to let the hard-isr unblock a user-land
thread.
>
> If you only want to wake up *one* usermode thread there is a hack
> possible to save the context switch times to the bottom half interrupt thread?
What would such a hack be?

Thanks
- Till
>
> Best regards
> Tim

