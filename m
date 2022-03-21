Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E9C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Mar 2022 09:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbiCUJdL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiCUJdK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Mar 2022 05:33:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39F554BF;
        Mon, 21 Mar 2022 02:31:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:31:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647855103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YfZJhnFFE47+r6x4/y12Et9mQlf31S6cyLCttG7V3Hg=;
        b=slMFIokGRhs/PDaoq0WKr5va3xvP6cZXpwJGhaXFVAtqnCSE7/sPBtEl5AEn9eio/5pSTp
        xomX0cA5lo0vZWThBX8Ej30PWPZCwUFFwjfzjo47ccJma3D0t274QAaZqJMfcgMt3oyeGo
        BohAEcFhk4iJcFeWnb6DvDv+NJQ0Edm73IaqyeVpJ2tmA0nZmq3zPBSYnx37cNQLpfziA0
        eb47m29ERJdVDQJ496ODexHpaIcS4aYOJbxcHBsmzWXAvLdEAPA+Kione/z0MxIteC0HZa
        WsUj8q5PuMsSWSaQ7MjeUHNpb8etaBoa0kdbNfIX4xCLhPhrfV82Le+7UrV3sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647855103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YfZJhnFFE47+r6x4/y12Et9mQlf31S6cyLCttG7V3Hg=;
        b=8BdkzvmmWaoe90eyw+hphvDhdeRamHpxmFFnEi/fEfgzeCnYzg3mpMZfgr/9VEwmV7nNfy
        /WW9zUYJXae8xIAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Schspa Shi <schspa@gmail.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 5.10-rt] printk: fix suppressed message print when
 reboot/panic
Message-ID: <YjhF/jWXY5L3I+DZ@linutronix.de>
References: <20220321053815.71316-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220321053815.71316-1-schspa@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-21 13:38:16 [+0800], Schspa Shi wrote:
> Update printk_seq for suppressed message.
> 
> Affects 5.9-rt and 5.10-rt
> 
> When message is suppressed, printk_seq should be updated, otherwise
> this message will be printed when reboot. This problem was introduced
> in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").

So it is only 5.10 given that 5.9 is not maintained.
That commits points to the printk update in v5.9.1-rt18.
John?

> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  kernel/printk/printk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0c56873396a9..f68c4ba7eb4d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2826,8 +2826,17 @@ static int printk_kthread_func(void *data)
>  		if (!(con->flags & CON_ENABLED))
>  			continue;
>  
> -		if (suppress_message_printing(r.info->level))
> +		printk_seq = atomic64_read(&con->printk_seq);
> +
> +		if (suppress_message_printing(r.info->level)) {
> +			/*
> +			 * Skip record we have buffered and already printed
> +			 * directly to the console when we received it, and
> +			 * record that has level above the console loglevel.
> +			 */
> +			atomic64_cmpxchg_relaxed(&con->printk_seq, printk_seq, seq);
>  			continue;
> +		}
>  
>  		if (con->flags & CON_EXTENDED) {
>  			len = info_print_ext_header(ext_text,
> @@ -2843,7 +2852,6 @@ static int printk_kthread_func(void *data)
>  				printk_time);
>  		}
>  
> -		printk_seq = atomic64_read(&con->printk_seq);
>  
>  		console_lock();
>  		console_may_schedule = 0;
> -- 
> 2.29.0
> 
