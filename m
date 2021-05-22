Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A3C2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D86121E
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhEVDo2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231258AbhEVDoY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621654979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QyszZa9lQnG4HlKw6Z5MumLTkqm9QfmWhUwkiL49i4=;
        b=C8NW+u5blDoG2d6Asz0ot3zTe/9tVlbOcao+EU9VMwiGIfQ2jVDAJMqnhOUgbahtvHG/80
        RqOtxl3gGsra8VY2Vnek7L6pEYQz2MXSySzixJtjePFXUdctu0SBybMFoKoWkb+d8zYvE/
        dY5bIZI4CUvOknhsLFjd9b3J6zO/dZk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-JhVuUj4hPX-BORRusixp5Q-1; Fri, 21 May 2021 23:42:57 -0400
X-MC-Unique: JhVuUj4hPX-BORRusixp5Q-1
Received: by mail-qv1-f72.google.com with SMTP id i14-20020a0cf10e0000b02901eeced6480dso17911919qvl.4
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2QyszZa9lQnG4HlKw6Z5MumLTkqm9QfmWhUwkiL49i4=;
        b=ZGAQhCxdZ1WA1yfI2QHvNqq2KdMMyjaowobGRkslpeyPj013Q1NNfpCCdKfVMpd3Jd
         EGivZ2+Dbb3g9rL4eM6FUz3v/OZurNT3W/kMn+wL9jVRwNqlT7SAFMjhiDbJ7xatrvYa
         /8FWbGJc32NAKQLcyPUTARJFI8jd6/A/xAu7VR+Jz2q/dIvlW849qH5bHUkjqHiNmeiM
         YuOCz2+h5tpbUpqkLYGxizh/FryOTaFBAVhSrIXZOyVE4E4munTVPuWB67aeCDMHttem
         EkoAIyICe03m2QsKx235nsJyp5X/wKSry6SlppZ7vt9tdzRCh4fmGd/5+Twu0yA9LixA
         zuTg==
X-Gm-Message-State: AOAM532pjNut9H3H2wD1zr9jGNXsVrJed3m2GH/xmZxKsufprYR0/JwZ
        HhYVMkK0kA2E4D21gJqC5pOm/P/DyEDXSnNOEcjHbkorMwbdxt3AM0lSk5Ov5zU4vXcSQNC4Juw
        LatQvetb8amasi+u0qswK0DSEDpQ=
X-Received: by 2002:a05:620a:1390:: with SMTP id k16mr17342008qki.99.1621654977409;
        Fri, 21 May 2021 20:42:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzRMaI5TURX0jq6xeqvK8zdEYmreFPre+MNcB0QGNfXen3Kim3Y7Abm7nYPybyW2peSMHFgg==
X-Received: by 2002:a05:620a:1390:: with SMTP id k16mr17341999qki.99.1621654977260;
        Fri, 21 May 2021 20:42:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id q6sm6290218qkj.78.2021.05.21.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:42:56 -0700 (PDT)
Date:   Fri, 21 May 2021 23:42:55 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 16/23] pmqtest: Add --json to man page
In-Reply-To: <20210519170945.21941-17-dwagner@suse.de>
Message-ID: <f8feae9c-ffbc-1463-a06b-6b45c64de6dd@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-17-dwagner@suse.de>
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
>  src/pmqtest/pmqtest.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
> index 36678d0c5026..4fbcc5c27ce2 100644
> --- a/src/pmqtest/pmqtest.8
> +++ b/src/pmqtest/pmqtest.8
> @@ -4,7 +4,7 @@
>  \fBpmqtest\fR \- Start pairs of threads and measure the latency of interprocess communication with POSIX messages queues
>  .SH "SYNTAX"
>  .LP
> -pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-q] [-S] [-t|-t NUM]
> +pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [--json FILENAME] [-l LOOPS] [-p PRIO] [-q] [-S] [-t|-t NUM]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -35,6 +35,9 @@ Set an artificial delay of the send function to force timeout of the receiver, r
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful for automated tests with a given number of test cycles. pmqtest is stopped once the number of timer intervals has been reached.
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

