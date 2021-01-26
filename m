Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC0C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EA52075A
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbhAZGZa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbhAZGQk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:16:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8DC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:15:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l23so9059408qtq.13
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=73t5AAMyciJqT6GKTKWQx7uk+Wej260lEyyKvE89tnE=;
        b=uM/nihXa1V8vuO7RYP23vEPyf14kLDdztWSvjSWKq7Dolj4XzfRltYohMGfs6+1ApY
         0H3llfUV0pz6MI356iKhgfgRRZuCx6FojQXEJzVdycoUphll58jdY++x/ZH/OeZbnqyg
         tVG3fZeOL/KJMUNI/glJqOgWtpX8ALlkew16l/ZSLciKp50RHeRaeLH6+w5w73hcFAMs
         tRqrPb6bJ0e0XeFbD5ungv6Ju9PD8VOJ2xcKz/BRn9X706PReAO6Nj8XLtK3SPwuMm8/
         ohMPb00IUpqYHpp5/Bqe085npapizwKRNxZoqLH5RZf05Lgy6x2F5OtJh0p1vnA874zu
         gAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=73t5AAMyciJqT6GKTKWQx7uk+Wej260lEyyKvE89tnE=;
        b=d2P6WR1QS7iWXmJ45Uc9AyBUIZLK7+B92oT3sqt3tM9Lp3r+TTNqLU5/L9VfU+LTI9
         btZ2XB9Eep9A+Xd5v8DD0W7AmiNJfvIyZ5DagxCtOrymrlUtrxDpS4Y5wwyJqyUwaGOP
         cTaQvEuDmoKWT9ERAh1gwbNizfhBYcBhdFBUIhc32a9veXrx94cJ3FBDMIW//bEtN6lQ
         WR7wCoxW4rM7al0pIqWOHMQ23dNW9oHgmJA5jRBX1xnlJ74EtcuE3pEfUvWaW7PS3nMf
         hfqeElXzSK3s7SbHLoOhmrNSr3zjcGjYqy00fgMDaepaMCgY8iNG2Ru14Fj6hMfJsMKv
         gH9Q==
X-Gm-Message-State: AOAM531GABt77rn7+5htR3KjEnqtM1AChln0Dl/xhUQf+6L56LHJk8I4
        sbIERYe+ilQYE/Zu8IePswE=
X-Google-Smtp-Source: ABdhPJxQoNwprMPkI4Ic5XireLYXY/Q7eyFoNXz3L/7b/2KXIMlzV5sOFNuYxKGCdnZgEdfMujm2hw==
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr3835365qti.371.1611641758991;
        Mon, 25 Jan 2021 22:15:58 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id h125sm13550401qke.49.2021.01.25.22.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:15:58 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:15:57 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 05/19] cyclictest: Remove libnuma API version 1
 support
In-Reply-To: <20210115190936.26148-6-dwagner@suse.de>
Message-ID: <67e6ce44-3f71-a9fe-629b-e4d6d26fa9d1@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> The code depends on libnuma API version 2 or higher. Remove the
> leftover.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c0e7600b4740..245752dae2af 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -807,17 +807,12 @@ static void display_help(int error)
>  	printf("cyclictest V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  	       "cyclictest <options>\n\n"
> -#if LIBNUMA_API_VERSION >= 2
>  	       "-a [CPUSET] --affinity     Run thread #N on processor #N, if possible, or if CPUSET\n"
>  	       "                           given, pin threads to that set of processors in round-\n"
>  	       "                           robin order.  E.g. -a 2 pins all threads to CPU 2,\n"
>  	       "                           but -a 3-5,0 -t 5 will run the first and fifth\n"
>  	       "                           threads on CPU (0),thread #2 on CPU 3, thread #3\n"
>  	       "                           on CPU 4, and thread #5 on CPU 5.\n"
> -#else
> -	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> -	       "                           with NUM pin all threads to the processor NUM\n"
> -#endif
>  	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
>  	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  	       "-c CLOCK --clock=CLOCK     select clock\n"
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
