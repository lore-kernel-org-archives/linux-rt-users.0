Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626FC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09F1221F1
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhfiOD1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgKKC3L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKC3L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 21:29:11 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DFC0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:29:11 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so452164qke.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3FwVG2n8vveruWdPoHbM07d7VzQMkHbujKlSE/9sIME=;
        b=KhfiOD1Yx2JdxVrZGLtrvIHRxDP7dwvaIq/QkZzajdN+hvQgkumgIQ9kZzyUDleMf9
         HYq2iKu+VaUVIpKwmjyzrhqrXBS7q9Doa1VNGmy2ku26dVVbGg4rhmka2HPGec37TqDy
         knlBWMTHVkf5tbPwJ36+/t1fRdz3i2qs2YNA3GwY28moH3WVVyne1iLCGNJRMwug/2ve
         YdAg5y1yS2aezvBnNiccyek6tOgHkW2LOaInrOeMZX1yINBmCzToQlNqXp2juK7ScV/7
         WiT3Fj0uozPwW3mOymfqjKyR0P3VOd0XuOsGrSSIzQkl7IBdhAxSdBofsNTRDcL7XO59
         JUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=3FwVG2n8vveruWdPoHbM07d7VzQMkHbujKlSE/9sIME=;
        b=bAklfMaYs+eYJ32cjAgjvs2HhueM4vTNdiQ8I3qjbnR/lmUsJ0W90lAVPRW5upMH4E
         IQaiyMXMPyHVZtRkd96e6druGTZOhNN38e4x7F+jZWlBo7HPzDBF+UPm61gXY9t6HniM
         QAYr85lKFfHqVbl1DRCK31pYS/8uxKnZMRwEhjS15gd70sYle9SUtmrpTrsls0pwddyu
         YjK+id7oWWKCkjzaAU75mgduczeEtIE+U/7V/JcJvIG67mpFklmFZAtFKjsMjUZl5579
         CvY7HDDsMTcqrYBTtrdJZR8sj489cbnysIZzOmJLFzrdHJtasNCITyfyqPqsA3foP3b1
         edfA==
X-Gm-Message-State: AOAM53130okvTmMwEWPKc603P0eY0M0jPG/JeNSUqQVpoqEVj2bmMU0k
        pjLQxoZ6jxJky2HnYpcXK8/twFogX0L4ag==
X-Google-Smtp-Source: ABdhPJz+4Vws3JWiOUUsFC2+eROBPW7GGFeyYYjtkNU8pGb9JrJlbm/aBW6T8KdRg6R+Sszt5mDvUw==
X-Received: by 2002:a05:620a:2296:: with SMTP id o22mr22427115qkh.143.1605061750272;
        Tue, 10 Nov 2020 18:29:10 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id 82sm780296qkg.103.2020.11.10.18.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 18:29:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 21:29:08 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/4] rt-tests: rt-utils: Mark internal functions static
In-Reply-To: <20201107095843.11909-2-kurt@linutronix.de>
Message-ID: <533c9ac6-185-f8c-d4ef-a7e4e1cf02b@redhat.com>
References: <20201107095843.11909-1-kurt@linutronix.de> <20201107095843.11909-2-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 7 Nov 2020, Kurt Kanzenbach wrote:

> There are some helper functions which shouldn't be exported. Mark them static.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/lib/rt-utils.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 54a201661786..85d41b9542a2 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -362,7 +362,7 @@ int parse_time_string(char *val)
>  	return t;
>  }
>  
> -void open_tracemark_fd(void)
> +static void open_tracemark_fd(void)
>  {
>  	char path[MAX_PATH];
>  
> @@ -390,7 +390,7 @@ void open_tracemark_fd(void)
>  	}
>  }
>  
> -int trace_file_exists(char *name)
> +static int trace_file_exists(char *name)
>  {
>  	struct stat sbuf;
>  	char *tracing_prefix = get_debugfileprefix();
> @@ -399,7 +399,7 @@ int trace_file_exists(char *name)
>  	return stat(path, &sbuf) ? 0 : 1;
>  }
>  
> -void debugfs_prepare(void)
> +static void debugfs_prepare(void)
>  {
>  	if (mount_debugfs(NULL))
>  		fatal("could not mount debugfs");
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
