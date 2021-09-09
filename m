Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7712C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B60C6103E
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhIITYr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhIITYr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 15:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631215416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+f/PI8H/FYk4KJ/8WOZWG4rSK6fVisYkvhkUFniXes=;
        b=fxpR1fFapQZblWw6ED/+ZL8kQ0HyYZyhfD/Y7IfPQOvjdLgH58Jw0mIRrX/amTSQF3REYi
        Kxzmaovq2lvthJiVVcYs6DZucr3Wwu3tW0QdkvNV0gR5tYDNwHWJuc0fdfVPk+dWJHBoEB
        8ENqtDWB4Z0xWZvhoO9pC/cd2TwWc84=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Q2sLbbG0N4iLYTDqtwKG8A-1; Thu, 09 Sep 2021 15:23:35 -0400
X-MC-Unique: Q2sLbbG0N4iLYTDqtwKG8A-1
Received: by mail-qk1-f198.google.com with SMTP id u19-20020a05620a121300b0042665527c3bso6338323qkj.14
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 12:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=H+f/PI8H/FYk4KJ/8WOZWG4rSK6fVisYkvhkUFniXes=;
        b=6hgR0PB4x/Vdr+343FDglz6jSr0cq2pKfb6YNsSOFawFopClrDwBl70nMxg3MeGKZS
         KPDUKE/iGFw6XsGG3+X2mjCte0HfPNAJSOo8msN2otCqcSI3JR9HZ2KtwXGRRhOr8zm2
         Ye1hYNuXo1jR18sxMWHMwY4BumatP/x35U2rqxlAUjGYj6lqgrAmAth9uJYTIdu2eugG
         e50Mv7eTb6njiIZ26Y3wpuNT76/bnfjGRuhjOnEf0NbXkPXFnck6nV8WZM7INVowKtQd
         eiJIkjRHr5rJ7fLkvnHs753oyD2ubOm+CKkstii09sCD2NPTgV8ek/O2mK+ycLKTfei4
         A9Yg==
X-Gm-Message-State: AOAM533qsBtlyWl3xE/6bdQA9NWSorEjn9Ui3XoBhzH5x+b4hOLCS7rU
        Xb3S8pHwPZnqPfm9gJleJ4bKd0vgVO65eZelrdIleI+vFmfBlHKS3VdD4iRJUvdETWbksydNqPe
        z+shciXuggz2+Gv7w7MvyJcHkGL8=
X-Received: by 2002:a37:9401:: with SMTP id w1mr4297921qkd.166.1631215415194;
        Thu, 09 Sep 2021 12:23:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmBJEzTQshuAOkqt4Hb8AN2V255HtilkY4SQ3gAtrV19g3AEDktyN+GECI7dvSLavcRpIUMQ==
X-Received: by 2002:a37:9401:: with SMTP id w1mr4297898qkd.166.1631215414971;
        Thu, 09 Sep 2021 12:23:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id g1sm1963102qkd.89.2021.09.09.12.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 12:23:34 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:23:33 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 5/5] rteval: kcompile.py: Gracefully handle missing
 affinity information
In-Reply-To: <20210901080816.721731-6-punitagrawal@gmail.com>
Message-ID: <b1c5699-17f8-39c8-02c-5a5fd5a4dc3@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-6-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> kcompile either sets the affinity of the workload threads to a user
> specified list of cpus (using taskset) or binds the threads to the
> local numa node (using numactl). In the absence of both the following
> hard to parse error is thrown -
> 
>     Exception in thread kcompile:
>     Traceback (most recent call last):
>     ...
>       File "...rteval/rteval/modules/loads/kcompile.py", line 55, in __init__
> 	self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
>       File "...rteval/rteval/misc.py", line 62, in compress_cpulist
> 	if isinstance(cpulist[0], int):
>     TypeError: 'NoneType' object is not subscriptable
> 
> Instead, add a warning to report the missing affinity information /
> tools and continue executing the workload with no affinity - relying
> on the affinity settings being set by the kernel.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/loads/kcompile.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index d1955c7aee3d..5c83b78525e5 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -51,8 +51,12 @@ class KBuildJob:
>              os.mkdir(self.objdir)
>          if os.path.exists('/usr/bin/numactl') and not cpulist:
>              self.binder = 'numactl --cpunodebind %d' % int(self.node)
> -        else:
> +        elif cpulist is not None:
>              self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
> +        else:
> +            self.log(Log.WARN, 'Unable to set job affinity - please install "numactl" or pass "cpulist"')
> +            self.log(Log.WARN, 'Running with default OS decided affinity')
> +            self.binder = ''
>          if cpulist:
>              self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
>          else:
> -- 
> 2.32.0
> 
> 

Wow, that's some messy code! (Not yours, the original).

I think for embedded arm distros, numactl is not always available, so we 
shouldn't tell users to install it, and just make the code work when it's 
not there. Also, it should be perfectly fine to run without passing a 
cpulist, so it's not something we should warn the users about.

You've got the right idea to just make the self.binder empty.
I've got a version that cleans-up a few more things,
I've tested with no numactl and no cpulist, no numactl and a cpulist
with numactl and no cpulist and with numactl and with a cpulist.

Could you give it a test on your arm system?
Sending in a separte mail

John

