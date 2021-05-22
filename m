Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6BFC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5273361182
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhEVDsF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDsE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tml1fW+tQaCeGvIyRZiXseAgBUaoCPOXuDIrj3p6dZs=;
        b=FDhtTakQ+kKcYQ1kq66uDnexx8NMIZNxnuj3i/mesDj0YfIpIqgZ58pvHp+dnjWP9A/JxC
        IAdX9ndMldud2Aeo4DI2jSuV/P1a6xuS1jgQ/8PSLIi6J7dT6z42MUFOZiGfWIChDbLBRd
        90wI2Y9YZ28QUA4X3yZSYzAIvFc+mZg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-e4CvE1iPNDibWFmFOwrKuQ-1; Fri, 21 May 2021 23:46:38 -0400
X-MC-Unique: e4CvE1iPNDibWFmFOwrKuQ-1
Received: by mail-qk1-f197.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so18762549qkl.23
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Tml1fW+tQaCeGvIyRZiXseAgBUaoCPOXuDIrj3p6dZs=;
        b=tqHKy1ysTUte/c6JhML5HMUOODxnzR7wRTt3Ig11WShFBeQvPfRJ1YHADHBXjK3PC2
         O4B9KFR7HTB1w/+KNiD1hX50qViteekrl/B+XvnPIoi20xUf/dp7RwBtU6DdfgKNtWCU
         TaKDlPH+l6vF3PF8guspLhLR5+gDscyhM4AYZThQHySiGrAeofO/gptL6+38dKUy63aP
         NUL8GBa3ufOLBzGB+PnL31WlnoClYi7T1r6wzO9fsO55sc24MxilFk7AFZamBXIOrj6u
         mYHrOcAMLA4jEXW6BpPDyqkjKpaAKCY1659WVs1m5bC2l3+vMP78LYmhxvW6qwAkhr4Z
         Pqtw==
X-Gm-Message-State: AOAM532sFQRUwmibROYzyUrO6byFWhDdFU033WALaNqDwMZcGLhh9b1p
        bhDYSjhWxHxKC0+IHR/90Lx/oYxX2v3O8Uteu8wxrEEyxtmaO5LNlceUjiMZptakzX8FKy/LZS0
        HAbKerzu/x78987U6TRw6XtIJufc=
X-Received: by 2002:ae9:e406:: with SMTP id q6mr15723897qkc.406.1621655198125;
        Fri, 21 May 2021 20:46:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzASHtcDMfQ0ZuMIS0k30ofBaKpcUzzvX1mzKixu0zh4yLnm3jFNs2VnOSwVUcjTlWjdkXLRw==
X-Received: by 2002:ae9:e406:: with SMTP id q6mr15723887qkc.406.1621655197967;
        Fri, 21 May 2021 20:46:37 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id y8sm5970117qtn.61.2021.05.21.20.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:46:37 -0700 (PDT)
Date:   Fri, 21 May 2021 23:46:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 19/23] cyclicdeadline: Add --json to man
 page
In-Reply-To: <20210519170945.21941-20-dwagner@suse.de>
Message-ID: <24b36794-f1d9-709a-9011-912d90644b6f@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-20-dwagner@suse.de>
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
>  src/sched_deadline/cyclicdeadline.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
> index 59b60ca7bd31..1a56ed028d81 100644
> --- a/src/sched_deadline/cyclicdeadline.8
> +++ b/src/sched_deadline/cyclicdeadline.8
> @@ -17,7 +17,7 @@ cyclicdeadline \- This program is used to test the deadline scheduler (SCHED_DEA
>  .PP
>  .SH SYNOPSIS
>  .B cyclicdeadline
> -.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [-s STEP] [-t NUM] [-q]"
> +.RI "[-a [CPUSET]] [-D TIME] [-h]  [-i INTV] [--json FILENAME] [-s STEP] [-t NUM] [-q]"
>  .PP
>  .SH DESCRIPTION
>  .B cyclicdeadline
> @@ -38,6 +38,9 @@ Show this help menu
>  .B \-i \-\-interval INTV
>  The shortest deadline for the tasks in us. (default 1000us)
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-s \-\-step STEP
>  The amount to increase the deadline for each task in us. (default 500us)
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

