Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F5C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE38239D4
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAVXcl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbhAVXc0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 18:32:26 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF6C0613D6
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:31:43 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k193so6902150qke.6
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Jan 2021 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=TTbjTNhEWfew04d8Tdmb61dkMfPzSb02b5YV2nSQgLY=;
        b=oKuTkSwT901rABp5uyp7djMsZVMp+s/WC4CTP5IYGecr0+CaJ5gtKClLR3Jju4b2G1
         RK7FYokLYgncBqzoKBxOcDPtmH0hiojGxxgIsqcVliZyIiMjyzfOK4adLiRb6IOt/5lA
         aHYXUZsi/x9mHJi1TCYxs5jaGIP/chd+O9slqLI1XOhu4TWusDBcnmwSlVoD2N/iSGj3
         1OJwXX8Nj4DcQxXNGm0gyLhRNsBPN651a/mvU4We1Gbkbpl53J11x1B00BrXjyGLvqN4
         Mi7U4McxOPW5Ine+IjY5Pb+wpS37CP6vUSLUOxe7y2eLB4yTRafoUAirCXeHe1s0T4Qu
         Mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=TTbjTNhEWfew04d8Tdmb61dkMfPzSb02b5YV2nSQgLY=;
        b=aDIfR7ev5Rtl4qVZ6qpEKG6Vb9c/d3nt1ZdlTb3lqA627WQUnmOtcMOsGxcG1SA2SQ
         DR4gNZ5Zj7jqi/JXQtpTPICpc1XGSV5S/dQg7tVsEA070TbiLfm0KndMDp7CjE3pERqm
         JKZWiz3q13nID9j18DaMZDrfIgkggT3XT94A18DF8cxYvMkqmyDGQk4BDzecCdrx+x7M
         N8E3r/Yda+lJfX38vHAiS+UMY6zFTAup4tUpYX+hy2tSCg1rEojCOl80QYsfUPRt2HuF
         sW9+AUHF8/0pGzKdVfy3kcsyh2oIf128rsjAVdmO9V43JzgOqDeH8tIg1bmuFnhaXhzt
         p8zQ==
X-Gm-Message-State: AOAM532nmvETPobQhRF2tVQs+dqDsql0D0D6eV9lefb7YS38DmDRphwx
        LhA+R6uAFNQyAQqbuX1O3LE=
X-Google-Smtp-Source: ABdhPJwMVAm4IgbQVfMBY0aHyxlQh9rXjy9dvBzsdmT5OHBc1Fe6A8i3I3oF4wF3Tb8CWetcO09Z4A==
X-Received: by 2002:a37:a053:: with SMTP id j80mr7375987qke.198.1611358302369;
        Fri, 22 Jan 2021 15:31:42 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id b78sm7348963qkg.29.2021.01.22.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 15:31:41 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 22 Jan 2021 18:31:40 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Re: Some issues running rteval on arm64, arm and i386
In-Reply-To: <YApwIRJdMCXcMVbU@lx-t490>
Message-ID: <8b5fcd1f-e78e-744d-836e-d1e4b2d5794@redhat.com>
References: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp> <YApwIRJdMCXcMVbU@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 22 Jan 2021, Ahmed S. Darwish wrote:

> On Mon, Jan 18, 2021 at 06:00:46PM +0900, Punit Agrawal wrote:
> >
> > We ran into a few issues when trying to run rteval on arm64, arm and
> > i386.
> >
> > A few of the assumptions in rteval don't hold true on these systems.
> >
> 
> For some embedded devices, it can be tough to use rteval with it. In
> general, it requires, *on the target*:
> 
>   1. a full development toolchain (GCC, make, flex, bison, etc.)
>   2. a full kernel source tree
>   3. a full Python environment
> 
> You can use a combination of stress-ng and cyclictest to properly
> evaluate your preempt_rt system latencies. Just make sure to exclude the
> stress-ng stressors which allocate real-time threads, which can (and do)
> conflict with the cyclictest ones.
> 
> Kind regards,
> 
> --
> Ahmed S. Darwish
> 

I agree, rteval wasn't designed for the embedded world. The reason for the
full development tool chain is to compile the kernel as a load, so if you 
are compiling the kernel on a machine other than the device it is 
targetted for, then rteval won't work. Also, yes it runs with a python3
envirnoment, we still maintain a version for python2, but no new 
development is occuring there.

note that rteval can now run stress-ng too, but the default is without it.

John
