Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC972C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F9760698
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhEGQ1M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhEGQ1L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:27:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1EC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:26:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l129so8991571qke.8
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vORLDE1ZryplqcEI6EpZNNQI/t0PeYxF1F/ozmLA+Ww=;
        b=Zojn9gdDUANwQ2BnttKEbJsCHkPSDT9P4vbe/Qo3azHUiCQI6LBFfrgP0YlD8/RMYA
         A0A+EblGMXaFGiXMtQzS4p1l9iIBvIKCvwngdpxCbKokGRYRqJwnW9f9YIlpolfK3ueH
         EnhnXk4QW/YrLAS4r+4GOuxdwBSilXiNY1HikUsLVyCciTIEatr2WuysYR5ROPnz5zNv
         4SEpY6OnVDZg9sRzga2iEXFJZcJF+F7QxsMpSAqAprGoatSwtj10x3iux6F7v2klv98P
         QzotGk0ilwkQtrt1HDALk6sGseOXgqvNHK32bWkzL3cAvH5VjxdIGmkBEF/bVfy98UJG
         AD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=vORLDE1ZryplqcEI6EpZNNQI/t0PeYxF1F/ozmLA+Ww=;
        b=Fb12q9PiLks4b725pHK0RsubU/zULhGygP6yyCB0wBB0mbjyNy+MqRr0LpcrRYTykh
         LCTzr6u4Tn1uqIxXtOq8brQYJw4BXSrAk5HPUf5FoFiJglqch0ysyPewkbmP7e+tFjob
         dnUsaSnc9MvbKyyRKQCyEnaflZCVFP6BufbfkKBtXdRvHUJuA6KZXpV1WBF+AUUxnsVP
         i/+1s2x89n/ALuo/29p7RJcdaUCnJwmf3jZ3oiqzHdZpDVRIfR21pAtypvGrmUxsVWD4
         z2EOuWUGFfBRyoFbyi2mThZw7O4BwxLd0DSbENM8MDcHuZtacNpb0+QRM7UNMVTca9dV
         ipZQ==
X-Gm-Message-State: AOAM533088ywL5NXAmRh5viBsL1EpJbMPzXuzv1UMT8dSIC0XF7ynHdc
        g6wFt/OcKFcXRyuu2Fn4A+0=
X-Google-Smtp-Source: ABdhPJzv2lYJUYWKsSHfhVWy14DjGtru32as0HFgGRvBYIrWCGIxnMUTGuFs6ohruUCUlqc8sI5Tmw==
X-Received: by 2002:ae9:f114:: with SMTP id k20mr10410180qkg.386.1620404768656;
        Fri, 07 May 2021 09:26:08 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id t18sm5208590qkj.75.2021.05.07.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:26:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:26:07 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 03/33] signaltest: Add missing --output usage
 info
In-Reply-To: <20210320183829.1318-4-dwagner@suse.de>
Message-ID: <db392690-b3f8-385e-a858-d0d9fb41740@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> bdb20cdaa8d5 ("signaltest: Add JSON output feature") introduced the
> new command line option but forgot to add it to the usage string.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b1a7e1db8302..e2ffc0bb8693 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -189,6 +189,7 @@ static void display_help(int error)
>  		"-h       --help            display usage information\n"
>  		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  		"-m       --mlockall        lock current and future memory allocations\n"
> +		"         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>  		"-q       --quiet           print a summary only on exit\n"
>  		"-t NUM   --threads=NUM     number of threads: default=2\n"
> -- 
> 2.30.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
