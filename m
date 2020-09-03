Return-Path: <SRS0=hc4Q=CM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E81C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0816520775
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Sep 2020 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlPT8Lcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgICRh7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRh6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 13:37:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951EC061244
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Sep 2020 10:37:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 19so1061394qtp.1
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Sep 2020 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jT5/Js5q2BMjzoWBGTrF1QlxaPlHaAG+VlHn1Y8cbCk=;
        b=jlPT8Lcc9ZzHeSqPh1Y++SnYVAinjX3av1DxnkgAMT8WjGHTGXwBNFubY2gWJPhEb+
         WncPg/+wdaP9gTRwCgtxki4uAw8tKreiHf8EczzLnaa3wXVV/rWxGdFiorhwJnuGf1HN
         yKc8QGxKbqJ668oFI/jvw993rxnmBxnvpLJfpjxe/DPkSobWo0Vhj6YzgmYQh+/RKCdP
         83VDqrvQU/tj8enwcA9fHTd2/1RXffAyT7dEsctMhQThu+mSjdHL4ny+KrqccicaG1vm
         0PSLrwgHb7CF8zqLuWQDJ2GbgfmM5wGDJrxFkU0RTDwUBQ650DLgU68gXIyNbeOM5F4Y
         AObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=jT5/Js5q2BMjzoWBGTrF1QlxaPlHaAG+VlHn1Y8cbCk=;
        b=n5ZL7xYzVwxYNW8sgGlRk7SjaQoRzHJXfgkTgNyiEEmW0p/DRKWUtJxO0gmlVNt8CA
         NSkUaGz2nDG1WHq0QL9+mZ9KHCWaTenPolDZOVX3UPLZ9q7lgBAtConUdgx0mLuQbKOO
         DTD/fCJhog6r5KQG9/eXxO5dMevf5vhC0B5LqXxFJ4nKL/xk7QZEp7MNVuehaTy8lpmQ
         FoysArPmCbx7uqE4W27+Vn6Iv1oRWHKldpPpjawS83dNft9P9T8dtR+MXA5uRG9SkvGp
         yAZSykNWHupnnJMntkUm2jMfigjGGG/c+ofolXXIbviaAbvQ4dX8Y2QhzMFOQoErasEw
         mIrQ==
X-Gm-Message-State: AOAM533svR/1BeRGwm5i1tr/XQbiHButPR3RzQb7jqMg4fO59R/MwH2e
        A3wUr8IRdhLBFkppOzUR+Lg=
X-Google-Smtp-Source: ABdhPJysxG6s+bJCYehc7EGHL3l9Gths9/7Zf4Xc1ku7C1S9otmGZnK6sF//TKfL1MIH8x5nMXQ68A==
X-Received: by 2002:aed:21da:: with SMTP id m26mr4671531qtc.197.1599154677498;
        Thu, 03 Sep 2020 10:37:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id 64sm2717116qko.117.2020.09.03.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 10:37:57 -0700 (PDT)
Date:   Thu, 3 Sep 2020 13:37:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 4/4] signaltest: Only print from the first thread
 stats when quiet
In-Reply-To: <20200903173326.3393-1-dwagner@suse.de>
Message-ID: <alpine.LFD.2.23.451.2009031337290.4001@fionn>
References: <20200903173326.3393-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 3 Sep 2020, Daniel Wagner wrote:

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
> v2: add brackets to make it easier to read
> 
>  src/signaltest/signaltest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 0bf075456ab6..a67eddaf8420 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -417,7 +417,7 @@ int main(int argc, char **argv)
>  			pthread_kill(stat[i].thread, SIGTERM);
>  		if (stat[i].threadstarted) {
>  			pthread_join(stat[i].thread, NULL);
> -			if (quiet)
> +			if (quiet && (i == 0))
>  				print_stat(&par[i], i, 0);
>  		}
>  		if (stat[i].values)
> -- 
> 2.28.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
