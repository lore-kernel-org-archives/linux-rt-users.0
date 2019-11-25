Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97269C432C3
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22420740
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfKYOde (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:33:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYOde (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:33:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZFQi-0006kD-2d; Mon, 25 Nov 2019 15:33:32 +0100
Date:   Mon, 25 Nov 2019 15:33:32 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 8/8] rt-tests: Add SPDX tags
Message-ID: <20191125143332.kgntzmakzhvkap2s@linutronix.de>
References: <20191125141644.4429-1-jkacur@redhat.com>
 <20191125141644.4429-6-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125141644.4429-6-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-25 15:16:44 [+0100], John Kacur wrote:
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 1c515ae1354c..1862435e7a8c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * High resolution timer test software
>   *
> @@ -6,10 +7,6 @@
>   * (C) 2008-2012 Clark Williams <williams@redhat.com>
>   * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License Version
> - * 2 as published by the Free Software Foundation.
> - *
>   */

The original text says v2 (only). You replace it with v2-or-later.

> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index ba804f519950..5a883d341f2e 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * This is the latest version of hackbench.c, that tests scheduler and
>   * unix-socket (or pipe) performance.

The "original"
(https://web.archive.org/web/20090701000000*/http://devresources.linux-foundation.org/craiger/hackbench/src/hackbench.c)

was imported to rt-eval and then moved to rt-tests. I know at some point
Ingo (and others) heavily modified it. But the license was never
published/stated so I'm unsure if it can become GPLv2-or-later.

I'm not an expert but I don't think this is correct.

Sebastian
