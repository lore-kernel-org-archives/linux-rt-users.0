From: Lionel DEBIEVE <lionel.debieve@st.com>
Subject: Re: [PATCH RT 1/1] remoteproc: Prevent schedule while atomic
Date: Wed, 22 Mar 2017 17:15:25 +0000
Message-ID: <025b6099-1a26-cdb5-6ddb-fbf36cbad5d9@st.com>
References: <1490195923-9560-1-git-send-email-lionel.debieve@st.com>
 <20170322090558.72064144@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35795 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964973AbdCVRPk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 13:15:40 -0400
In-Reply-To: <20170322090558.72064144@vmware.local.home>
Content-Language: en-US
Content-ID: <75B89288FDC5114C975E2D608030A05E@st.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/22/2017 05:05 PM, Steven Rostedt wrote:
> On Wed, 22 Mar 2017 16:18:43 +0100
> Lionel Debieve <lionel.debieve@st.com> wrote:
>
>> Use raw_spin_lock in enable/disable channel as it comes from
>> interrupt context.
>>
>> BUG: sleeping function called from invalid context at
>> kernel/locking/rtmutex.c:995
>> in_atomic(): 1, irqs_disabled(): 128, pid: 307, name: pulseaudio
>> Preemption disabled at:
>> [<c01790fc>] __handle_domain_irq+0x4c/0xec
>> CPU: 0 PID: 307 Comm: pulseaudio
>> Hardware name: STi SoC with Flattened Device Tree
>> [<c011046c>] (unwind_backtrace)
>> [<c010c7f4>] (show_stack)
>> [<c03d1578>] (dump_stack)
>> [<c014e440>] (___might_sleep)
>> [<c08e7f24>] (rt_spin_lock)
>> [<c069bb04>] (sti_mbox_disable_channel)
>> [<c069befc>] (sti_mbox_irq_handler)
>> [<c0179900>] (__handle_irq_event_percpu)
>> [<c01799dc>] (handle_irq_event_percpu)
>> [<c0179a78>] (handle_irq_event)
>> [<c017d1c8>] (handle_fasteoi_irq)
>> [<c0178c08>] (generic_handle_irq)
>> [<c017912c>] (__handle_domain_irq)
>> [<c0101488>] (gic_handle_irq)
>>
>> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> Looks fine to me. Should this go to mainline?
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> -- Steve

Will look deeper if it can be.

Lionel

>
>> ---
>>   drivers/mailbox/mailbox-sti.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mailbox/mailbox-sti.c
>> b/drivers/mailbox/mailbox-sti.c index 41bcd33..f9674ca 100644
>> --- a/drivers/mailbox/mailbox-sti.c
>> +++ b/drivers/mailbox/mailbox-sti.c
>> @@ -60,7 +60,7 @@ struct sti_mbox_device {
>>   	void __iomem		*base;
>>   	const char		*name;
>>   	u32			enabled[STI_MBOX_INST_MAX];
>> -	spinlock_t		lock;
>> +	raw_spinlock_t		lock;
>>   };
>>   
>>   /**
>> @@ -129,10 +129,10 @@ static void sti_mbox_enable_channel(struct
>> mbox_chan *chan) unsigned long flags;
>>   	void __iomem *base = MBOX_BASE(mdev, instance);
>>   
>> -	spin_lock_irqsave(&mdev->lock, flags);
>> +	raw_spin_lock_irqsave(&mdev->lock, flags);
>>   	mdev->enabled[instance] |= BIT(channel);
>>   	writel_relaxed(BIT(channel), base + STI_ENA_SET_OFFSET);
>> -	spin_unlock_irqrestore(&mdev->lock, flags);
>> +	raw_spin_unlock_irqrestore(&mdev->lock, flags);
>>   }
>>   
>>   static void sti_mbox_disable_channel(struct mbox_chan *chan)
>> @@ -144,10 +144,10 @@ static void sti_mbox_disable_channel(struct
>> mbox_chan *chan) unsigned long flags;
>>   	void __iomem *base = MBOX_BASE(mdev, instance);
>>   
>> -	spin_lock_irqsave(&mdev->lock, flags);
>> +	raw_spin_lock_irqsave(&mdev->lock, flags);
>>   	mdev->enabled[instance] &= ~BIT(channel);
>>   	writel_relaxed(BIT(channel), base + STI_ENA_CLR_OFFSET);
>> -	spin_unlock_irqrestore(&mdev->lock, flags);
>> +	raw_spin_unlock_irqrestore(&mdev->lock, flags);
>>   }
>>   
>>   static void sti_mbox_clear_irq(struct mbox_chan *chan)
>> @@ -450,7 +450,7 @@ static int sti_mbox_probe(struct platform_device
>> *pdev) mdev->dev		= &pdev->dev;
>>   	mdev->mbox		= mbox;
>>   
>> -	spin_lock_init(&mdev->lock);
>> +	raw_spin_lock_init(&mdev->lock);
>>   
>>   	/* STi Mailbox does not have a Tx-Done or Tx-Ready IRQ */
>>   	mbox->txdone_irq	= false;
>
