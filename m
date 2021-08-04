Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C63AC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7761160F56
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 08:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhHDIYi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:24:38 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:39888 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhHDIYh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 04:24:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BE1E5E361;
        Wed,  4 Aug 2021 10:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1628065463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=7MXt9jO9nRd+eRgxlVk1Ac75ZwcBXTdIHJ3fndYmS7Y=;
        b=eRJY23M2J6Zsq7vqY3+fCtIJOGMX1Wwi36q74YJoil8xA94RZGVZKarpjaRg50MF32yVSS
        4oj4esjWaqrbmbXnOJUf0hcrlh6NVk299HY85EMFvknHY14VDdxSlrfOur6S2loeovmKvB
        6S1FTpS+I1LDUpzL4mdCu5TNe5rAJ+6NAAX7U4gmTvjhI3aX2k780eGfOiWSbUaW0QcXNA
        7XVx5J6Xlu6S2djfaN6zl+qRAciHuIPu/eePNcruY0rrSt/E4HrdENknGhbqpCPZS0bQ4h
        YEccjIOE6z/+1wF9baI4nCGaL4OxntOStmQO4ZisUXPX9Uf5fgOutfFSbAZT0A==
Date:   Wed, 4 Aug 2021 10:24:18 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802162750.santic4y6lzcet5c@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Mon, Aug 02, 2021 at 06:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.14-rc4-rt4 patch set. 

stress-ng is able to trigger a BUG on my old x86_64 box very
easy. Unfortunately, there is not much in the logs though.

+ ./cyclictest.sh -D 15m -p 98 -i 1000 -t 2 -a 0-1 -h 100 -w 'stress-ng --class io --all 1'
# /dev/cpu_dma_latency set to 0us
[   21.059000] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[   21.059008] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 321, name: iou-wrk-314
[   21.059010] Preemption disabled at:
[   21.059011] [<ffffffffa5223ce7>] schedule+0xa7/0xf0
[   23.076059] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[   23.076064] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 324, name: iou-wrk-314
[   23.076066] Preemption disabled at:
[   23.076067] [<ffffffffa5223ce7>] schedule+0xa7/0xf0
[   37.416490] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[   37.416495] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 369, name: iou-wrk-314
[   37.416498] Preemption disabled at:
[   37.416498] [<ffffffffa5223ce7>] schedule+0xa7/0xf0
[   38.416858] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[   38.416863] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 411, name: iou-wrk-314
[   38.416864] Preemption disabled at:
[   38.416865] [<ffffffffa5223ce7>] schedule+0xa7/0xf0
[   43.486360] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
[   43.486366] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 414, name: iou-wrk-314
[   43.486368] Preemption disabled at:
[   43.486369] [<ffffffffa5223ce7>] schedule+0xa7/0xf0

Thanks,
Daniel
