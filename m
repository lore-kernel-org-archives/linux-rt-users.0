Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4CC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 06:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC8860525
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 06:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhHEGbp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:31:45 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:47030 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbhHEGbo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 02:31:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A254460E0C;
        Thu,  5 Aug 2021 08:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1628145086; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=fMjdYpp5JCpstW6ZTzhk9U6IfBmdbSbvc5upKxuwlwY=;
        b=lKyk6/7Eqa4RT8C6UcMZDJ2+RuK7uo1M6WnNbs3OBWzWnwV+/IrDFwUXFZ11zuMQg4FxrJ
        VXQwgLtW/p0B0nTTx/QmC6YnRLS/VSJ94e4zt12DV2E+E6JoBPFQEw0TvIWnbD1AONEWTS
        A9PfXg/pc/ZLZPZy7BZ1T4YGcHMg928ihuF309Qn5DcyjSekWWbRn3qsm5PrEloeEhjX2f
        n81kRK4E2qF+nDdMDxdxEMJR4MIsgziNTQpo67EvaVCvejA05CGXXtRMkmfU8CxnO9KMvd
        aYTxL+KneoNcxoD+zytAOU+KS6d4oNGJFI1V0Z7RSz8HRjgZ7i3pW/JjHg3VdA==
Date:   Thu, 5 Aug 2021 08:31:23 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
Message-ID: <20210805063123.mj4rggncauziryv4@beryllium.lan>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Wed, Aug 04, 2021 at 06:50:17PM +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.14-rc4-rt5 patch set.

Just a heads up. I get these build errors:

2021-08-05 08:29:43 - ERROR    - In file included from /home/wagi/rt/linux/arch/x86/kernel/asm-offsets.c:10:
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:130:3: error: invalid preprocessing directive #debug_normal_state_change
2021-08-05 08:29:43 - ERROR    -   130 | # debug_normal_state_change(state_value)                                \
2021-08-05 08:29:43 - ERROR    -       |   ^~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:136:3: error: invalid preprocessing directive #debug_special_state_change
2021-08-05 08:29:43 - ERROR    -   136 | # debug_special_state_change(state_value)                               \
2021-08-05 08:29:43 - ERROR    -       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:142:3: error: invalid preprocessing directive #debug_rtlock_wait_set_state
2021-08-05 08:29:43 - ERROR    -   142 | # debug_rtlock_wait_set_state()                                          \
2021-08-05 08:29:43 - ERROR    -       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:148:3: error: invalid preprocessing directive #debug_rtlock_wait_restore_state
2021-08-05 08:29:43 - ERROR    -   148 | # debug_rtlock_wait_restore_state()                                      \
2021-08-05 08:29:43 - ERROR    -       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched/signal.h: In function ‘kernel_signal_stop’:
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:219:17: error: implicit declaration of function ‘debug_special_state_change’ [-Werror=implicit-function-declaration]
2021-08-05 08:29:43 - ERROR    -   219 |                 debug_special_state_change((state_value));              \
2021-08-05 08:29:43 - ERROR    -       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched/signal.h:296:17: note: in expansion of macro ‘set_special_state’
2021-08-05 08:29:43 - ERROR    -   296 |                 set_special_state(TASK_STOPPED);
2021-08-05 08:29:43 - ERROR    -       |                 ^~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/rcuwait.h: In function ‘finish_rcuwait’:
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/sched.h:198:17: error: implicit declaration of function ‘debug_normal_state_change’ [-Werror=implicit-function-declaration]
2021-08-05 08:29:43 - ERROR    -   198 |                 debug_normal_state_change((state_value));               \
2021-08-05 08:29:43 - ERROR    -       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - /home/wagi/rt/linux/include/linux/rcuwait.h:53:9: note: in expansion of macro ‘__set_current_state’
2021-08-05 08:29:43 - ERROR    -    53 |         __set_current_state(TASK_RUNNING);
2021-08-05 08:29:43 - ERROR    -       |         ^~~~~~~~~~~~~~~~~~~
2021-08-05 08:29:43 - ERROR    - cc1: some warnings being treated as errors

Daniel Bristot reported the same one IRC.

Daniel
