Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07AC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 11:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D630611F2
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 11:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhIQLh0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 07:37:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbhIQLhZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 07:37:25 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631878562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+73H2mnuP9dFzMcqNalHmi7NByEnLzYdzPOLPqnxEM=;
        b=MgabDaQ++ek/LKhtkIN4Gg7WYcld/4af0nTzGAwxgH2t+ga6Pb+VnIrtchAdml9fBSBvtt
        6EdyN2BtcfOzakLjh01KIBCUbyoEJBYXWTd/09lpPZtwtV7Ob9cp2SHdlDYI8yPfGYw5eg
        GBRafxGKIUgdb36h7izUnrBDbjWpQg+2JY14HcPfpW8ULthVulWgMLy0nGGNysSSUqJ84b
        dZNhBaT1hmijefr52PEMTfDbLo+zW7qhQ0Im+CR226/HBk8uL5Gsev/vIWVVchT7nYXr9X
        dYJlQlobir0btfQHew1ZTfQHTMDYtmAkRWfEM32/I3/jkZeab49lAL1Kd/5+NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631878562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+73H2mnuP9dFzMcqNalHmi7NByEnLzYdzPOLPqnxEM=;
        b=tRrvSTiQDwPy8x37TSBU9tYfFTeECHEiyW8/MmhWOneZPEFbdD1qOR7un3bgJVVIs3xh27
        1stFjDIExDbw4KBQ==
To:     Walter Stoll <Walter.Stoll@duagon.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel/printk: RT-adaption of kmsg_dump breaks mtdoops
In-Reply-To: <c4b1a518b23c4507b3fc725cea005276@chdua14.duagon.ads>
References: <c4b1a518b23c4507b3fc725cea005276@chdua14.duagon.ads>
Date:   Fri, 17 Sep 2021 13:42:02 +0206
Message-ID: <87zgsb4eot.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello Walter,

On 2021-09-17, Walter Stoll <Walter.Stoll@duagon.com> wrote:
> Effect observed
> ---------------
>
> We want to store kernel oops logs on a NAND flash partition by means of the
> MTD Oops/Panic console logger/driver. However, no log is generated.
>
> We observed the effect with kernel version v5.4.138-rt62. However, we think
> that the most recent kernel exhibits the same behavior because the structure of
> the sources in question (see below) did not change.

This problem does not exist in v5.10-rt. The kmsg_dump API was changed
(later in mainline as well) to avoid this issue. For v5.10-rt the change
was buried in the all-in-one commit:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v5.10-rt&id=9835363e31e75d3287a81c6fc1b22c5c2b43d277

And later. the API change for mainline (5.12):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9f3f02db98bbe678a8e57fe9432b196174744a3

> Root cause
> ----------
>
> Further investigations revealed, than the issue is due to the realtime adaption
> of the kmsg_dump() function.
>
> Non realtime version of kmsg_dump():
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=linux-5.4.y#n3149
>
> Realtime version of kmsg_dump():
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/tree/kernel/printk/printk.c?h=v5.4-rt#n2904
>
> In our case, the the mtd_panic_write() function returns with error when the
> kernel panics. As a result, no log is created. Call chain:
> ... panic() -> kmsg_dump() -> mtdoops_do_dump() -> mtdoops_write()
>     mtd_panic_write()
>
> Note that within the kmsg_dump() function, a locally create kmsg_dumper object
> is passed to the dumper_local.dump(&dumper_local, reason) call. However the
> callee mtdoops_do_dump() function expects this object being embedded in a
> mtdoops_context object, see
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/tree/drivers/mtd/mtdoops.c?h=v5.4-rt#n272
>
> This is obviously not the case, therefore the error. Note that this could even
> led to a security issue.
>
>
> Bug fix proposal
> ----------------
>
> We fixed the bug locally by applying the patch below. Note that we did not
> modify the kmsg_dump() function. Instead we modified the mtdoops_do_dump()
> function which seems for us the cleaner way.

I agree that this is a better fix, rather than backporting the newer
API. For mtdoops, the only function registering a dumper is
mtdoops_notify_add() and it also directly references the global context
with:

struct mtdoops_context *cxt = &oops_cxt;

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 774970bfcf85..317ecf47fce8 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -269,8 +269,7 @@ static void find_next_position(struct mtdoops_context *cxt)
>  static void mtdoops_do_dump(struct kmsg_dumper *dumper,
>  			    enum kmsg_dump_reason reason)
>  {
> -	struct mtdoops_context *cxt = container_of(dumper,
> -			struct mtdoops_context, dump);
> +	struct mtdoops_context *cxt = &oops_cxt;
>  
>  	/* Only dump oopses if dump_oops is set */
>  	if (reason == KMSG_DUMP_OOPS && !dump_oops)

Thanks for your work on this!

John Ogness
