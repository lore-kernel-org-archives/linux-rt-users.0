Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B228C32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7C020578
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 15:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfHMP7C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:59:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35317 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfHMP7C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 11:59:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxZCM-0001z8-BK; Tue, 13 Aug 2019 17:58:58 +0200
Date:   Tue, 13 Aug 2019 17:58:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Subject: Re: [PATCH] net/xfrm/xfrm_ipcomp: Use {get,put}_cpu_light
Message-ID: <20190813155858.e4bcbkom2vsiafhh@linutronix.de>
References: <20190717072019.13681-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190717072019.13681-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-17 09:20:19 [+0200], Juri Lelli wrote:
> The following BUG has been reported while running ipsec tests.
…
> Hi,
> 
> This has been found on a 4.19.x-rt kernel, but 5.x-rt(s) are affected as
> well.
> 
> Best,
> 
> Juri
> ---
>  net/xfrm/xfrm_ipcomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> index a00ec715aa46..39d9e663384f 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -45,7 +45,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
>  	const int plen = skb->len;
>  	int dlen = IPCOMP_SCRATCH_SIZE;
>  	const u8 *start = skb->data;
> -	const int cpu = get_cpu();
> +	const int cpu = get_cpu_light();

By using get_cpu_light() you don't forbid another function to invoke
ipcomp_decompress() on the same CPU. That means that

>  	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);

scratch buffer here could be used by two tasks on the same CPU. You are
aware of that right?
According to your backtrace you get here from NAPI which means BH which
means it is enough to use smp_processor_id() in such a case.

ipcomp_compress() is using the very same buffer while invoking
local_bh_disable() before using the buffer to ensure nothing else is
using the buffer on this CPU. This will work in v5.2-RT because the new
softirq code uses a local_lock() as part of local_bh_disable(). This
does not work on v4.19-RT and earlier. 

For v4.19 and earlier I suggest to use a local_lock().
For v5.2 and later I suggest to replace get_cpu() with
smp_processor_id(). Ideally a with a lockdep annotation to ensure that
BH is disabled (which we don't have).

>  	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
>  	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);

Sebastian
