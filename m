Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF33C43461
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477882072A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlkFmEw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgICQni (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgICQng (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 12:43:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B4C061246
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2020 09:43:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b3so2363965qtg.13
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2020 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ojQgWOAh6yaJsgNW+vetWMFSegq77ITX/fkxmjQ4+Ls=;
        b=FlkFmEw/i6cITzNvq6Q/NUx2iglfds8ED2qPABWGnXSER4siIbOgKc9CV3ME0xspwL
         Tg4S/etANAm6sUl2RdyCvKqZ3+YKfa2nwMV4Vl8hfBogKUz2sMytPErzYnexmRH/HtBc
         ECosEMckxlcGAPF5Kmesp52FPT3isL+YuyUfGM/lOsfa3kwXafP8EOhak9PhN7PfsvAL
         TJJ8pJh1JXJTbg5IpCjeZexRpCgMJ4IVnGBNBRVh5mm3XowZ4GAnM/GNloytGKLuO7TB
         jIqzXwodWe6QwyFLn+THq8oO7N6TxBJALqDm4H+lQsODWUdl5BZ7eFrhL18nFu4YpW4W
         P4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ojQgWOAh6yaJsgNW+vetWMFSegq77ITX/fkxmjQ4+Ls=;
        b=Qtv1Bph6c2KpPBvfxRv4NEJ66hInEeXm6dfs1UagJw+pszzX3qu7LGxV36wADJdKBt
         40qCc2OpTPEfgHh8iwx+RJJgwozQwlbagpyHuPrEjpXRK6AYsKzdxKtYLRptC1BTOKPX
         P78J6LBqx6Jthvy7CVFN5C3o93PqQyGeqXMyjtUJNb6eBcepXSr/8u0zdD1e2+srqJmE
         3sEp44tZdqUvdrUDbYgUPc69acc+BHV/JZjp4eP2jt2cMUssJN9P0fIq8VJaoZOyvT14
         nqKINZCkHDhg7M9gJa5AQl7D4buErNvb41sPpFLJ6Ly322GHaGeNQEXOzfuCNfSxr6Si
         un1g==
X-Gm-Message-State: AOAM532ys9oGMKT4BSfnqzLBtclSpQjTFxqm939KOS4zicn6Gqw7AfJM
        RS++ZXNwD/JgK4cYSxFYzS0=
X-Google-Smtp-Source: ABdhPJya2DqsSkUvjvUAPO3chCtA8ki10V2//QlJ8tdKsWny+4UYgnQWMVpvHO/czhgrxscglLYarg==
X-Received: by 2002:ac8:37bb:: with SMTP id d56mr4373970qtc.222.1599151415440;
        Thu, 03 Sep 2020 09:43:35 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id u66sm1688948qka.136.2020.09.03.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:43:34 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:43:34 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 4/4] signaltest: Only print from the first thread
 stats when quiet
In-Reply-To: <20200901154657.30198-5-dwagner@suse.de>
Message-ID: <alpine.LFD.2.23.451.2009031238260.4001@fionn>
References: <20200901154657.30198-1-dwagner@suse.de> <20200901154657.30198-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 1 Sep 2020, Daniel Wagner wrote:

> When the quiet option is used don't print all threads stats. The first
> thread will pause every 16 cycles for 10000us. This will show up in
> the max values for all other threads when the final results are
> printed:
> 
>  # signaltest -q  -D 2s
>  T: 0 ( 4517) P: 0 C:   3121 Min:      5 Act:    8 Avg:    8 Max:      19
>  T: 1 ( 4518) P: 0 C:   3121 Min:      5 Act:10065 Avg:  639 Max:   10073
> 
> We could also remove the sleep but then the system gets fully loaded
> by the test. Furthermore, we would keep the path pretty hot and that's
> not ideal if one wants to test the eratic signal behavior. So only
> consider the first thread for the stats.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 0bf075456ab6..679cb9792777 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -417,7 +417,7 @@ int main(int argc, char **argv)
>  			pthread_kill(stat[i].thread, SIGTERM);
>  		if (stat[i].threadstarted) {
>  			pthread_join(stat[i].thread, NULL);
> -			if (quiet)
> +			if (quiet && i == 0)
>  				print_stat(&par[i], i, 0);
>  		}
>  		if (stat[i].values)
> -- 
> 2.28.0
> 
> 

Because of c operator precedence,
something like

if (quiet && i == 0)

is almost always wrong.

Most people mean

if ((quiet && i) == 0)

However, in your case, the first one actually does the right thing.

Just to make things clear, I think you should write

if (quiet && (i == 0)

Then the code is much clearer.

If that's what you intended, then please resubmit the patch and I'll apply 
it.

thanks

John

