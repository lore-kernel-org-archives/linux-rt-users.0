Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A2C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B00613DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEVDpo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhEVDpn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MzCbBGu0DjtIvrrxOY/Hba9Rm8p5pHAB6/wuLRFlpc=;
        b=iz+f9zYoVHkE3oOgyihn30aJJLfhPjmBNKZpLJlFdrPJEl7VeRZlGCNo/HJ/10s9jrUCS+
        EZ/l7b2bgjt0N1jcWtErySR/G23WdYEJQYGMdSbDmSQh8CIJ1pWrOyYDxSXYqjS6JbblsF
        6y/WJXLVnWun+KZ6b0chq793xeLhpFY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-mGctXaSHO9WCRdfeVW3yog-1; Fri, 21 May 2021 23:44:05 -0400
X-MC-Unique: mGctXaSHO9WCRdfeVW3yog-1
Received: by mail-qt1-f198.google.com with SMTP id r1-20020ac85c810000b02901fa9798cdb5so11017602qta.8
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8MzCbBGu0DjtIvrrxOY/Hba9Rm8p5pHAB6/wuLRFlpc=;
        b=ShVqDdRbMI0y51H//VramxNBCuZkFUqwGeqsia6D1PEwL/wKoXsNOKbXWMqPuGIIAA
         8M4zrBrvxiACcmaou7IH7j5YjNAqfT/bxY9NK5VyA+coKDZ8hORS36IBxFdCUp0Y3ynG
         OpWoG6OoQ0ikj0Eu1jqRP93yC3s6nRG4TC3pbtaROGyRUD8eedm225UdhRDJ9q/E3dS/
         QAXuK08UXchhi6C5NI4qf1JXEHp0qUMPXigT61Ar7pxLl0WY8HtrcguN6lgwvOQlnb7B
         So87oa2R+k7X44KJVf/tZmhrQu0EpUA2s24/DA080hli1hP+r/tYQT9XYgDkNKYkZGQA
         Cqrw==
X-Gm-Message-State: AOAM530IsCrqVFIoZmSikxCUjfgvFb1hAuQkrcvMgXJsZ8r4DHM+f+q2
        Y8PS8Ev1vtwAwfZ59+Rsd9oakLjtwHbfEeuwkqwjF0fJc33AoLf80QHRDFARll9W0Gj9KBQy8xz
        alZBdewbrDyUc/HVpMNaJB+am0II=
X-Received: by 2002:ac8:7252:: with SMTP id l18mr15130905qtp.78.1621655045352;
        Fri, 21 May 2021 20:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxetyBfvMXabiB3JbwhsnDfvPIolXvhaKnN8tri7SldFrZJKifOJ/2ykm2WWk01b2nx8J9ORA==
X-Received: by 2002:ac8:7252:: with SMTP id l18mr15130896qtp.78.1621655045187;
        Fri, 21 May 2021 20:44:05 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x21sm5589133qtr.31.2021.05.21.20.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:44:04 -0700 (PDT)
Date:   Fri, 21 May 2021 23:44:03 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 17/23] ptsematest: Add --json to man page
In-Reply-To: <20210519170945.21941-18-dwagner@suse.de>
Message-ID: <f05edfb8-7019-92c7-dd67-bfdb155bdad1@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-18-dwagner@suse.de>
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
>  src/ptsematest/ptsematest.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
> index a435e7a6221c..57e1658612c0 100644
> --- a/src/ptsematest/ptsematest.8
> +++ b/src/ptsematest/ptsematest.8
> @@ -4,7 +4,7 @@
>  \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
>  .SH "SYNOPSIS"
>  .LP
> -ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
> +ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [--json FILENAME] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -32,6 +32,9 @@ Print help message.
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. ptsematest is stopped once the number of timer intervals has been reached.
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

