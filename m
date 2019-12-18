Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB25C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B347220717
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLRQrT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:47:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfLRQrT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 11:47:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihcTl-0006dz-3N; Wed, 18 Dec 2019 17:47:17 +0100
Date:   Wed, 18 Dec 2019 17:47:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: [PATCH] Remove redundant wait for completion
Message-ID: <20191218164717.tfcxmwjze2wp23uz@linutronix.de>
References: <20191213091843.8365-1-john.mathew@unikie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213091843.8365-1-john.mathew@unikie.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-13 11:18:43 [+0200], John Mathew wrote:
> Wait and completion was bieng done to
> uninitialized member variable of casted

Why was it uninitialized? If the 'larval' variables is not initialized
then complete_all() would fail.

> pointer. cryptomgr_probe completes all
> the waits when it completes itself. This
> causes the number of wakes to exceed the
> limit of 2.
> 
> This prevents swake_up_all_locked warnings.
> 
> Signed-off-by: John Mathew <john.mathew@unikie.com>
> ---
>  crypto/api.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/crypto/api.c b/crypto/api.c
> index d8ba54142620..b89c44c11c54 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -153,12 +153,9 @@ static struct crypto_alg *crypto_larval_add(const char *name, u32 type,
>  
>  void crypto_larval_kill(struct crypto_alg *alg)
>  {
> -	struct crypto_larval *larval = (void *)alg;
> -
>  	down_write(&crypto_alg_sem);
>  	list_del(&alg->cra_list);
>  	up_write(&crypto_alg_sem);
> -	complete_all(&larval->completion);
>  	crypto_alg_put(alg);
>  }
>  EXPORT_SYMBOL_GPL(crypto_larval_kill);
> @@ -166,17 +163,9 @@ EXPORT_SYMBOL_GPL(crypto_larval_kill);
>  static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
>  {
>  	struct crypto_larval *larval = (void *)alg;
> -	long timeout;
> -
> -	timeout = wait_for_completion_killable_timeout(
> -		&larval->completion, 60 * HZ);
>  
>  	alg = larval->adult;
> -	if (timeout < 0)
> -		alg = ERR_PTR(-EINTR);
> -	else if (!timeout)
> -		alg = ERR_PTR(-ETIMEDOUT);
> -	else if (!alg)

I don't think this is correct. You remove the synchronisation but you
don't state why this is correct in all cases.

> +	if (!alg)
>  		alg = ERR_PTR(-ENOENT);
>  	else if (crypto_is_test_larval(larval) &&
>  		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
Sebastian
