Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F3C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CA164EBD
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhBRP4a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBROmH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 09:42:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C8C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 06:41:07 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:41:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613659265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvlcmK/q8BcjSaVPU41LnT2BVlukwuU8d3x6yFlswnY=;
        b=BzmKXpBQdpme/ThIFks5GwQO9B5xoYfld53FQ3a0NnotQkKjlmn2yNZ0pAIwwPyr9pX3oe
        UYqZnoZVLovNU2BR8wnUcCY9+gUNIsdzbAHQeNVwynPHg7cyoJ9MZpaSZ8NTj6q4I60vYG
        YKQaZI+54fexVfbX0Yro8miwDHydHM+HGZhnrsWg4IY1cvFy1r87cIXMYscPhe+kovnBEs
        uRt8RKiVmMIeQqc6yBpV8CRN758zfGprLbUxZ10lVmrRv6+zA2B2HuaMmkjMIzazKZdNlz
        lz9VSxGLDRRb7nkgelfxcLTvn3PPFc2PLkdoQpjfLU+Akrwc4Vf/Ujg2oajZUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613659265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvlcmK/q8BcjSaVPU41LnT2BVlukwuU8d3x6yFlswnY=;
        b=hgpptCaCfdjwjH4c1e5VqvQay9ovU+753m55ns+eSLDRZCt4Bn1pLoNUDWUTcRRYRf83Sc
        BqukidWJ2sDjJwDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: rcu_preempt detected stalls [5.9.1-rt]
Message-ID: <20210218144104.rfpcpzp6rhvks5vj@linutronix.de>
References: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-31 10:13:30 [+0100], Udo van den Heuvel wrote:
> Hello,
Hi,

> Found these loggings in journal, what happened here?

09:20:24 RCU stalled on CPU0. 
09:21:08 Networking was not able to send packets.

The RCU part indicates that something is blocking the CPU. The network
part might be related (it is not bound to a CPU but if the IRQ-thread is
blocked then packets won't be sent/acked).

09:21:19 systemd's watchdog killed tor because it was not responding.

Most of tor's threads were waiting in pthread_cond_wait().
One thread was in getsockopt(sock, SOL_TCP, TCP_INFO, ,,). This could
block/sleep in lock_sock_fast() but shouldn't since all threads were
idle. Unless a packet would be received at that time. tor does not
changes its priority so everything should run at SCHED_OTHER.

tor got killed in the end and you did not attach any more rcu warnings
so it appears that CPU0 is no longer blocked. I don't know what blocked
the CPU for the time.

> Kind regards,
> Udo

Sebastian
