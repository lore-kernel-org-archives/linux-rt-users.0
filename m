Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9526CC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647E964DF3
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Feb 2021 03:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBQDuZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 22:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBQDuZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Feb 2021 22:50:25 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B1C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:49:44 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 2so5740177qvd.0
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Feb 2021 19:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2+Qxyb7F+F5gYf95maa2V9hutem13f4VOSd3LTSIknQ=;
        b=q/rdhqYuvuy+adwdf640bAFmWpBTJPKS6ofSfZ2+fGAxItfe0JviL/56miMsRx3t2Z
         fLYvg8OhmcsjJQu2SLcscJ57qw4zioU9gZ7K/hCDHUxvCIQ/iYyLeKOubJAm6k15BbqT
         9KtH6tLH5GZnTZ5P9pwOCSPBSwmViQ3bQNB1N6HBt8Z+eonqDYGl5Zc3mvYisDrEkkhz
         j6QNGEtZgG9/ZyUi0biw3ItlLpyjNjkAUienACwvfyQpIV8G+pPQZGYxdRHrpEzEUHTk
         As6dinIztMgJFU476zAaxL4yRwfquf1pStLauouNo33To4Uu/0zjyUF94D/b0iWHw9Ip
         lhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=2+Qxyb7F+F5gYf95maa2V9hutem13f4VOSd3LTSIknQ=;
        b=IinWkC7d5SLa8I2zhfKXiWEl4odOvKvXzAnuJzdkYlQbQz1zoPZ0xXt1NBVn+jK/R1
         13Q2HvXLIofd4HEBLkYYwDUa/QrPDprjDh6sntQNeOxrRVtOLbqQyjArxjrp1VzNWaJ+
         UBhQwNGAxAW6f8CKe4ixh+gnVtqzxVEc3pvjakSKs/wgCOFa2y6+7BoCXq3SbNlaYaIj
         FKPDXL8qG8NyA0wA1lNVnyZgXUkoVJVKeY/G4kXxQXxhOiBMfMgB1Y/hy8UvHmuBc72n
         hvKfKJ1mXI4l93E57G8kzL70D97kPXYBiEC6NGwQYIILpxquSAiBYtEGMsK6ePrt3vnp
         Y2tw==
X-Gm-Message-State: AOAM533GAQ7nASBAEKjHLLOAwHT/2DgYr7hBjVvpy6t5r3LckkyA16xw
        NqYzkDH8DFe/dl/eqj+VkeA=
X-Google-Smtp-Source: ABdhPJyJ8N5WXsItTnKrICs2JoGhUn8qcsVu3Z2XABkq4fkCWOd83W+UmoPboG63pTGGexVslW7J0A==
X-Received: by 2002:ad4:45ab:: with SMTP id y11mr22971341qvu.25.1613533784268;
        Tue, 16 Feb 2021 19:49:44 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id w20sm773512qki.102.2021.02.16.19.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 19:49:44 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 16 Feb 2021 22:49:43 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v4 02/16] cyclictest: Mimic --smp behavior with
 --affinity
In-Reply-To: <20210210133450.6991-3-dwagner@suse.de>
Message-ID: <2f841a52-b7db-4a52-663f-19f3f928ec7a@redhat.com>
References: <20210210133450.6991-1-dwagner@suse.de> <20210210133450.6991-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> Let --affinity without an argument behave in the same way as
> --smp. Run a thread on each CPU. This makes cyclictest behave as the
> rest of the rt-tests when --affinity is used.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 6009ff2a83bc..4c02f067fbad 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1019,6 +1019,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  				    argv[optind][0] == '0' ||
>  				    argv[optind][0] == '!')) {
>  				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
> +			} else {
> +				num_threads = -1;
>  			}
>  			break;
>  		case 'A':
> -- 
> 2.30.0
> 
> 

This doesn't look right. num_threads = -1 will get the number of cpus 
after parsing, so that's okay, it should imply use all available cpus,
and also the priorities of all threads are the same.

As I've explained though, I'm not ready to drop the possibility to compile
without numa, and then we need to think what this implies to the smp 
option. I do like the way you are simplifying things here, we maybe able
to drop smp altogether in the future, or have it just an option that keeps 
the priorities the same.

Need to look at it more, not applying right now. I want to get the JSON 
code applied, this stuff is holding it up.
