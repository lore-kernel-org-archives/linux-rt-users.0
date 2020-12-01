Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D2C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 06:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA5020757
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 06:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxaciEcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgLAGbD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 01:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAGbD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 01:31:03 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52983C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 22:30:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q137so506610iod.9
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 22:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9pShFYFvombzDS/4Btvc5tAB26TkPKoSotgD1L+VJd0=;
        b=OxaciEcRJl40oq6OW6kk0OikeUffcJbjicHc0pBq9jql8TQ2nfB1qNCmQ0EB/QvX9C
         w5c0iTxoCCz+aUlbfb69/5t3UTQEDBeY5Na64DrCN5V0n/+9DaDed1QTO8zEtdxBwaTL
         kT8sFCi8VQggjg8BcvVs3tJ1JRk2ApB4qS/khgIaiKWnSwDa6LEyEavziGnc39XJ2Rjq
         GFH9sWKuEEWUAgjvY5UJunUBXSL6hvcYelcxJKN2foNTQMkx6FYFN/vwEMIDEOF2aL41
         /mvaLB/oX0xsllo1MlJIsId0vhcc9H7j2D6evnyut6AGkvgyNYTZT11GyhXg0wqcsr4V
         +70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=9pShFYFvombzDS/4Btvc5tAB26TkPKoSotgD1L+VJd0=;
        b=ZSGMLrpKirvjV9NpvQORErpCFO9zHmEe6E11r9yNMH+PL3uCxOAhyRvnv0vu3NjaDu
         9loio5XcUkit/4IBpYKzohjtuPVkis6OPmdhj0eYl0Z97vWNhPeot/9RkFmhe+ot9np5
         GAGpBu/cRSj8vbUm6uDloQwpbBBbqwp9nVmgAVJVdAq2LSPh5TGK+OUFYfUIiB1QnkIu
         566NcM/d1YJxQehop58Mg0VgVaKZ80Yds4S6DJUoyf/GDEYZp54tLr0YnaVqyepedxCf
         98DFIzKqMHvsIX/jIimWWqgzm0x6Cq04HglXvBMhiMinGMvi5BAYevmlKY0/WO8U/mWJ
         oiKw==
X-Gm-Message-State: AOAM533luG8Xfjd7Dv6JZGX5dJNrK7kJmzdeeL4W1gByqaiLNZu1Ns79
        pyRKUNWyuU4eoArdUVRMNt2uynGBMg5zhw==
X-Google-Smtp-Source: ABdhPJyABme7RRzeX1CZp4lWbRKYH5fxMyNQvPY9ONoh0661NfKW9cOKSZIrdAbmi/DQe6/SqZRw4w==
X-Received: by 2002:a05:6602:1305:: with SMTP id h5mr1271911iov.202.1606804222766;
        Mon, 30 Nov 2020 22:30:22 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id d7sm280172iod.45.2020.11.30.22.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 22:30:21 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 01:30:04 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 01/12] cyclicdeadline: Remove dead code
In-Reply-To: <20201118190642.16006-2-dwagner@suse.de>
Message-ID: <9d9db38c-925b-b5e2-b273-2572f7bb7f3@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 18 Nov 2020, Daniel Wagner wrote:

> my_sprintf() is not used, remove it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  compare.py                          | 12 ++++++++++++
>  src/sched_deadline/cyclicdeadline.c | 13 -------------
>  2 files changed, 12 insertions(+), 13 deletions(-)
>  create mode 100644 compare.py
> 
> diff --git a/compare.py b/compare.py
> new file mode 100644
> index 000000000000..7fb6ae818a00
> --- /dev/null
> +++ b/compare.py
> @@ -0,0 +1,12 @@
> +with open('old', 'r') as old:
> +    with open('new', 'r') as new:
> +        for ol in old.readlines():
> +            new.seek(0)
> +            for nl in new.readlines():
> +                o = ol.split()
> +                n = nl.split()
> +
> +                if o[8] == n[8]:
> +                    d = int(n[4]) - int(o[4])
> +                    p = d/int(o[4]) * 100
> +                    print('{:20} {:>8} {:>8} {:>6} {:>2.2}%'.format(o[8], o[4], n[4], d, p))
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index a6309ded3c52..e0db9669f676 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -215,19 +215,6 @@ static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
>  	return s - buf;
>  }
>  
> -#if 0
> -static int my_sprintf(char *buf, int size, const char *fmt, ...)
> -{
> -	va_list ap;
> -	int n;
> -
> -	va_start(ap, fmt);
> -	n = vsnprintf(buf, size, fmt, ap);
> -	va_end(ap);
> -	return n;
> -}
> -#endif
> -
>  static void ftrace_write(char *buf, const char *fmt, ...)
>  {
>  	va_list ap;
> -- 
> 2.29.2
> 
> 

Well, your git version is okay, but the version you posted here has 
compare.py, which I assume is somekind of internal tooling you created.

My SOB refers to your git version
Signed-off-by: John Kacur <jkacur@redhat.com>
