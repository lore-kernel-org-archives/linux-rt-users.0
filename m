Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09913C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 21:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C4D64E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 21:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSVbW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 16:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBSVbV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 16:31:21 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634DC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 13:30:41 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z190so6983085qka.9
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=u4JPlpX355ivZu1RdOmOUTDdRWNr5AxhQm0ch6manSc=;
        b=GHXO1qfe5gz9VZeG1Z3HYA8N2PmEMDA02C0txif/hRRZ6xV5dVtrpt9/WfPRoPWvse
         Cz7bVp/wKqRzm755f5lLJHDhKN7PZJdX8KdsRg7pUCpTspMNBXTXZIES/dzaB15Yug1Q
         wENdQKDLal3qAIoRDl7PjEKKOnqrZI+oUg98XeJmZ68qTBj7jPkqlZNgzMt4iIAz1RRq
         6hXgs154pOD2cdq2HfnWppiDv1+j/+hT/amRyvOs5W17z42iBQhT3uLx/8baOR18A7Y5
         zjjJbVE3C5QlcVI7y4c+4Lg8vt9Y/TSxCX+c5lyuQ7I7qTDYEjvSswp42yyz+GpOk4/W
         VB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=u4JPlpX355ivZu1RdOmOUTDdRWNr5AxhQm0ch6manSc=;
        b=nCFYRQu7jYdn2BhfYR2XlFi+CbY+uNSvoerVkNpRTR01fxslwHmuDih1obc2yno79z
         phaqDEY4xNz1PIzzmvqcM0ufRVtpWs+lSngiolaHz+ijAC8goRmSJUmeSVf009Lacru8
         PbJDvE12ZC05CBdwkj1osDAeTpStZk7o8JTEQKtrbmRxJfGLxAZAo8jlWuijY752SsIy
         DeHcMSH/ToCfKyg/bUf9AxPfnFpma50pLDoFWoUX2QtkgyTHrziPhS0J9KZSJEpsPrpx
         6E6Ye3pwWnA9IeiuvfMBsFMKZmuf0MwewRYZWk1p8+vbIMAqQomnJr7OypmmMCcVWNpz
         qzgA==
X-Gm-Message-State: AOAM532KTFgIMoyLZuJnhMFM3uXx/EYXyNf+1CzHJqDrI1AeP92lthqZ
        Z17O8DrHe8uE7w03mpvaM/k=
X-Google-Smtp-Source: ABdhPJzs9NKa+jj4lpEWmUTcS/GgP425gDtAcgyWsTLIzKrQ3SF6ahUgdiQ6gPDHNpMsZklr3ai3sw==
X-Received: by 2002:a37:7845:: with SMTP id t66mr11413405qkc.81.1613770240477;
        Fri, 19 Feb 2021 13:30:40 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id h9sm7044818qke.121.2021.02.19.13.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:30:40 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 16:30:39 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Christian Eggers <ceggers@arri.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/3] Revert always use libnuma patches
In-Reply-To: <2188166.ElGaqSPkdT@n95hx1g2>
Message-ID: <59d08654-a23c-a880-b78a-43c64b1fd16d@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com> <2188166.ElGaqSPkdT@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Christian Eggers wrote:

> On Friday, 19 February 2021, 19:47:58 CET, John Kacur wrote:
> > libnuma is a build requirement but not a runtime requirement.
> > 
> > Test branch unstable/devel/no-numa-runtime
> > 
> > I would appreciate some testing before I push commits upstream
> > 
> Now it is the same situation as in v1.10: 
> With the --smp option set, cyclictest runs on arm32. Otherwise I still get the 
> "FATAL: Couldn't initialize libnuma" (newline missing!)
> 
> regards
> Christian
> 
> 
> 

I think I see the problem, the patch
rt-numa: Move thread placement code to rt-numa library

added the fatal if numa_failed.

Thanks for testing. I'll send a patch to put it back the old way.

John
