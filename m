Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9DC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3C613D0
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEVDvB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDvB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yf5qAGevww32NiU6ymCa45p/ASgD146kgnooo1d+X/4=;
        b=aMAHEy10Vql+csEGrG80aWNZYNNZIY8+VFDWB6m0Iwu0bKlyTZj4WqFnwJuYzaoGdMXVXU
        HNO5J2g6uHqSL6Rav1zRfs/849WB7SSvuxLbtgINesWSoRhK0P3diJ2bvJeNZoPR0OzuxW
        jXp6rUYS1w/dT3PUw2Z9zbwSMYTfIXI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-E3oCKt6TOAG5ha0Up2YXIg-1; Fri, 21 May 2021 23:49:34 -0400
X-MC-Unique: E3oCKt6TOAG5ha0Up2YXIg-1
Received: by mail-qv1-f69.google.com with SMTP id b24-20020a0cb3d80000b02901e78b82d74aso19393203qvf.20
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Yf5qAGevww32NiU6ymCa45p/ASgD146kgnooo1d+X/4=;
        b=B/8qKECo8ogGQyEqe1V7R+H2XLA6iqNrds/k32ZkFMiwjIdUBbS+ywMFuyzeCrZxtg
         cVxyyaoa31di/6IHx5Ea7KjcUOztTNJqaDVVphO8SBXhVILd05vCX3T003vjGE68llJh
         7G10hdiGVgWgwLBq9JDt5p4xwfzFx2PAY00alrJ48NDR64Bg727YhTd8iCjq0fok2rU9
         UBLlpD7jc72HIaj97MH5/QwHI0L/72kqexZxseqYvmnONYVWtvw+ILGn3IC3YXSBTsOa
         xP8zJRC3bpxysA+xuD8XFTOVwt07pgfxdbiaeW9tyK0kdT66jckbJKgZLRQUNCFIU7+4
         jqHw==
X-Gm-Message-State: AOAM532ILolcBa8lG/I5rriD9zTN4cOkjLw9LlsT97N+WsNXyXJ0Yedu
        RRXKbuh7TegyMVyy2ozLLS7n0pIrEfZbsnv+95UoPHz5nECm30pYGqzWF7PL/FvuadQCYxWYiuW
        w8GtpNCltwIZk28fYPDGlJnKzH6w=
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr14772697qtb.220.1621655374443;
        Fri, 21 May 2021 20:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB1JajUyiQVFER7n8Fe5quX1kaAs2kRP0WA2E19/z4BQvuyKgJp9lFZcm63m7O/k19bedibA==
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr14772686qtb.220.1621655374304;
        Fri, 21 May 2021 20:49:34 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x10sm6212427qkh.124.2021.05.21.20.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:49:34 -0700 (PDT)
Date:   Fri, 21 May 2021 23:49:32 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 21/23] sigwaittest: Add --json to man page
In-Reply-To: <20210519170945.21941-22-dwagner@suse.de>
Message-ID: <a243f779-b536-222f-fec-c8e105f45bd@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-22-dwagner@suse.de>
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
>  src/sigwaittest/sigwaittest.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
> index a2dc1bc080a3..26ad333e2841 100644
> --- a/src/sigwaittest/sigwaittest.8
> +++ b/src/sigwaittest/sigwaittest.8
> @@ -4,7 +4,7 @@
>  \fBsigwaittest\fR \- Start two threads or fork two processes and measure the latency between sending and receiving a signal
>  .SH "SYNTAX"
>  .LP
> -sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
> +sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [--json FILENAME] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
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
>  Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. sigwaittest is stopped once the number of timer intervals has been reached.
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

