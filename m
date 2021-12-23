Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D6AC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Dec 2021 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhLWQD2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 11:03:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhLWQD1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Dec 2021 11:03:27 -0500
Date:   Thu, 23 Dec 2021 17:03:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640275406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXSe9/5inwpHwW+YAtKtG9Yzs1PptI7qRTKy7hchzyA=;
        b=GbDMT3ur4iOxB0Rl9lGe4uBCxOegKA2H1Hj6eEKCV2AbRU18zU6rBFfTq6xtPG/0AImduz
        BeFrDs3ZgFhNP8fkNOEcIkRhvjvjjNI0NpAMd5QZaZkSbr+4/8BlmkkfeHqkblu5JyJd21
        olKd56tRwDQSmvV8BhHHonSwztudpZeHmaMnVdoc0onK+DH3ZSw604Reg01FuNMlzvsFul
        FQKt8hP6J8RxDffWTXVgMG9Lpn3qjBwZGSuUwZxwe6GNHtZabpvWy8lOI3+H+hG+0+LoV9
        CuNIN/CGTlbrDW4jJEmX6sEyP/ShXoykKSnfW5XQ0IvJNTU2eHLpNP0UzI53DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640275406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXSe9/5inwpHwW+YAtKtG9Yzs1PptI7qRTKy7hchzyA=;
        b=3GM74BqKpLB76lIX66rh0taaa4Rtaum/m5VrLxANAprVBuBwgoQ1AZyVByxqStxutE6bZd
        CuYi5QMPPYFtRADg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oscar Shiang <oscar0225@livemail.tw>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Correct the comment of numa_initialize()
Message-ID: <YcSdzd3jmjV/rxBB@linutronix.de>
References: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-12-23 22:01:07 [+0800], Oscar Shiang wrote:
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * numa_available() must be called before any other calls to the numa library
> - * returns 0 if numa is available, or 1 if numa is not available
> + * returns 1 if numa is available, or 0 if numa is not available
>   */

To quote the man page:

       Before  any  other  calls  in this library can be used numa_available()
       must be called. If it returns -1, all other functions in  this  library
       are undefined.

Based on that, neither 0 nor 1 is defined.

Sebastian
