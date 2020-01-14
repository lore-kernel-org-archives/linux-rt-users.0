Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1933BC33CB1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2AB24679
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgANMre (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:47:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgANMre (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 07:47:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1irLbY-0004Hq-4e; Tue, 14 Jan 2020 13:47:32 +0100
Date:   Tue, 14 Jan 2020 13:47:32 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: [PATCH] crypto: only wait for completion once
Message-ID: <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191231100051.658-1-john.mathew@unikie.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-31 12:00:51 [+0200], John Mathew wrote:
> Proposed fix for the swake_up_all_locked warnings issue discussed in
> Link: https://lore.kernel.org/linux-rt-users/20191218165334.k4suur4gzlu62ibs@linutronix.de/T/#t
> Currently multiple wait for completions are scheduled for the same algo.
> Only one completes and the rest are returned with ENOENT. This patch
> checks for the name of the algorithm going to be waited up on, and if
> the algorithm is already being waited for completion return EAGAIN ,
> without accumulating completions and returning ENOENT.

Have you tested this patch and if so how?

> Signed-off-by: John Mathew <john.mathew@unikie.com>
> ---
>  crypto/api.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/api.c b/crypto/api.c
> index d8ba54142620..1c6004e7ab6c 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -234,8 +234,12 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
>  		alg = crypto_alg_lookup(name, type, mask);
>  	}
>  
> -	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
> -		alg = crypto_larval_wait(alg);
> +	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))	{
> +		if (!strcmp(alg->cra_name, name))
> +			alg = ERR_PTR(-EAGAIN);
> +		else
> +			alg = crypto_larval_wait(alg);
> +	}
>  	else if (!alg)
>  		alg = crypto_larval_add(name, type, mask);
>  
Sebastian
