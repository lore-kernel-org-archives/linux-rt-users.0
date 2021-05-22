Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87456C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C30561177
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhEVDz6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDz5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7VU1+qJ0aP4UdXBfxFKUftIgpQGnSiyeXiz2aF0x08=;
        b=TdndhtVWYA8GfAn1SYkUiDYJKnyX4GN5AmgGTR84AML8Y8LA9GaYdMOTYBHkr4y9ett24q
        B/3NXrPRWAq67ok7tt5mfUVUCbsXbEdC5b6j5iUvdIbVahNP0wQkTnu8qz1SOrce5QSish
        s+Ra7yonVEVQoWlFqwduDF4cFR/wWzY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-LAh5hw1UMVW6w0QZCImOeA-1; Fri, 21 May 2021 23:54:31 -0400
X-MC-Unique: LAh5hw1UMVW6w0QZCImOeA-1
Received: by mail-qv1-f71.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso19444077qvb.18
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=b7VU1+qJ0aP4UdXBfxFKUftIgpQGnSiyeXiz2aF0x08=;
        b=RVDvmsI3Tg2DMjqhixb5NEABeOdE2WHDjwdcE/CzZ/OYBD8uoVlrNou3ygBkmyOUWV
         ipcpYrQlWcAQbajO6MqBnLwIr+MgRqu3OFBIRQ0DRtQc3ZZZWOtuxltjozo99xfQcbN/
         JfM/0lBhMCR555CUltK+JUWRlpHeGmMM6OGiM3lXXhBGwkJnVlhiCMTfcyRfOVjGNsUV
         x7vOf7J0TNB28SKXdZlTQyN55nedDxHaU5QvP3p84xM9beY9Y/+aKzgwHOlj8mJTsSON
         XFJEwhHayZPtdBX03EN5NErItuuo4zCL7fAjjG/SfvPhdDoqjyZHAz+DpYYwsH/8qTKd
         rL+Q==
X-Gm-Message-State: AOAM5311DCLeyE7WfB94G8nANlmBadArAhj03OZ3N6NDRwL+B1sr4moW
        llBBMDa7Y8DQFlr9oBhzf5pf/u0w2LZ3e27kbBF2GP1b7lm+pXVksm0TqTI3PY12U/fUDbPgewa
        2YZsrZhorJ1ml429sTIgzttb0wro=
X-Received: by 2002:a05:622a:1756:: with SMTP id l22mr14701937qtk.367.1621655671255;
        Fri, 21 May 2021 20:54:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOgazxvuF5HbcO0f2NoaS1ligWRO4Yab7OY9D/uCyUivIUIvvdURoX7wJ8VZgKRZ1VtO2y0w==
X-Received: by 2002:a05:622a:1756:: with SMTP id l22mr14701930qtk.367.1621655671096;
        Fri, 21 May 2021 20:54:31 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id r125sm6405558qkf.24.2021.05.21.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:54:30 -0700 (PDT)
Date:   Fri, 21 May 2021 23:54:29 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 23/23] svematest: Add --json to man page
In-Reply-To: <20210519170945.21941-24-dwagner@suse.de>
Message-ID: <4b2b1812-d152-a158-8c90-24834c301af9@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-24-dwagner@suse.de>
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
>  src/svsematest/svsematest.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
> index 828f9154e974..93abf55f3d4d 100644
> --- a/src/svsematest/svsematest.8
> +++ b/src/svsematest/svsematest.8
> @@ -4,7 +4,7 @@
>  \fBsvsematest\fR \- Start two threads or fork two processes and measure the latency of SYSV semaphores
>  .SH "SYNTAX"
>  .LP
> -svsematest [-a|--affinity NUM] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
> +svsematest [-a|--affinity NUM] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [--json FILENAME] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -32,6 +32,9 @@ Instead of creating threads (which is the default), fork new processes
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. svsematest is stopped once the number of timer intervals has been reached.
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

