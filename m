Return-Path: <SRS0=5pzl=R4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCDC43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674C12087E
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 08:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfCYINP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:13:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfCYINP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Mar 2019 04:13:15 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h8KjF-00052Y-TW; Mon, 25 Mar 2019 09:13:10 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [ANNOUNCE] v5.0.3-rt1
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
        <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com>
Date:   Mon, 25 Mar 2019 09:13:08 +0100
In-Reply-To: <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com> (Julien Grall's
        message of "Fri, 22 Mar 2019 18:52:48 +0000")
Message-ID: <87tvfrs76z.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-22, Julien Grall <julien.grall@arm.com> wrote:
> Apologies for a possible stupid question.

It's an important question because the behavior of console printing has
changed. (Or, rather, is in the process of being changed. Depending on
complaints/approval, it may change some more.)

> On 20/03/2019 17:15, Sebastian Andrzej Siewior wrote:
>>    - Applied John Ogness' prinkt rework. One visible change is the
>>      output during boot. Under the hood and for RT: By default, output
>>      that is created at KERN_WARN[0] or higher is printed immediately if the
>>      console supports "atomic" print (currently the 8250 driver does).
>>      This output is printed immediately (and visible) even from IRQ-off
>>      or preempt-disabled regions which wasn't the case earlier. This will
>>      raise the latency at run-time *but* there should be no WARNING,
>>      ERROR or PANIC messages at run-time on a fully working system.
>>      Messages with lower severity are printed "later" by a kthread.
>
> Using 5.0.3-rt1, I get some warning message completely mangled with
> the rest of the output (e.g systemd message) but also between
> them. Some excerpt of a 500 lines lockdep warning (AFAICT the printk
> is not related to the printk code):
>
> [   52.294547] 005: ... which became HARDIRQ-irq-unsafe at:
> [   52.294553] 005: ...
> [   52.294554] 005:   lock_acquire+0xf8/0x318
> [  OK  ] Reached target
> t_spin_lock+0x48/0x70  lock_acquire+0xf8/0x318
> [0;1;39mRemote File Systems.[   52.294570] 005:   iommu_dma_map_msi_msg+0x5c/0x1
>
> [   52.296824] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
> 9a0fed6 #4312] 005:  __sys_sendmsg+0x68/0xb8
>
> I understand the new series add support for "atomic" print. So I am
> wondering whether this issue is related to it? Is there any advice to
> prevent the mangling?

The atomic print allows important messages to be print immediately
(regardless of the context of the printer). This means that if any other
context was already printing, it will be interrupted. This cannot be
synchronized without causing significant scheduling delays.

The atomic messages always do the interrupting and will continue to the
end of the line. So it should be possible to piece the non-atomic
messages back together. However, I am a bit confused by your output. Is
it possible that I could see the full boot log?

The main goal of the atomic messages is so that you never lose any
important messages. To help readability, perhaps the atomic messages
should begin with a '\n' as well?

John Ogness
