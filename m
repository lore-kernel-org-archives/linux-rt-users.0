Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8687C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56A9206B9
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhA0Dya (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAZF4i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 00:56:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F35C061786
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:55:35 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t14so7909937qto.8
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4y60WtgLiKVmM05DXdXtolHaMNEr23SClZeVI3NhhlU=;
        b=a48KmxNqHX6Bk3NmOtY2oIRF26vMLIMOSdJw4/ECrSDvgIgu7RPEB6TkKCzXOnDZPU
         KeOjSTFygWxrcP3vtSUIaWGRZiUKMCZOv5lvBG1CS1gr+UNslZdeJFL0kFYzwYjxfNXR
         xB2ZiKLKpbu3s/QRx+JrmrvDYkpuorgDCJ0EVMpyusfMyWaQbb3b3s4OYAxSUcLb3drW
         WuubAYDh2YPGwttINp2wULgO1IvwI3YJ36Gp3kutLRTY2p/Xpc7xAmqH7beALwmU1sfa
         vSqyTlG4WGEnALlk2HQqHEDnxXcfBr9tsE5DRt7GrfnHcYPhFaJRtgJ4HFdZ/xNow31J
         NLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=4y60WtgLiKVmM05DXdXtolHaMNEr23SClZeVI3NhhlU=;
        b=Fx2zmM+pftEHJE8qbZIcdUJxIllJMM1Z23txpAxa3DkriaY9zZ2MDMVLeJVg8DjWho
         kTZpUF+cn/hEhQ22PDnqQBR37r9Po/CuetdFG9Thngc0pEblWl5qX825S5vlvmNPVHO2
         yBK9V88W5rfXS6CbqlnU7cF/Ml9EzoIzRrU2xnjbQjC7lE9ijRnPXiPLxIk/D+Sj2UVf
         S8KQE5Z/3ZdTC9Rki0GTif6p9Qc+rwY0fc5S6GhUy8zuuCEkrFhEMbDwFmj5D8vv9g7E
         11hZLSGN0a28OIcYVKO8cVvq+MeGa21VkZ3vE+cOq9dhadlRAFgWAyRfytnmMvKfdaP1
         q+0A==
X-Gm-Message-State: AOAM531JlZeW0fKHc4diKvMrd9GyPz/4HL+H0KCZFOQaK6mfYnBgcbFN
        KzI6JyPM8bFHPGcd/2Xivxc7jM4P+ohOww==
X-Google-Smtp-Source: ABdhPJwkvK1ZzaLvrqLbxKlzd56HUia18fPSSPWtlPyrjOsQ29Qs1GfN0umEvatGJNuLhEXz41wJJw==
X-Received: by 2002:a05:622a:1c9:: with SMTP id t9mr3837878qtw.244.1611640534486;
        Mon, 25 Jan 2021 21:55:34 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 202sm10109125qkj.92.2021.01.25.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:55:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 00:55:33 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] cyclictest: Mimik --smp behavior with
 --affinity
In-Reply-To: <20201218141935.24151-5-dwagner@suse.de>
Message-ID: <f273ca2-e80-7713-7caa-6dff464d388@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <20201218141935.24151-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> Let --affinity without an argument behave in the same way as
> --smp. Run a thread on each CPU. This makes cyclictest behave as the
> rest of the rt-tests when --affinity is used.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0e6519125c2f..b9b0eb3575e3 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1024,6 +1024,8 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  				    argv[optind][0] == '0' ||
>  				    argv[optind][0] == '!')) {
>  				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
> +			} else {
> +				num_threads = -1;
>  			}
>  
>  			if (verbose)
> -- 
> 2.29.2
> 
> 
Well, --smp historically combined -a -t and threads at the same priority
You could argue that it is reasonable for -a to automatically imply -t
but I have had debates with people about this and we settled on -a just 
specifies the affinity, and the default number of threads is one unless
you use -t.

I'm not sure what you mean by this makes cyclictest behave the way the 
rest of rt-tests does, the rest of rt-tests should match what cyclitest 
does. That said, I did some quick runs of signaltest and -a seems broken,
sigh.
