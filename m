Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88944C433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B9613F0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhEGQmq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGQmq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:42:46 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BEC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:41:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so7023861qtx.11
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uz3GPJpds26JxoZ4agwYEKCjElOpBivZoGsokU751iw=;
        b=Za6Mqb92/9m3GTJks0ApuSZlsdT7TkZA6RVTrD+7lqyWYrr4ptpg1NIAq+rbcd9Xma
         mKardqsMSpUQMu2CXRyj1K+ttXDT+dvjZNftCfROaEnyS0W3Jh3S9V2VO98pDZ1rNiOA
         o36fLvasgrymemhN3U2kIskPS2K52UYUwfL3A7flThGrMUXpqb4DttoWCQHeJ378G5sQ
         wdd5JfD4cPWKb45RjiRVSvAcam2BMknqIOywq+3mF0V1G+FG97n5mAPpaMPpNAt/WUOb
         zqlAx3WzWx96o7XHtPQE8+7x+3J1tH+lqLl1wly9STEhHjUpd9BQo24IChMi/hVZ8O5c
         3/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=uz3GPJpds26JxoZ4agwYEKCjElOpBivZoGsokU751iw=;
        b=GCMWBLd4G0yDl2cuhhG2ncK+FlJ1TQGNTXsVQ7+VD6+aYA258ti25LWwwX72g6D2ON
         zdTRcNhqv4/i5gREu19dqrEvfH0wtD+4NqWW0FpkHwZ5mP7lYOZujhIgv1SJum084982
         1sjGMR7KbPJhOlumPtk4XfSI5wzuYSa37JR6DncoW5Gz+iGT4+aLzVTxJUvvD4JAeDnz
         xbYnTHuYi0HXa4A4eCmj0YuiMlsG+JDjMThN+dwo7wrNxkWWm7hhif5FWE6m6soD9iY7
         z6a50oIqQi6HgMDlGpu5I6Es/gGNPwBqopJj06UTgg4veKTt7rB7BRvoDkyI7GWE8jLG
         vyHA==
X-Gm-Message-State: AOAM532GEoGGqu0VLbNRtPrhZGV/8mCKk/fq9VFriWbl9Nf//wANtYts
        pLaKhDM5OjFxLc/Twsik9aU=
X-Google-Smtp-Source: ABdhPJw345htNn/n27QQzMJQ0XfNX4IC9dyfTyADKclWiDVAkxwxG237s+tYkt8zVb/yH8ib+ctFcQ==
X-Received: by 2002:ac8:5a16:: with SMTP id n22mr10054663qta.103.1620405705616;
        Fri, 07 May 2021 09:41:45 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id v11sm4841658qtx.79.2021.05.07.09.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:41:44 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:41:43 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 17/33] oslat: Record start of test
 execution
In-Reply-To: <20210320183829.1318-18-dwagner@suse.de>
Message-ID: <83af896d-c05-447d-afa7-44e97f789f97@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-18-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index ac54d05697ef..2f02f5399405 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -854,6 +854,7 @@ int main(int argc, char *argv[])
>  		printf("Test starts...\n");
>  	/* Reset n_threads to always run on all the cores */
>  	g.n_threads = g.n_threads_total;
> +	rt_test_start();
>  	run_expt(threads, g.runtime);
>  
>  	if (!g.quiet)
> -- 
> 2.30.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
