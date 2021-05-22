Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C0DC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D565F6121E
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEVDtk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDtj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2Hs8it/TanmLskcabAQ5X+l1BRnjy2HZAIOjsWik9c=;
        b=O/CK8Di1PlXoEcJe/bBnARQS25HV+XqJptjW8zs9SAbNYzulqV8jOLejSZoGETzguKUWHK
        bARVURsmtCuuLT4lsiGtcHHnNR1JvDn7pApMRNC5MIbA3r+IJeHhWpm8i3LJB/3dsmTPgw
        aYn9e3lzhGYZYsOn8YBPM79JGFWX+Lg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-8jI_ykhuOwW7rvGiLRTZUQ-1; Fri, 21 May 2021 23:48:13 -0400
X-MC-Unique: 8jI_ykhuOwW7rvGiLRTZUQ-1
Received: by mail-qt1-f197.google.com with SMTP id 1-20020aed31010000b029019d1c685840so17351166qtg.3
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=B2Hs8it/TanmLskcabAQ5X+l1BRnjy2HZAIOjsWik9c=;
        b=OMBpfuoIbmcOXcNqQ8Ie4BmpEmLhFJxIV0DE5TnvcNjs5+sgvS2W2maJCpd2ooctsN
         Z1g56My/q6Fbnwwq81SoZGHcKZB3ol/oyWZ2hOGPAGFgm9DHbC5Tih4vm0hO3RaVRFWg
         9GsSfzlYhmPt4r1soYHTDXjHTqRSYaWOr2vk7pn6rmSNgTNpkilSqNUc1uP0AeXTvE70
         Jp0qR/O3O+4QO1KoritI3veQB3W5hloVCDBZdhI20B7uVGgWjy4Qs5lSnMDdxZWJUBDc
         +96SRyiVDNLhNHMZ9I6eCxcl7Y9k4/pJ0kYriYNKWG8fw5O2u8FHvOMlbsJTmqWkO8YG
         GCHQ==
X-Gm-Message-State: AOAM5312lpeGCYzPEnYQyB3ey+C2tQlRn7smrbyn0O9FTw6Y46NacTaT
        t/2iMk545B19wl2fcbrbiyWlfKS1p+Rp6ht7FU3KDyTonXW9rHESgVnSuhCE4bzN8Zidr63t5vN
        W6AhMfmlTmaPHiAVWg9z4GSLhWbo=
X-Received: by 2002:ac8:45c2:: with SMTP id e2mr15505912qto.138.1621655292481;
        Fri, 21 May 2021 20:48:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgvoUa+cpV7D2Se03VcKalMqtB/SC74fjZMhgZyarBGEJzLKrW8NAdPoqjAybMiQFsh7PieA==
X-Received: by 2002:ac8:45c2:: with SMTP id e2mr15505907qto.138.1621655292328;
        Fri, 21 May 2021 20:48:12 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id 28sm6600315qkr.36.2021.05.21.20.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:48:11 -0700 (PDT)
Date:   Fri, 21 May 2021 23:48:10 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 20/23] signaltest: Add --json to man page
In-Reply-To: <20210519170945.21941-21-dwagner@suse.de>
Message-ID: <ea99e2f4-9664-bd6f-fae1-226276133be6@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-21-dwagner@suse.de>
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
>  src/signaltest/signaltest.8 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
> index 5ce119b54461..da818ecdef67 100644
> --- a/src/signaltest/signaltest.8
> +++ b/src/signaltest/signaltest.8
> @@ -5,7 +5,7 @@
>  signaltest \- signal roundtrip test software
>  .SH SYNOPSIS
>  .LP
> -signaltest [ -a|--affinity NUM] [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
> +signaltest [ -a|--affinity NUM] [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [--json FILENAME] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
>  .SH OPTIONS
>  These programs follow the usual GNU command line syntax, with long options
>  starting with two dashes ('\-\-').
> @@ -35,6 +35,9 @@ Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .br
>  display usage information
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Number of loops: default=0 (endless)
>  .TP
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

