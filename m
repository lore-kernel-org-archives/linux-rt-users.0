Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908FC433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB8B611BF
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 May 2021 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbhESP5K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 May 2021 11:57:10 -0400
Received: from mail.monom.org ([188.138.9.77]:54966 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346802AbhESP5J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 May 2021 11:57:09 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C46A550038E;
        Wed, 19 May 2021 17:55:47 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id 8E023500143;
        Wed, 19 May 2021 17:55:47 +0200 (CEST)
Date:   Wed, 19 May 2021 17:55:47 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Message-ID: <20210519155547.mdukzibjnaepqnq3@beryllium.lan>
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
 <20210518083712.8237-3-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518083712.8237-3-schwenderjonathan@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Jonathan,

On Tue, May 18, 2021 at 10:37:12AM +0200, Jonathan Schwender wrote:
> This allows the user to specify a separate cpuset for the main pid,
> e.g. on a housekeeping CPU.
> If --mainaffinity is not specified, but --affinity is, then the
> current behaviour is preserved and the main thread is bound
> to the cpuset specified by --affinity
> 
> Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
> ---
>  src/cyclictest/cyclictest.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3bab3b2..a2103c7 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -836,6 +836,8 @@ static void display_help(int error)
>  	       "	 --laptop	   Save battery when running cyclictest\n"
>  	       "			   This will give you poorer realtime results\n"
>  	       "			   but will not drain your battery so quickly\n"
> +	       "         --mainaffinity=[CPUSET]  Run the main thread on CPU #N. This only affects\n"
> +	       "                           the main thread and not the measurement threads\n"

The main thread is allowed to run on any CPU which CPUSET specifies. CPU
#N does not really make sense.

While at it, please update man page accordingly.

Thanks,
Daniel
