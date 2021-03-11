Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB2C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55EE64F8E
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhCKQRs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhCKQRZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 11:17:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8BC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 08:17:25 -0800 (PST)
Date:   Thu, 11 Mar 2021 17:17:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615479443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMs00k8/IQ0SfVFlXJtBUOvo7hg5ZqL1PQ82ulsM1a4=;
        b=DiGXF9zoIZykCp+npio296/dFAdNap3mN6CrsYaHgSKNbIY5Tz59804rRI6mliMAlovNj7
        ETwTBcBJpJYsGhQbb4fMDuYVyKHCrzZirO/sbOoa4EmMEFvgFVz8AOKwPpTMPZnlNwc7wP
        uc6ktjmhatoUgvfgAEBpUDYDgYeG+VVMrYpQnHEgxP+xJP0zvkqHYikmzeOPjRgGCXghK/
        oCatV2pJM6tztakHNMjE9wlntmkdXssYRRmO7CAORj6dATf9U/WTstPB/D8zJ1xfnkYOu7
        /BvpkMXsZIyPzC/eWy5qtF2o3IrfEKEUO5fBE514jZbqUdPlLzNQw7lrSaBqnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615479443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMs00k8/IQ0SfVFlXJtBUOvo7hg5ZqL1PQ82ulsM1a4=;
        b=4ub6msMxhz7SCXRf/EFyduPkzQ3vaJv9FYMo9g+An9rpHPX+UQqhWr942gkrYjb3+1oUBg
        lzefN0s/j5VxKxCA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org
Subject: Re: PREEMPT_RT benchmark
Message-ID: <YEpCkqfg4umsS4lv@lx-t490>
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com>
 <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
 <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkbJ-x4Er7RKhvrThtmmf-MT5uakdkc2G0ZL06i-fGsmBzmSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[ again, no top-posting please... ]

Michel Macena Oliveira wrote:
>
> If I understand correctly  when Cyclictest writes to the
> cpu_dma_latency file, the processor does not sleep and remain
> full power all the time. Is there any problem writing a RT application
> (not a benchmark one) with this trick?
>

Well, if you do it for the benchmark, but not for production, then of
course, the benchmark is meaningless.

>
> Could it cause any harm to the system?
>

Talk to your CPU provider.

Yes, sometimes CPU providers warn about that, especially for x86 (Note:
I don't speak for Intel or any other x86 manufacturer).

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
