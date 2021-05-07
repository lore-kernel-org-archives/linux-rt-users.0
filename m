Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F760C43470
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADAA6146D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhEGQcN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhEGQcN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:32:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B754C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:31:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a18so6996146qtj.10
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+jKoIWdtQJ8aAz92/68ryZDjRetHFCU+l10qIDB/k50=;
        b=a9UOPp98xaQ0l/VwP6PQwzZT4JKRyGuCWaJORDY3AEL8yXw9yHxfhEYhNzYVpQpGjf
         Up0L6KmOr4TzMdWKXTcKhWkWx2nnZJ1CVIiDg9czeKdr/wK+8jt01EnUkvCVlUwdTPjC
         HNSLvBw0Lc/HSWjmO9gU8ZkRPcBmgnihtzApPN632MC8XdoKKM0nw4lAYnBmCWyZePjp
         dYi9Bf4HU3PVEHF+LapqTxvksIa7SeIlbDfCwDT+LJXFedBwFDPtvoMSOqvYSo9vOttt
         r8Df9iBRL5zC2A3Wk3yp+48bxI0Ly8MwRy4eLf3wkHxhrHb/S2EqYIlamFGA0DXJe1uM
         gPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=+jKoIWdtQJ8aAz92/68ryZDjRetHFCU+l10qIDB/k50=;
        b=CFwiR4gZmo4AcJiNbJfJYQdkHpFrPSFmN7320K6QroewoPJeFLHQPs4pqkqyrbU/mm
         iDyFaQ62Ktcm2dYqCs7PEhbtTvRrr15aDroiV7tBRgcnXAuERwjx7+/t+ZMKkGBKWUjb
         tLLS6QOHkwkaMF6icXQCRMhs9RZ91HtWjYjwn9LFlYrWKTuMm39K7NDgnIz0y91oP+vt
         /d+wh8+QOn4vCRzfIcPjfsy7uIOh4TNIcqhVkvWiVO3pVS9fPAsmRTHHrhlyLg+J1kQe
         DXJFfEzdV1VDpg+zjZ9VOXhgLpNVVbKScccN7OZluwzT/UlNr9qwhlPwEWYyowE825d9
         HCig==
X-Gm-Message-State: AOAM531/zKCI2b9BcJutC09jeTL0h1AuMuINpXZ+fbC9vQ2US7Rebi4S
        lS14FuVrDqpdDzqnJ4pqyAGt0T/XnQBRjQ==
X-Google-Smtp-Source: ABdhPJzCpaMGrjGVT7Auy/PaxWDuxWNU9PfFKmPCc40V+g4T+jKqt+3PtiJsAt7sfNOXsUeFG3I7Wg==
X-Received: by 2002:ac8:67d1:: with SMTP id r17mr6932773qtp.242.1620405071575;
        Fri, 07 May 2021 09:31:11 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id r81sm5300770qka.82.2021.05.07.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:31:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:31:10 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 09/33] rt-migrate-test: Initialize rt-util
In-Reply-To: <20210320183829.1318-10-dwagner@suse.de>
Message-ID: <e7d27d3-7767-6051-bce2-1ecea4291da@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-10-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Allow rt-util make a copy of the command line.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 56b7b66ccdf4..daa876d3e2b2 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -535,6 +535,7 @@ int main (int argc, char **argv)
>  	struct timespec intv;
>  	struct sched_param param;
>  
> +	rt_init(argc, argv);
>  	parse_options(argc, argv);
>  
>  	signal(SIGINT, stop_log);
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
