From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 13:57:26 -0800
Message-ID: <4D473046.8090009@am.sony.com>
References: <4D47242E.1000508@am.sony.com> <4D4725CF.6060008@windriver.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:2502 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab1AaV6W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 16:58:22 -0500
In-Reply-To: <4D4725CF.6060008@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/11 13:12, Paul Gortmaker wrote:
> On 11-01-31 04:05 PM, Frank Rowand wrote:
>> Hi Paul,
>>
>> Thanks for the patch set!  I had started down the path of doing
>> the same work, and truly appreciate the effort you put into this.
>>
>> One of the patches had a chunk that failed to apply:
>>
>> genirq-support-forced-threading-of-interrupts.patch
> 
> Interesting.  I was using "git am" to apply them, and I can assure
> you that they all applied with that (which is quite strict in its
> checking.)
> 
> What were you applying them with?

quilt push -a

> 
> I'll go re-export the patch and look at the diff of the patch
> later when I get a chance, but I suspect something else.

Here is the hunk:

@@ -742,10 +743,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
                rand_initialize_irq(irq);
        }

-       /* Oneshot interrupts are not allowed with shared */
-       if ((new->flags & IRQF_ONESHOT) && (new->flags & IRQF_SHARED))
-               return -EINVAL;
-
        /* Preempt-RT setup for forced threading */
        preempt_hardirq_setup(new);



The problem is that the text after the deleted lines did not exist:

        /* Preempt-RT setup for forced threading */
        preempt_hardirq_setup(new);

The text that did exist is:

        /*
         * Check whether the interrupt nests into another interrupt
         * thread.
         */
        nested = desc->status & IRQ_NESTED_THREAD;


> 
> Were you using master branch of the patch repo, or the v2.6.33-rt

I used the master branch, as of:
  commit 9638db087a2b51cccb7dd73d29bced849c7c5765
  Mon Jan 24 00:12:32 2011 -0500

> branch?   I've already started moving the master branch ahead towards
> 2.6.34, so you will definitely get patch failures if you are trying
> it against a v2.6.33.7 baseline.
> 
> Paul.
> 
>>
>> patching file kernel/irq/manage.c
>> Hunk #2 succeeded at 465 (offset 3 lines).
>> Hunk #3 succeeded at 633 (offset 3 lines).
>> Hunk #4 succeeded at 706 (offset 3 lines).
>> Hunk #5 succeeded at 736 (offset 3 lines).
>> Hunk #6 succeeded at 804 (offset 3 lines).
>> Hunk #7 FAILED at 829.
>> 1 out of 7 hunks FAILED -- rejects in file kernel/irq/manage.c
>>
>>
>> I fixed it up and I am attaching the new version of the patch.
>>
>> With the fixed patch, the kernel source tree with your patches
>> applied matches the kernel source tree with the monolithic
>> 2.6.33.7-rt30 patch applied.
>>
>> -Frank Rowand
> 
> 


