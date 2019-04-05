Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030FC282CE
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C32146F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho2Inj2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfDEQ2a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:28:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36242 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQ23 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 12:28:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so8756182wrd.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BCb9FvP9CMrw9/78rICEh1UmoaibB8cdWWp6LeB/yeA=;
        b=Ho2Inj2mlitlIdcJ4IxZ1V2xlTqNtI31kbtctwEvrUdnIeL50hb4iZ0zXGAa6YKHIN
         +RqDG2jSIyRDow4csKD0J3l0bApCqXhmCLrY/wsrlWilS/hPhn+ArwREg6Y6Ecx2P7uU
         Uid5k2fpJaE/WtSxak2Co4kT3RQ0RIQmuersV43Ccjb2+E+3nw/lYFinvHA4YHYmNIkB
         stXS/ScQyJUYOeHF+pqIh6fYatc+l0T/Q64IIM/77JRAXpOyVqKTBFYpIvPj2o5+fht7
         3nKgbgm1N8gGLAU0t0LjM2ah0JvXOnrraCLDnUDQYd6cP02R0cAADXMmhJe9QunkkyT9
         Da2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=BCb9FvP9CMrw9/78rICEh1UmoaibB8cdWWp6LeB/yeA=;
        b=pGkmr2BRzLtCXZdq7qwgSoD9JADYUKirSHtTwW4xhARIDoBM03HKfh/hs/QKxcxC+Y
         O2qJLxpfAmxGiAoOAFVSW5ewrun07Qfx7bOgUxV6ZKN4miQ3bZS/aivhLbh61gqVY5rb
         jiitM3veyEq5FbBGtdBUZruvbyMWILJJk9gdK4e+xOQO1x7C8pkkVVhr/pD+MM+E+jlo
         wqyecIxYuWV9VCAZHRgjQJWtWmoIVn75uvxTulsInmWsvLgzzGHd9B7+MKQxLwyIz5O4
         M7FVD0u/2y0/1f4lig+vTSV8GF0oWUoqjXxumR2Z5dYDtFpzQoHL3YRj1w/gg3v/aro7
         OaVg==
X-Gm-Message-State: APjAAAVl3ux9hwy7U9tXKtY5hllGo04cdBJdJrml5WapRMZpN8WBCyme
        P9rdptqWlWBcdA2FDB9+cIo=
X-Google-Smtp-Source: APXvYqxAjA6WhMLayKQLHnyTZTiUhanVHxT3B6CgI7dTbwCzZDu0wFZEr7azbWsvx46FUgI+crK4Wg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr8686182wrj.228.1554481708351;
        Fri, 05 Apr 2019 09:28:28 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id y1sm63305316wrd.34.2019.04.05.09.28.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 09:28:27 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:28:26 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <daniel.wagner@siemens.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/4] cyclicdeadline: Fix stack corruption
In-Reply-To: <20190312172436.18314-2-daniel.wagner@siemens.com>
Message-ID: <alpine.LFD.2.21.1904051828030.8480@planxty>
References: <20190312172436.18314-1-daniel.wagner@siemens.com> <20190312172436.18314-2-daniel.wagner@siemens.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Mar 2019, Daniel Wagner wrote:

> The buffer is too short for the string.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 577ad95cfee1..095e6ccc166f 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -285,7 +285,7 @@ static void setup_ftrace_marker(void)
>  {
>  	struct stat st;
>  	const char *debugfs = find_debugfs();
> -	char files[strlen(debugfs) + 14];
> +	char files[strlen(debugfs) + strlen("/tracing/trace_marker")];
>  	int ret;
>  
>  	if (strlen(debugfs) == 0)
> -- 
> 2.20.1
> 

Same here, you were faster than Kurt, but he included the null byte, so I 
grabbed his
