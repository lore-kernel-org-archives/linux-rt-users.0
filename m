Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA7C388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2926E22258
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OoSWB6+O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JG48Rzr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898932AbgJ0LGP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:06:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898906AbgJ0LGO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 07:06:14 -0400
Date:   Tue, 27 Oct 2020 12:06:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603796772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKwuG3DrXp6m8nanJYzu9PsZbU1coOD6Mg4vjT7V584=;
        b=OoSWB6+OPmLBNFX7jYpbKVjOXMcsyTBsllZQL9hO9HQqFikKi/u9bprFBiIpApxMQ6KYmv
        Tp343NhP4piJR9uvrCIQVf3H6DzUE9hZK1HdcoICuI3QnohV94efZf3enX1gCmWwLKFVR0
        qQYvxNnn9G/po7OU+y3woby/vxZRYwuOfcT5THXkGfEOkZYjApPNyRnSJ5U9QojtNUnewK
        zPfOnfMbHDyVH1qR7K/nLt8E7inLbhSjYDMU43Y/HxNcA2Q6Y9kzPtLjJPys62LFuZbM/6
        JDyEGbiVyM6FaPFvQBKrKTarX/OixUTZV12PsBhpG3YcfAlKfRXgvaOH+FztoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603796772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKwuG3DrXp6m8nanJYzu9PsZbU1coOD6Mg4vjT7V584=;
        b=JG48Rzr4Mypqi2QL/MZcWUKHzZsH/RXuYm/cPJ3ZnKq6s4F2MgMUALvxnwBkqRSu3F8+Iw
        uwd29UWLG7KR8HCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] v5.9.1-rt19
Message-ID: <20201027110611.5hvuhsp3sjtcshsl@linutronix.de>
References: <20201024091838.gzhn2dlx2j7xnixg@linutronix.de>
 <20201027093616.5vn6xinmthxulhvx@beryllium.lan>
 <20201027100049.xtkmjqdwkn7zec2f@linutronix.de>
 <20201027102547.y6wop7j2ovzg2tyx@beryllium.lan>
 <20201027102851.gizepjlu4opensqb@linutronix.de>
 <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027103411.h5ushvwsrovxls5u@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-27 11:34:11 [+0100], Daniel Wagner wrote:
> On Tue, Oct 27, 2020 at 11:28:51AM +0100, Sebastian Andrzej Siewior wrote:
> > Is it running as a RT task?
> 
> root@c2d:~/rt-tests# ./pi_stress
> Starting PI Stress Test
> Number of thread groups: 1
> Duration of test run: infinite
> Number of inversions per group: unlimited
>      Admin thread SCHED_FIFO priority 4
> 1 groups of 3 threads will be created
>       High thread SCHED_FIFO priority 3
>        Med thread SCHED_FIFO priority 2
>        Low thread SCHED_FIFO priority 1
> 
> It says so, let me double check if those task really run with SCHED_FIFO.

urgh. You wrote pi_stress and I read stress-ng. Okay this explains it.

> > Otherwise it looks that if you throw enough non-RT load on the system,
> > RCU can not catch up which does not sound good.
> 
> I think this is what Clark tried to tell me. If I understood him
> correctly the test tool is not correct though.

a dummy RCU section might help. But otherwise it is correct :/

Sebastian
