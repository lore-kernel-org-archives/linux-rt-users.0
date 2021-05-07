Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6679FC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E016144F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhEGQe2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhEGQe1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:34:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45699C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:33:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 76so9022331qkn.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9qBMnC/hpCwL0M5hXM8mgttR4R5wi513lcQ7WDBOvk8=;
        b=KtqbH3i8aCc4kA2pHBTPtW/6AeWR+SqSNGdDIb8FazEnR7oqmL/qv6kLtG3+r7fZuc
         hgtxJG7iXqQbqRhl91fIPcsZMZtae2D4svuj1DX/hZ5+R6Bz9nDotezTq10Gl3Ss9k7m
         qFjjgJJTAmv+SlNpoMccQsGaeCUUfzjnTKK8HFpee8YPAs01YNbBN5ria++QlfuwhtPQ
         5chWi1sIfaEufourkbCFKc6JwpjvxZc0I6R6xl1iMZg2XaID7wzI/KK6ljIUGDUcGDWm
         bG4Qx3g+6FBId5pCPxRTwrLcM7W1YVA5UiXvN84YQZUaB0RznaYxAfgAgoYGc5e1h3IL
         jx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=9qBMnC/hpCwL0M5hXM8mgttR4R5wi513lcQ7WDBOvk8=;
        b=OFEuCtNOkdYvQpJCMpi0UdbuFD0KLcKdK4pwmi8FINz6z6E65CxoRTqYHU/0fPQH9f
         H249HuvADzJhKdM1t9JfYoZ5Ksg1dv/Jl3+F7nsyWFXSB3oOEBjXTBzWBZrnSylwpf9a
         QT/jlTA0KtwTNTFtM08f5YHuq5ukztlzUQXveYgbA4MOLsMn84/il5eOyG9tjMi/kyF2
         cyrbpQNMUqAIFJYqK8gO08tuRx/YPaSKctiPrF9fsQGU9QQbQhjNdkOwtrb/du/Af5/m
         sOk7Ft1g1q+OC9NBvFvn5aAQWrLKXWpnPwl0uujj2zFeeA/npGJsRiDt+NZQLSHb3CxD
         8DrQ==
X-Gm-Message-State: AOAM530taeR4XWWmFdXoqesyjECunsUAXPgKJIqTXsoURhBpm5jHOSBr
        TN8sS5mB3eNUW95KNmra4JLXaUNosv7DVg==
X-Google-Smtp-Source: ABdhPJw9Xt+Kgem62uW/uJ14+LSSCCgWXFfj5b9QxnAcTglYjzdtmb6X+hbsD6NpwBBUJVVXugj1+w==
X-Received: by 2002:a37:5ca:: with SMTP id 193mr10254794qkf.356.1620405206614;
        Fri, 07 May 2021 09:33:26 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 7sm657437qkd.20.2021.05.07.09.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:33:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:33:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 12/33] sigwaittest: Initialize rt-util
In-Reply-To: <20210320183829.1318-13-dwagner@suse.de>
Message-ID: <688de7b-b751-ff3-ade5-c0e487efe5@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-13-dwagner@suse.de>
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
>  src/sigwaittest/sigwaittest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 0cdf30a6a769..a1808409730a 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -473,6 +473,7 @@ int main(int argc, char *argv[])
>  	char f_opt[14];
>  	struct timespec launchdelay, maindelay;
>  
> +	rt_init(argc, argv);
>  	process_options(argc, argv);
>  
>  	if (check_privs())
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
