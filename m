Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB8DC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B3E613DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhEVDnz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhEVDnt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dyRYyZeiVSpGb/qhU+6e3CAdLxv2Uw4SfprXSb9QYY=;
        b=UIk+Z88tThJP9fg7OqFKxrF1v3QQv6S7+9W53YuFhPCTfbPGmybMh04+jMJSNUJWGdmcWY
        KIluPfcayESrNy8tl+rx8mySDD6DkU0Xh2HrWzFarLfmpyoeF1KObEHBklGhaltRfk8/Ml
        RXfuE5GNvPH/Bv7rv2CJNHp1BAcAM+o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-Gm4mpb7lNtOcOH8rec331Q-1; Fri, 21 May 2021 23:41:30 -0400
X-MC-Unique: Gm4mpb7lNtOcOH8rec331Q-1
Received: by mail-qt1-f198.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso13286620qta.4
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4dyRYyZeiVSpGb/qhU+6e3CAdLxv2Uw4SfprXSb9QYY=;
        b=lEnwmg/32tkapiIgSOkd0sRT8m4FpQ9RU+T+TDdsXetnc3dagswJtHE++l1Ymz0eZ4
         f2S6wUdBg2TODfp1OFpPQxym/xT0z0mi53D15Cjdha80VhfIqrpRqEnKYShsFGnLWi+y
         jXI6CUMIpw9meY489ZMS7byMveL5HpVPRlhU/fhgP8Qx+vzTvh3DtcTEQRqoowndFg5h
         hE5vPzr+08y+h1ayvY/j82+kfoNJvl+m2oAX1kA1NELMh2GagyutMBFIj025v2J/vhHD
         FsemP0VNt0/xwYJJUpxz4u3EEWxLadEAVxdxy5Tx6Qw31iuhSf4XOTGnd3epuKkDoLU1
         01bA==
X-Gm-Message-State: AOAM532Ke4Jgvz2hYXg5g87UAmAuJKT6Y+tvPsTcPSrYg3LkA5u19906
        9hYWzwr4A94+SQ546MBNZVEj3n2CRMU4veUtOhGPw0PhMLxVABsUtmSpOh+MV7xL0abTkY/SEv3
        C3lqVKMkLS7dWiR+MVxlCI4PEOQM=
X-Received: by 2002:a37:8bc7:: with SMTP id n190mr15535517qkd.113.1621654889964;
        Fri, 21 May 2021 20:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykk1EEMQnYHtt7nuUQk8VBF6RHCa2X7o9OmcE4KX8HmfmmGyTIuRj1/MdQcSb1OK1Pag+1NA==
X-Received: by 2002:a37:8bc7:: with SMTP id n190mr15535510qkd.113.1621654889817;
        Fri, 21 May 2021 20:41:29 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id j22sm6089224qkk.58.2021.05.21.20.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:41:29 -0700 (PDT)
Date:   Fri, 21 May 2021 23:41:28 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 15/23] pi_stress: Add --json to man page
In-Reply-To: <20210519170945.21941-16-dwagner@suse.de>
Message-ID: <578a55a-e1a0-178f-9b84-c3888fbed6c8@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-16-dwagner@suse.de>
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
>  src/pi_tests/pi_stress.8 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
> index c3d7889a5cd5..8c43a1ccf676 100644
> --- a/src/pi_tests/pi_stress.8
> +++ b/src/pi_tests/pi_stress.8
> @@ -10,7 +10,7 @@
>  pi_stress \- a stress test for POSIX Priority Inheritance mutexes
>  .\"}}}
>  .\"{{{ Synopsis
> -.\" Usage:  pi_stress [-d] [-D TIME] [-g N] [-h] [-i N ] [-m] [-p] [-q] [-r] [-s OPTS] [-u] [-v] [-V]
> +.\" Usage:  pi_stress [-d] [-D TIME] [-g N] [-h] [-i N ] [--json FILENAME ] [-m] [-p] [-q] [-r] [-s OPTS] [-u] [-v] [-V]
>  .SH SYNOPSIS
>  .B pi_stress
>  .RB [ \-d|\-\-debug]
> @@ -20,6 +20,8 @@ pi_stress \- a stress test for POSIX Priority Inheritance mutexes
>  .IR N ]
>  .RB [ \-i|\-\-inversions
>  .IR INV ]
> +.RB [ \-\-json
> +.IR FILENAME ]
>  .RB [ \-m|\-\-mlockall ]
>  .RB [ \-p|\-\-prompt ]
>  .RB [ \-q|\-\-quiet ]
> @@ -58,6 +60,10 @@ Display a short help message and options.
>  .I N
>  number of inversion conditions. This is the total number of inversions
>  for all inversion groups. Default is \-1 for infinite.
> +.IP "\-\-json=FILENAME"
> +Write final results into
> +.I FILENAME
> +, JSON formatted.
>  .IP "\-m|\-\-mlockall"
>  Call mlockall to lock current and future memory allocations and
>  prevent being paged out
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

