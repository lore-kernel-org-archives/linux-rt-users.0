Return-Path: <SRS0=AM/X=2C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4028C43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC80E2067C
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfLLRqH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:46:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46505 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfLLRqH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Dec 2019 12:46:07 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifSXM-0007pR-HS; Thu, 12 Dec 2019 18:46:04 +0100
Date:   Thu, 12 Dec 2019 18:46:04 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
Message-ID: <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
References: <20191208210625.5999-1-ukleinek@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191208210625.5999-1-ukleinek@debian.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-08 22:06:25 [+0100], Uwe Kleine-König wrote:
> This fixes a build error on arm64, mips*, ppc and several others
> ---
>  src/queuelat/queuelat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index cccb50ef0cc4..98346f346f82 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -283,7 +283,7 @@ static inline unsigned long long __rdtscll(void)
>  
>  #define gettick(val) do { (val) = __rdtscll(); } while (0)
>  
> -#elif defined __arm__
> +#else

Did actually anyone look at the code? I somehow missed the queuelat
thingy completely. Now that I look I think I need further assistance…

So what I select as frequency for the !x86 case? And why.

That freq. script reports here:
|1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1599.096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 1870.318 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 1599.439 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792.809

I guess I pick one…

Could someone please figure out the actual difference of clock_gettime()
vs rdtsc() so we know how important it is. Based on its current
implementation, if memmove() takes >1sec then it ends up undetected
because only the ns of the timestamp are considered for.

>  static inline unsigned long long __clock_gettime(void)
>  {
> -- 
> 2.24.0
> 

Sebastian
