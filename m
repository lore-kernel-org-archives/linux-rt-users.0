Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BDC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB86861248
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 01:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJEBl4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEBlz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 21:41:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCCFC061745
        for <linux-rt-users@vger.kernel.org>; Mon,  4 Oct 2021 18:40:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r201so12365469pgr.4
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Oct 2021 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wWW8D8eulD1OtNva8WV1Ud5OIoivthI0zQyOsM5FTD0=;
        b=nauJDxAmLDwP65fcbNBGQ+ist+sloEop9TF/ZI3ALxWErDcG2gu/kK1Q/lIg7fpEq9
         fpoQ78FLR65zuhKitet1LbFNqSy3vBDtO1zDYGvZ9Xs7RfnEfCbxwy1ayp1M3GYj41DM
         izutbusgBllQFp5WFrsAo20pk0cyUzQ3AEGGVFn7TVSGzoZkjHwbXACA+JS4tNmNAeoW
         kNyG3aapBJjwj3JrLu8vPc3XLTShWQk1zqoOTbaQJC4Ek8orKFlM/eAmxJR/IHe4VFTW
         cjRTMjHP0QZTuzpA+h2obLBn5Pmimq001T+hkLPb1qJsy95bS0JUKK+3t8wslYrnzYDz
         HioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wWW8D8eulD1OtNva8WV1Ud5OIoivthI0zQyOsM5FTD0=;
        b=VnVPV2ncDXcUvmd1RSPTeROFxRmIosYlTGksmIMm7lOvf9hwu3RlCGrjbtpJR32ewI
         yiCsIas4BW/CmvHx3YRGmNhgRDC/uK2XtKyHvfkJRaak6fvyHS1R2lbaPcCp2jpfmKm6
         mUyh519hHyko+HD/rj8KYxyQhCXpf0ftuMTNh1JmSi2KuSlpzCY/zS3Pf2iWStpRgNYg
         mrw4HPT4PNkozLBpDmJQ0NEklaqw8CpUrMsixR+RG5Bm+evWy5eVXsG37Q/3Mr9Yjb2Y
         leijSnfr+14EWcPgwBcbDEBJp7Yt/CfsTMMtAjBmfdEcsY2jJwYPc5F0Lezz8/QI0SBJ
         +UXA==
X-Gm-Message-State: AOAM530o2k9woEw7WgfyxbNPu2kd/8RfVtQY+ilWRqGTz5L3WxmYWRVf
        wojtZGrbsiv3dmseZg35AOM=
X-Google-Smtp-Source: ABdhPJxZGM8eyGul+rNv3gBoUHLn0Hg7ttUstVqsSdZStn2C/xdZqujdiPRMCQo3VmiR9D5/gnBG4g==
X-Received: by 2002:aa7:96e3:0:b0:44c:83be:19bc with SMTP id i3-20020aa796e3000000b0044c83be19bcmr9850pfq.37.1633398005596;
        Mon, 04 Oct 2021 18:40:05 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id r130sm7912301pfc.89.2021.10.04.18.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 18:40:05 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: cyclictest: Remove unused 'C' and 'E' options
References: <20211004124422.5006-1-jkacur@redhat.com>
Date:   Tue, 05 Oct 2021 10:40:02 +0900
In-Reply-To: <20211004124422.5006-1-jkacur@redhat.com> (John Kacur's message
        of "Mon, 4 Oct 2021 08:44:22 -0400")
Message-ID: <878rz82qrx.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> Removing the unused short options 'C' and 'E'.
>
> Suggested-by: Punit Agrawal <punitagrawal@gmail.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index cbdc6c11ffe3..2187d98de725 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1071,7 +1071,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case 'c':
>  		case OPT_CLOCK:
>  			clocksel = atoi(optarg); break;
> -		case 'C':
>  		case OPT_DEFAULT_SYSTEM:
>  			power_management = 1; break;
>  		case 'd':
> @@ -1080,7 +1079,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		case 'D':
>  		case OPT_DURATION:
>  			duration = parse_time_string(optarg); break;
> -		case 'E':
>  		case 'F':
>  		case OPT_FIFO:
>  			use_fifo = 1;

LGTM.

Thanks for fixing this up.
