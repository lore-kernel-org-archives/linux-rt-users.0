Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E45C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD796145A
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhEGQqP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhEGQqO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:46:14 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE89C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:45:14 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j19so7035330qtp.7
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=E/+YtiQ6dkqEgcUfURIXvBxm+juCgazo2F/iXNaBolg=;
        b=AbJ9gM8zamwBoVtk7PiNV8BoMsP/gOQya1UpLh4WUzc9OSz4+wQXUARlZ2r1oH2UJg
         ebGP8dcmdeNUVM+tvi7QBc/MfJRSQd1lnQ1ptuYmVjmTd8ZmlQ73JXRPR1ho9MtcgolM
         ADZhtcrZHMVb9dIz47sh8sfPKXhRSXLelY+EA2ISEjnilHkflvkH/cbVejAQDMiO6KLT
         8WM/gnjTzQKp97GuLwDq/k6AexAZKEUZfIThlbZmhwxXpX5OP4laMtFJilCbESxD+mih
         Oj/n58JS1oH/k4oP45BfF/Q6/45r+QZwGMFu4yvlR7oI8N9w3nM+NQvmT2TXcua7saGO
         sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=E/+YtiQ6dkqEgcUfURIXvBxm+juCgazo2F/iXNaBolg=;
        b=VSVi/SUx/rlEKMXb3bl3Kkx4/AeA9gdhwR3UFO3bploYqxoZjzN+deVMaNyAzzX3G6
         8bcWWABFtSWFer4Hfk0vOBmI9e4cugPnUoG7jgGWmV95nbCP0Mh0/p7vzVYkRKV3dyRd
         fzKxb+SeYC4X5eTwEoJYGTUujsqNIR13rznLCt+jzeHB6hA8B5vPquPPPu8/eZ0BqfUd
         vU31++jgDLgLFImvCkvZstTYNp66kLrWN9HiZrVNL9nwkCnonf4au1t11LccXmN1gQ8n
         5vFAgdBLab0Pmm9cS3RBHmRrQe17KPmYJKQW4kFcYP5UI6WqK4KuSRqse7nm43ipjzhr
         of9w==
X-Gm-Message-State: AOAM531GwCkJ8TiFFpgVsyL0pyskYChP+W+SJjNkVx0vf+ZHby3SRTxa
        0G9bRVM9+1O7FCwRIEW+7EY=
X-Google-Smtp-Source: ABdhPJz0c2lmLGBRYjXz3L8JQ2J3ZVe4antJK26na8dOkqusEQ7cLJGMy5b5cIkpzHoQjVvhTx5yXQ==
X-Received: by 2002:ac8:5550:: with SMTP id o16mr10063170qtr.7.1620405913741;
        Fri, 07 May 2021 09:45:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id c187sm4981018qkd.8.2021.05.07.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:45:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:45:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 21/33] cyclicdeadline: Record start of test
 execution
In-Reply-To: <20210320183829.1318-22-dwagner@suse.de>
Message-ID: <23508228-7e7c-1e-376f-4f7eff63c6@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-22-dwagner@suse.de>
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
>  src/sched_deadline/cyclicdeadline.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index e6811838b62d..a649e5a0fe5e 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1213,6 +1213,7 @@ int main(int argc, char **argv)
>  	if (duration)
>  		alarm(duration);
>  
> +	rt_test_start();
>  	loop(sched_data, nr_threads);
>  
>  	for (i = 0; i < nr_threads; i++) {
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
