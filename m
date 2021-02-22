Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F972C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8864E2E
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 20:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBVUTk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhBVUTj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 15:19:39 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F16C06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 12:18:58 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q85so13960291qke.8
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=U/uRRgY8wixp/pbfr475IA6zl8rcp1evnkAdv8P4ncA=;
        b=r2bhs7oK/kw+qJK1bIXauxgMVxUdXVDvTN96DxYGGgiVsGZYSaRtmGCKFnpcBnpy+z
         FJ0Z2DyUTQGHTDSl8DyBtATa9iPGeEqnRzuhXS2J2HhAwtSR92SClPAG26PpTzOEVIf3
         8Too5BsoOvHxbJDTvU+Rf9+tBvK8m/LBY9g/wtDLAl2hKczCiaNoMUnyKc17/7cgLgHN
         4Qmp4G/sLck5azQIdFgiPPR9U6TOXiDyEILKV6JDR46BmhzVWWwF0YhfgVvBAWrNUdWI
         4w9iWcvt/KP1XNHaYoCQUsgGz5dfQj56WdsBvgyCG1xDq0awujEr2CcpijNV+k2ShRQi
         0xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=U/uRRgY8wixp/pbfr475IA6zl8rcp1evnkAdv8P4ncA=;
        b=Q2ZVaR9wvAibZMxgO2Tv48CcxzRO3CHPe0W7dRkWyXUyDn+13640Vx/oed000kCp73
         Q+msIYv6kxEeVPWEe9RGulv+bdb1eo4RxMITUCpnLcEKKO4vnKxg6l/59BcNaYyhdAdn
         zhzuor6kscmc3Z4Ez4TO/GNJI4R8pPkhNHwz0L5LvpkdLUCAK/U1EW0p+ReIo16Aq+Ue
         UvHmZQlsu6jpaehal3G45bvNFfAoEN253XN+T/iNm/5BIhTP/DZyzz9hyQY2R8npxYkZ
         83k5Inxtk6e5x8dMJjr4+ysNwkfezDbELlTdcp+N4F4L3frtpSvJdljqLgIigOJz/Sm3
         BOcw==
X-Gm-Message-State: AOAM531J5S8aoGSJ5bsUZaRyQKQPK3/qXQTsEdE+wgr0spT3g4yYS4+M
        ZduQghcIUSfMm1Gqa0qrzeETfMGRC9QZEQ==
X-Google-Smtp-Source: ABdhPJw6a03r6t2vZHyy561AuiNa2HbQy/yodLFrBh+yajGLkxUMQb6qMBK6/OT4Jj5EMw5M5EjyXA==
X-Received: by 2002:a37:9a41:: with SMTP id c62mr23968659qke.19.1614025138143;
        Mon, 22 Feb 2021 12:18:58 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id n7sm4068107qtr.91.2021.02.22.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:18:57 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 22 Feb 2021 15:18:56 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH 2/2] rteval: cyclictest.py: Make build targets
 architecture independent
In-Reply-To: <20210126021241.112944-3-punit1.agrawal@toshiba.co.jp>
Message-ID: <42e6355c-a8c-8529-43d5-d3cb1fc1bfbd@redhat.com>
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp> <20210126021241.112944-3-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jan 2021, Punit Agrawal wrote:

> Not all kernel archiectures provide the "bzImage" target, e.g., arm64
> provides "Image" which generates an uncompressed kernel binary.
> 
> Instead of going down the path of customizing build targets
> per-architecture, let's drop them altogether. The default kernel
> target should build the kernel and modules on all architectures
> anyways.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/loads/kcompile.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index 326f1ae..e747b9f 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -58,7 +58,7 @@ class KBuildJob:
>          else:
>              self.jobs = self.calc_jobs_per_cpu() * len(self.node)
>          self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
> -        self.runcmd = "%s make O=%s -C %s -j%d bzImage modules" \
> +        self.runcmd = "%s make O=%s -C %s -j%d" \
>                  % (self.binder, self.objdir, self.kdir, self.jobs)
>          self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
>                  % (self.binder, self.objdir, self.kdir)
> -- 
> 2.29.2
> 
> 

Haven't forgotten this, just need to test before I accept it, on my list 
to do.

John
