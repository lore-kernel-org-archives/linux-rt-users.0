Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54891C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2684C61177
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEVDyP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDyO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kkaxyin/4IQUa/o/rrEcCKuMmC5NV/agOvtGhq/NtXQ=;
        b=EIH9/YuR/2HvtjJ55squ7lnaVCrklt2ndyQTnZvBbrFDlt16XtR+cofD+XPvRL/hI3yk+3
        06Skgfa5zauzWqyk0fOcvk584xYcAhhig/psZmwcMxg5u8kAcQN2Giu1fJ7BMgW0eGnXL6
        HFrmH3dTbb9AL207tea1oJpAcG1k2Sk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ykffPofhOJKVVpAaWm-GEg-1; Fri, 21 May 2021 23:52:48 -0400
X-MC-Unique: ykffPofhOJKVVpAaWm-GEg-1
Received: by mail-qk1-f199.google.com with SMTP id z2-20020a3765020000b02903a5f51b1c74so7763097qkb.7
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Kkaxyin/4IQUa/o/rrEcCKuMmC5NV/agOvtGhq/NtXQ=;
        b=c/bIqNikous7D14CRAriND58qpFe6Ph9gP39ZdiBcUsQ+9B1ZiRA4HITOvDn0knTOA
         M9nASadCqT4EsTMndDBZWROopphkh7bByo5rDhPQHxXpAzlkTmFiNxrUZyYEB/gAhBEW
         K9nCKGcbMb098gFt9jjCNcWVFTIZCiPKR7eM5JvDmP0i23iBT9MZfHtflBZsTRczYTKl
         +mqrtD8opVwjsxq537K3e2ozBvfxu3Fiftxo1Vqtjx22zQ/pVb940whCkCwUEvP663iL
         N8wyj8AWPv9K4KYN6Pc4QkoxKZSummZlp2TF/YJFsZQ/MhBcIqj/mcJgIcEfP7uDVE1n
         b2Qg==
X-Gm-Message-State: AOAM5330cvxoc58IKv0lUXdiRFvHmXeGEX+pHBwuodsK3AgXofBOFCnP
        G3ttoSqVElMyAGo7eWo7WOj/UtFvWIzcOaPueM0SEFduaqB+wdGtQ4Yz0vz/zvfp1uWMf0r5GaX
        9pxEoxb8E81u8LnRGl3LLUOght/s=
X-Received: by 2002:a0c:facf:: with SMTP id p15mr13173768qvo.57.1621655568090;
        Fri, 21 May 2021 20:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ39bJX8lkLh1xR9CuEHxNMUWiN+uOc1x7lQRgxGwUhp38nJxwyN5KJKCTj06hOP8WDt5mmQ==
X-Received: by 2002:a0c:facf:: with SMTP id p15mr13173753qvo.57.1621655567939;
        Fri, 21 May 2021 20:52:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 42sm5716817qtf.37.2021.05.21.20.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:52:47 -0700 (PDT)
Date:   Fri, 21 May 2021 23:52:46 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 22/23] ssdd: Add --json to man page
In-Reply-To: <20210519170945.21941-23-dwagner@suse.de>
Message-ID: <3aeeccf7-bcb-96ac-adab-af89a6603199@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-23-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> Add the newly introduced --json command line to the man page.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ssdd/ssdd.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
> index 5c29d0abb732..a3b9d790dec4 100644
> --- a/src/ssdd/ssdd.8
> +++ b/src/ssdd/ssdd.8
> @@ -3,7 +3,7 @@
>  ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
>  .SH SYNOPSIS
>  .LP
> -ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM]
> +ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM] [--json FILENAME]
>  .SH DESCRIPTION
>  Have a tracer do a bunch of PTRACE_SINGLESTEPs against a tracee as
>  fast as possible. Create several of these tracer/tracee pairs and
> @@ -25,6 +25,9 @@ number of PTRACE_SINGLESTEP iterations to do before declaring
>  success, for each tracer tracee pair set up.
>  .br
>  Default is 10,000.
> +.TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
>  .SH AUTHOR
>  ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
>  .PP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

