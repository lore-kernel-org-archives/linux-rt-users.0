Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7011CC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3950522B3F
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbhAZRTY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbhAZGX0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:23:26 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B70C061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:22:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id o18so11523184qtp.10
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6LtoExVWMi735ksNq7Kk19VYeOYZuWSnn4ZdL/mDkg0=;
        b=S9tlaCvVzZVQsCdVRSTAzLP74lrNhJIwDaih0h95FA/FzomPIg6DLZTnFDzutBJHXo
         1U3WIRfHDOhUpkcLtHsLI5AYPo5exD/ukb420YLJcjSC+DB01gwuMVWffQEHl/TZ0CIz
         At3yYgYGRC6YHwU2Lpros/jv4KxAK8gPLtGVJe/dkYo3rrzS8gLnNbqGGS6l/g31/ajb
         B8w231ezknSvleJoRGkdXykV5yWQw/M5XEJO+nJw4dMkfygxUR+DjxhDiNyTtvi+7EsF
         mUN/aXpd3owd6+JRyxPrxhr6auKWj6A1PzObQu3Quf3UdTrT3wkkyp2TAB63YzUgM3Bc
         VekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=6LtoExVWMi735ksNq7Kk19VYeOYZuWSnn4ZdL/mDkg0=;
        b=UFzCsV5ZLNGKbiM4HG6tCZTRYLZ9j25B02KQ51apT3QfS11bYZG3TayEXkJsSgJhul
         HEkPXj/FOGZfMjizlHYTqDC8zjxNWGMUUF0+m7/0SOCppkkO6TjL8qfifitHkOglpirx
         Z/LZxKXUpHxEgj9YZDKiZAKY47DuQwtmHDMVuaL3pz/JfsHWAUkuxf+hVaGHH7Ma+fzr
         N0MXm2wTt7YAljUkGJp4/SZWRcESmUnJIoWYQh9v076X/mKg2eeV6jfalJqw5ZxthfmD
         OHE6WlSF5Am7I35yBRiq4pPyjmtvwt8h0GgTYYz800Clji4tXrF/0rtG5uUUc5lYEWLQ
         mfyw==
X-Gm-Message-State: AOAM531vIjKXIj1+pkOWihVq4PCWK/LG5SCyLXT8COcNVDgyO0b/PWd2
        EbhD0OeZ3+wObWIfjErvpoo=
X-Google-Smtp-Source: ABdhPJzDH8W3IRZdPe9MA7mC8VvYtxMrl6wfMZZj5qyGmD0YX/btVZOpUwinDbfKPATrGrZgDcG/6w==
X-Received: by 2002:ac8:4557:: with SMTP id z23mr3985901qtn.191.1611642165477;
        Mon, 25 Jan 2021 22:22:45 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id i41sm13332775qtc.33.2021.01.25.22.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:22:45 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:22:44 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 08/19] cyclicdeadline: Remove unused struct
 thread_param
In-Reply-To: <20210115190936.26148-9-dwagner@suse.de>
Message-ID: <c78417a5-9fd1-62a7-46c-1347a390b020@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-9-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> There is no user for this data struct. Remove it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index cd12c7f313c2..71cde5781499 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -47,23 +47,6 @@ typedef unsigned long long u64;
>  typedef unsigned int u32;
>  typedef int s32;
>  
> -/* Struct to transfer parameters to the thread */
> -struct thread_param {
> -	u64 runtime_us;
> -	u64 deadline_us;
> -
> -	int mode;
> -	int timermode;
> -	int signal;
> -	int clock;
> -	unsigned long max_cycles;
> -	struct thread_stat *stats;
> -	unsigned long interval;
> -	int cpu;
> -	int node;
> -	int tnum;
> -};
> -
>  /* Struct for statistics */
>  struct thread_stat {
>  	unsigned long cycles;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
