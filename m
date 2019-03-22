Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B65C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB5E218A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCVSww (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:52:52 -0400
Received: from foss.arm.com ([217.140.101.70]:50800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCVSww (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 14:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7516015AB;
        Fri, 22 Mar 2019 11:52:51 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E1DC3F71A;
        Fri, 22 Mar 2019 11:52:50 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.0.3-rt1
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de, Dave P Martin <Dave.Martin@arm.com>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com>
Date:   Fri, 22 Mar 2019 18:52:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320171511.icjhdlulgal2yeho@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Apologies for a possible stupid question.

On 20/03/2019 17:15, Sebastian Andrzej Siewior wrote:
>    - Applied John Ogness' prinkt rework. One visible change is the
>      output during boot. Under the hood and for RT: By default, output
>      that is created at KERN_WARN[0] or higher is printed immediately if the
>      console supports "atomic" print (currently the 8250 driver does).
>      This output is printed immediately (and visible) even from IRQ-off
>      or preempt-disabled regions which wasn't the case earlier. This will
>      raise the latency at run-time *but* there should be no WARNING,
>      ERROR or PANIC messages at run-time on a fully working system.
>      Messages with lower severity are printed "later" by a kthread.

Using 5.0.3-rt1, I get some warning message completely mangled with the rest of 
the output (e.g systemd message) but also between them. Some excerpt of a 500 
lines lockdep warning (AFAICT the printk is not related to the printk code):

[   52.294547] 005: ... which became HARDIRQ-irq-unsafe at:
[   52.294553] 005: ...
[   52.294554] 005:   lock_acquire+0xf8/0x318
[  OK  ] Reached target
t_spin_lock+0x48/0x70  lock_acquire+0xf8/0x318
[0;1;39mRemote File Systems.[   52.294570] 005:   iommu_dma_map_msi_msg+0x5c/0x1

[   52.296824] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
9a0fed6 #4312] 005:  __sys_sendmsg+0x68/0xb8

I understand the new series add support for "atomic" print. So I am wondering 
whether this issue is related to it? Is there any advice to prevent the mangling?

Cheers,

-- 
Julien Grall
