Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E00C07E95
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEF46112D
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Jul 2021 14:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbhGSOPQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhGSOPQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Jul 2021 10:15:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF74C061574;
        Mon, 19 Jul 2021 07:24:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626706552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPRSINWbxpjU4HZDveqVKk8V2pGGERTFFKUHojq2fT0=;
        b=I6WzpbaE44qIvh7ptaDoztHg54sDr1p8f1D0blTA3A8aXZAo4EollISC0lhRlVXsxfT/zu
        My59IJm1fZ3xo75/pp8HwhhaPa/sDTxbVsI/Y6PPIV8Y2PXF4LXB3JfAkfXEIeZjg+TI+Q
        OtNKsPge4LMuSWpljv4+SgGved9SDFMRuN0yz31HvOkFP8t3mg6T9769aFfu3R5iiSb4Kt
        tEQmjULeNFE3oIduNPWXf9g/HwK9UoDgXxv4aQox0Iv8VV9taLXEJTyEUUDKa2EZp+SUVa
        H1q5FaptZp2MbBgGT7lqptwLPlygeYleI9FuhNAdKFnR4jTwLdM+UrYRa/fOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626706552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fPRSINWbxpjU4HZDveqVKk8V2pGGERTFFKUHojq2fT0=;
        b=MbUr5ESGk5e4fFC2MMbEUwz2Lh/SwloQPEDqvwunynl3LwBDpNIuCxmPyUyFawgVXLvV1f
        DfXkj/hmtxN95KBg==
To:     chao.qin@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     mgross@linux.intel.com, paul.mei@intel.com, lili.li@intel.com
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep in pr_flush()
In-Reply-To: <20210719022649.3444072-1-chao.qin@intel.com>
References: <20210719022649.3444072-1-chao.qin@intel.com>
Date:   Mon, 19 Jul 2021 17:01:51 +0206
Message-ID: <87mtqiuzd4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-07-19, chao.qin@intel.com wrote:
> From: Chao Qin <chao.qin@intel.com>
>
> There is msleep in pr_flush(). If call WARN() in the early boot
> stage such as in early_initcall, pr_flush() will run into msleep
> when process scheduler is not ready yet. And then the system will
> sleep forever.
>
> Before the system_state is SYSTEM_RUNNING, make sure DO NOT sleep
> in pr_flush().
>
> Fixes: 63cf1e4b564a ("printk: add pr_flush()")
>
> Signed-off-by: Chao Qin <chao.qin@intel.com>
> Signed-off-by: Lili Li <lili.li@intel.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> ---
>  kernel/printk/printk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 209d2392f0d8..a9b3afbdac39 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>  	u64 diff;
>  	u64 seq;
>  
> -	may_sleep = (preemptible() && !in_softirq());
> +	may_sleep = (preemptible() && !in_softirq()
> +			&& (system_state >= SYSTEM_RUNNING));
>  
>  	seq = prb_next_seq(prb);
>  
>
> base-commit: 7e175e6b59975c8901ad370f7818937f68de45c1
> -- 
> 2.25.1
