Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCFC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5FB22A84
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbhAZRT1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbhAZG2r (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:28:47 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24922C06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:28:05 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so7381755qvd.13
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QtsRYwtAnBDQnrLE4iDEJlMtV6KIPECR8VSA4TovxQ4=;
        b=vU+mx6Yh5bkIK/c/CLWG7WvSceCZ8sXS7gD3PfNPCXeAtnJ5oDRVzJeTlCuUGsVKpo
         BdhgQo1xatjiAWmI6WqwxFUqBRqClsWexbFnRnzc0KKn7VRQuoInQ1Xo+B4oIJdSH1HY
         r0OUc+3mDI04iWxTLhlruTAwFvis1OdIcTAU3AzTIrPbwI0MzKwttslBxuwnzIBKeKx7
         +zPubiQthflehC9ZxRSIlHJKaKFGSi7rtc2/WYJoZKwjEz+vTh0sBKvBloNRSfS6k942
         wuVF/fFfiMkmwXSyZ3oTmGIidXDZucX9kLLCEwgz3ZpR6wf5GNjggH1I6BHo/uKCzS0x
         yJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=QtsRYwtAnBDQnrLE4iDEJlMtV6KIPECR8VSA4TovxQ4=;
        b=LjpX6t5TinX7fKXMZW+RW2aBELA55d/WT3ESyIumHPi1lam0B8YRe0a4sT59KgGgsH
         C5bLqR5MlybyYuTIggQPjd2ay9G75kllOhXo9JkmAR0avSKKUFkt4JPqnkYHuzAivIAR
         nmUVogBLnniQcGNNGw3wCuG2n1/ldZ+svsjxECGade3xI8WHoRKjw/3+wOTDg75kAkZa
         gz+IkZcmWOMHHrxYeZ+iR1tEJLOBN6CLcxEbLJfvqDcgx7BZvylDhFEZMDQpcwLhNCHH
         TQIYSEVZeBtKc+SYSZ62zwbUU6D0JKKiFJM9RUwnAx83NjHXMIzwuPCAN3PbEjVWCmvx
         ziEA==
X-Gm-Message-State: AOAM5307Klp1bSJG0HB+BXYbd2meyf7OxgyrC5gQaFzdjxQ+AUCUDXQ+
        CVV9O6JBmLfYkPpLtvOR7T96BgmHIzE/Sg==
X-Google-Smtp-Source: ABdhPJwRljpyVhBYSUZY80hgb982U8JhuOjhJlh93QdDSMt3FUyJbbB145LlStAQuoTPnrACPNWY3Q==
X-Received: by 2002:a0c:8f09:: with SMTP id z9mr4176297qvd.25.1611642484321;
        Mon, 25 Jan 2021 22:28:04 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id a9sm13519174qkk.39.2021.01.25.22.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:28:03 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:28:02 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 06/20] cyclictest: Move verbose message into
 main
In-Reply-To: <20201218161843.1764-7-dwagner@suse.de>
Message-ID: <654149f9-ed10-7d5-b51d-d618c41c24d7@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> By moving the verbose message down we print the message with the final
> affinity_mask. This also handles the case where the bitmask is not set.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a34b2140f940..7e84c25f7070 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1020,10 +1020,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  				    argv[optind][0] == '!')) {
>  				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
>  			}
> -
> -			if (verbose)
> -				printf("Using %u cpus.\n",
> -					numa_bitmask_weight(affinity_mask));
>  			break;
>  		case 'A':
>  		case OPT_ALIGNED:
> @@ -1732,6 +1728,10 @@ int main(int argc, char **argv)
>  		res = numa_sched_setaffinity(getpid(), affinity_mask);
>  		if (res != 0)
>  			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
> +
> +		if (verbose)
> +			printf("Using %u cpus.\n",
> +				numa_bitmask_weight(affinity_mask));
>  	}
>  
>  	if (trigger) {
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
