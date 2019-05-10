Return-Path: <SRS0=J4zX=TK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9600AC04A6B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661662182B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfEJVqp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 May 2019 17:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfEJVqp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 May 2019 17:46:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40DD7217F9;
        Fri, 10 May 2019 21:46:44 +0000 (UTC)
Date:   Fri, 10 May 2019 17:46:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] powerpc/stackprotector: work around stack-guard
 init from atomic
Message-ID: <20190510174642.46e357f6@gandalf.local.home>
In-Reply-To: <20190327183310.1015-2-bigeasy@linutronix.de>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
        <20190327183310.1015-1-bigeasy@linutronix.de>
        <20190327183310.1015-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 27 Mar 2019 19:33:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> This is invoked from the secondary CPU in atomic context. On x86 we use
> tsc instead. On Power we XOR it against mftb() so lets use stack address
> as the initial value.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Sebastian,

in your repo, you marked this as stable-rt, but this code was added in
4.20, and the next -rt is at 4.19.

-- Steve



> ---
>  arch/powerpc/include/asm/stackprotector.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
> index 1c8460e235838..e764eb4b6c284 100644
> --- a/arch/powerpc/include/asm/stackprotector.h
> +++ b/arch/powerpc/include/asm/stackprotector.h
> @@ -24,7 +24,11 @@ static __always_inline void boot_init_stack_canary(void)
>  	unsigned long canary;
>  
>  	/* Try to get a semi random initial value. */
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	canary = (unsigned long)&canary;
> +#else
>  	canary = get_random_canary();
> +#endif
>  	canary ^= mftb();
>  	canary ^= LINUX_VERSION_CODE;
>  	canary &= CANARY_MASK;

