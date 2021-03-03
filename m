Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC25C43332
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A3664ECF
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhCCGY0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352912AbhCCE13 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Mar 2021 23:27:29 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD28C0617A7
        for <linux-rt-users@vger.kernel.org>; Tue,  2 Mar 2021 20:24:13 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 15so11062173qvp.13
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Mar 2021 20:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xhju/GEw4VR5jlK8zB7jEStjrFOCf2Um6VEDtWc+Sd4=;
        b=Ea1/ei3AzhfwMjhCOgQjqJTGCLjcKILRbl/Uu9mkCSNE05ThSBO2FBm5uzxFb28E4d
         vujVdCal42y70AiWw41kE/oMZDjCAmX3rgAIJaOTbuZXVHA5bnLKgBwxrDxVObxFeaC1
         UONerEmDplBAayEDFnpHgO4CApMwH32i+0W+ujkpJKPEeoXeSSXAwFvd+P6lRsh71R1M
         k3EuLURvnuuqhVIhNEJEh1Rb4srp92vJ7+CvjGRHYFOY/2XmSqWv43x/T3JEm1fk4OBf
         dnJ7aY+tlAybowB7HklFDicdn4uM5Nd1t/7N6bqm2mkmCZa7zrCIIhKi8WkDqJx0PkFW
         Ek8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=xhju/GEw4VR5jlK8zB7jEStjrFOCf2Um6VEDtWc+Sd4=;
        b=N2uXQEFCDIDNqWq2jdL8MysV9ib8J7vG4QDRrpQx6uRr6VtKEroE4NKr+gDN/cvTW7
         CPK4b29lpX7pJxdZJ7bbuRoBIlvZHldRgH+hyLTgAWazT1Y98WmO8I/zpaLR88+2RZOo
         rrm97h++hnFZb37BCD3GFQ7gizbvgK92784fU/HQxOuHpQs27kJN0BZmUXFTXwcfeAnB
         51CtzVsBOFg9kLEVvGP8PL05ENXluLkC3nAiFksqGkL99HvZPpwXWyn3oJuCypZSfeC8
         2Pra87YvLH7zhO8P8E9GMdi98mOqX9UTfv5/iLTsst4M0LejYH2Ip69EAOYWr0GKm96I
         OdRw==
X-Gm-Message-State: AOAM530wgDZj9ECMKX8W99BmzNtsZ7YXzJCSn7YMfD2XRflaJBnSc6oL
        o3cDBdvd9SExSpWLXlT/5XM=
X-Google-Smtp-Source: ABdhPJyEzqGrFsoXzDwpO8AACaPJkMwXi/mn+thpjzWno6knAe1Num02qqjwEx0/ajv8SnbAkkPLUg==
X-Received: by 2002:a0c:bf12:: with SMTP id m18mr1080719qvi.40.1614745453084;
        Tue, 02 Mar 2021 20:24:13 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id a19sm5432957qkl.126.2021.03.02.20.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 20:24:12 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 2 Mar 2021 23:24:11 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
cc:     dwagner@suse.de, "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: Re: [rteval PATCH v2 2/3] rteval: cyclictest.py: Make build targets
 architecture independent
In-Reply-To: <20210224021603.446274-3-punit1.agrawal@toshiba.co.jp>
Message-ID: <43eaa8bb-26a-112c-8c13-38fe882dbbb@redhat.com>
References: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp> <20210224021603.446274-3-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 24 Feb 2021, Punit Agrawal wrote:

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
> 2.30.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
