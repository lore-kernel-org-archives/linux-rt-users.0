Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE451C43461
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775BA6144F
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhEGQfl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhEGQfk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:35:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEE5C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:34:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 76so9026786qkn.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=oexczIhg6W/UHEpeLLHvVu/3cQMXF5GHPpA4wBJPffE=;
        b=XH06hMbpRzpSEakIm8LyrsD9G9p0n56VawBo5TMYWzD3573obDSt3hiIwrAT8k8PQ+
         LqWAxrQNffGQ52ExRKsR9RgCJ1CyL87ELhWibs38VnG86RNWd1hLTzB4Sd1PXTcdYVZo
         yRARCybG5+LZfS/lrRLcs2yECdcHvouwXslVhr4Ef5SDRn73BtSO30mB01ddnalwjeG9
         88STvUJSDMwiMYW7KDWulz2KY+TJO8AsV58Qun+dPI/0aag+nQvXsIYdPyktudo30pup
         Lohl3IThm1wsx7hslAbwN/gtHXyDPo33Gtd/F/me3MbHZHAPhT0SZkHruc+44+i0NtyR
         2tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=oexczIhg6W/UHEpeLLHvVu/3cQMXF5GHPpA4wBJPffE=;
        b=UmvfROmyTmsqGHyT0pJCZtUPXwHUbh+N4WEZXRZlz7MGfWlZwucP37g9R6eOOfyUpC
         VgYqReFXtN2gYmHwXdVAxKmRwbt5eUVGqtGg357x+KphW3lO+7GQ4rO02VcbR2nySysk
         OJisPHPbK/AjgrRhg2Z0XPHfaZdzvQAAsVEw7cDVN2QY7QHDgv5eeKo35hKWMU58afFK
         INT8K+HKiq9TG4CZPZO9OGiod/IDnfciGSRhDrk99kORJG+2hcVguCGiGgHS6mxih1o4
         sGjofOYzhT3PTYPeSfBUIWH7o9Ozki2oBAfFHNZkONDqfKUwHckYFwaxQtbB+6ruX9GT
         O13w==
X-Gm-Message-State: AOAM531w+QbvAwSVJL7aB5nrvrgwZCauB9svBD55pPiQayYAhMZy99JD
        6Ze/JjMYiGJo0QmfeddihFc=
X-Google-Smtp-Source: ABdhPJxwjJs1xD86kao3LH5ho0sbZsWXhwm8d1GyXB9sdNc+cA5+EloM9vEaILu5gM+/25EFuKzGOw==
X-Received: by 2002:a37:be87:: with SMTP id o129mr11096799qkf.284.1620405279638;
        Fri, 07 May 2021 09:34:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 189sm5128401qkd.51.2021.05.07.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:34:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:34:38 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 13/33] svematest: Initialize rt-util
In-Reply-To: <20210320183829.1318-14-dwagner@suse.de>
Message-ID: <45457f7b-4e9d-5e62-eb64-eac9e0a21aef@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-14-dwagner@suse.de>
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
>  src/svsematest/svsematest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 23f84bcbd3dc..24e5e7adf494 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -514,6 +514,7 @@ int main(int argc, char *argv[])
>  	if (myfile == NULL)
>  		myfile = argv[0];
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
