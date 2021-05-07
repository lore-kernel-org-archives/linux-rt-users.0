Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4425BC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE64161451
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhEGQbY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbhEGQbX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:31:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202EC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:30:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i17so9027247qki.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dcu0DKztD+GIQgRxGs/B4WScdSfvDvnaHF6wAG6jfX8=;
        b=hOyCzmTeepaS5vrlMwl0V8HvQfVb26K2n9TUyXQneIG+CC+MqsMbl2xPqAYy2u722N
         Rg9p6VFPzjrNJME410USXPy5SteLHo/t5LQtxFnWVgzjtxMPG5x6B3OL4231bZKydkSr
         N0mUBfcZ2hD0+ICmE83UPRKoKOVsTdGDuOk48Z54m/3cGlsgm5wjeNQ0z8sNlJ0+qPoc
         URgYVPY7lCPUV6qUCPdR8iE5JJvuNIvu02EXrlQoBuOav/yBLIRm1myLAhQwAA5S4Kvf
         4dxPMhChQH/Hgvv1kHcekJl+fKJWgm6nSRRp47/kIJ84rRFFQBOBhyXEK9Nf9m4mETfP
         A9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=dcu0DKztD+GIQgRxGs/B4WScdSfvDvnaHF6wAG6jfX8=;
        b=WE7LdUcFo+dRnHxBqqnAFV8BJhYmd91m4ngLv8KRL0mNRzfEs777L3iPckf4dGGfqS
         I5uvMIxhgGtwTO9lOiBxeOJkQGRqpiLtOiS7p2Oj77cY5mgU94Cn+GpTbFs53pNePCKH
         4ivveOxtquXwUnCdcPMknZKyn9QXxRXLv/60ByPnIk3HJcD520aAsGdqMyJrpumU6xck
         OZvv5+is0mCCzfMHnDObTyMlV8AkEOrxGrDkPMXx0P6y5ZJlKn5KykOFjWWg4DXpR4dp
         Kp/EksvRnwJ7Jwp7daSJ1c8fzs5/ZiEnK+n7weeG2ucvB882L731hy0RKtN4Tl3iQTYX
         2Yzw==
X-Gm-Message-State: AOAM532xkYupQh1Yk25vfiBYSDIETiXxRhihOcuy/OibohPEHHCg3nMp
        sCcN0Pebg9NdIQoUnoIFpyffXs3bfU+/jA==
X-Google-Smtp-Source: ABdhPJz5xJCQ2p1uJsKjWN3PibXN1qiR9YQaDRaR/4/taPkyFYco7Sypv1b7zt9pxDsS14ix/dSWvA==
X-Received: by 2002:a37:7d85:: with SMTP id y127mr5542137qkc.76.1620405022978;
        Fri, 07 May 2021 09:30:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id f12sm5170470qti.63.2021.05.07.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:30:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:30:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 08/33] ptsematest: Initialize rt-util
In-Reply-To: <20210320183829.1318-9-dwagner@suse.de>
Message-ID: <82cd508-2485-f089-d018-10e894f0132d@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-9-dwagner@suse.de>
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
>  src/ptsematest/ptsematest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 2755bfde5210..eb7ac4ccc823 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -401,6 +401,7 @@ int main(int argc, char *argv[])
>  	sigset_t sigset;
>  	struct timespec maindelay;
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
