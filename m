Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BBC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F80123437
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbhAVNEu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbhAVNEa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 08:04:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03BC06174A
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 05:03:37 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:03:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611320615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcLDpOmmeb5KrRtgfnzuTTA4cCQU3dYEJWs0X2c78zk=;
        b=hBM2mUWQ6Zd3vEDoWX63rNJxdnol4f9ADnGdc0DphdYPVnroqw2V1Wh//8WCGrogOi4mQn
        uH9Xp8yCEMqsE5rgVQBV5PxYEXv3H0iVvUFjKkFTzyO2t9RCsja91kiGGXzBJ5Q7Zg1sAE
        cbmXtiLlSxGJHJgKtLjBT+OTWav/LrTcOJ8BN4D2kPse9pLneydwW8I9exAmn0IMW0Swly
        7WWOPLCpb/xbFV9toXJYhPhNwnvwZRlp+uQn1MmTdo8GqmkL3Ozk0dBMTRBCl6QWiiSHgo
        tP3mfWBEJmQY6jBp5yt2eBN+skEMcEl1oPQTDOognJFG8F1TV57TBqLmuu6IxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611320615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcLDpOmmeb5KrRtgfnzuTTA4cCQU3dYEJWs0X2c78zk=;
        b=wotV8DkHPtoDWGjuNK8aDR69kWbNcJFAMoQfbzxCg0p5wid+uVIFiFKy9iUdkMX0My4MLz
        vab4Veb/jEB+AnDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     schwenderjonathan@gmail.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: What are managed IRQs?
Message-ID: <20210122130335.qtfgejyi2oa374ds@linutronix.de>
References: <013a01d6f00c$c345be90$49d13bb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <013a01d6f00c$c345be90$49d13bb0$@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-21 16:47:45 [+0100], schwenderjonathan@gmail.com wrote:
> Hi everyone,
Hi,

> isolcpus has the option `managed_irq`, which supposedly assigns the IRQs to
> housekeeping CPUs if possible. According to the description of isolcpus, the
> affinity of managed IRQs can not be changed via /proc/irq.
> I've searched the kernel documentation and the kernel source code for 
> more information about managed IRQs / managed interrupts, but haven't found 
> any documentation (aside from isolcpus).
> 
> Specifically, I'm interested in what makes managed IRQs different (as in 
> why can't the affinity be changed via procfs), and
> what kind of IRQs are "managed"? 

Having MSI(-X) devices with plenty of interrupts could get in a position
where you run out of vector space to program them. Since they are
per-CPU (based on their use-case) they are only programmed on the CPU
where they are fired.
Changing the affinity will also affect the driver logic. So assuming you
have 4 queue (interrupt) NVME device it hardly makes no sense to have to
interrupts on one CPU. It would make sense not create an interrupt on
the CPU and spread the load across the other queue.

> Also, I'd like to verify if the cmdline parameter `irqaffinity` 
> affects managed IRQs, or if it only modifies the default affinity for IRQs
> which can be changed via procfs.

Does the commit description of
  11ea68f553e24 ("genirq, sched/isolation: Isolate from handling managed interrupts")

  https://git.kernel.org/torvalds/c/11ea68f553e24

help?

> Thanks
> 
> Jonathan

Sebastian
