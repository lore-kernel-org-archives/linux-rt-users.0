Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228AEC31E4B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D9520866
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfFNTep (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:34:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39271 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFNTep (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 15:34:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hbryF-0001iW-7C; Fri, 14 Jun 2019 21:34:43 +0200
Date:   Fri, 14 Jun 2019 21:34:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/1] rt-tests: ssdd: Add Licence information to ssdd
Message-ID: <20190614193442.wrsbby4jydcoet4c@linutronix.de>
References: <20190614113747.11565-1-jkacur@redhat.com>
 <20190614113747.11565-2-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614113747.11565-2-jkacur@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-14 13:37:47 [+0200], John Kacur wrote:
> Add License Information to ssdd

> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/ssdd/ssdd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 4e293586526e..2c3a779be9f1 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -15,6 +15,13 @@
>   *
>   * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
>   * and checks that waitpid's return values for correctness.
> + *
> + * This program was originally written by
> + * Joe Korty <joe.korty@concurrent-rt.com>
> + * This program is free software; you can redistribute it and / or modify
> + * it under the terms of the GNU General Public License Version 2
> + * of the licence, or (at your option) any later version
> + * see COPYING for more information

SPDX tags is not something that you have in rt-tests, right? Because a
standard tag would be kind of better than having yet another unique
version of text saying that it is GPLv2-or-later.

So you could reduce this to two lines:
- // SPDX-License-Identifier: GPL-2.0-or-later
  top

- Author: Joe Korty <joe.korty@concurrent-rt.com>
  Somewhere at top where the comment starts.

>   */
>  #include <stdio.h>
>  #include <stdlib.h>

Sebastian
