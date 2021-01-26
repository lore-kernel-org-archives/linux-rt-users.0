Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E15CC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50F422228
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbhAZRVE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405883AbhAZQeG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 11:34:06 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D69C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:33:26 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so16494353qkh.3
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rhq6pEUnN5T9to84ykHy1lP80I30Um5z+gO9/357Kz4=;
        b=mNmwo6OBHVfdmgMpN+mcxJaBbhBJj15WHmOp1iRfKoKusMi9BzxAkoJqBVhORLRRLg
         UNYSHZ1JqF5GsgqPUF5cuZ1dCyjCPaV0RBZWRGpRcFU1Kd4AIFDiA9eHJmEwzr3Gc3tv
         jBOtxqaGaxFhIFlBAJiOtbBq6r12Z10EuJK3uqPA2eJYAp2vI4oiWQzA98qoi1141Mup
         HMvpuZZDUSQTzq6W/Hew9n2D0LARLxWCsTsf6yrKaIMgyOvq/c1WkIzR+yfiLzxtC1wb
         NntngdezAl5TJR9U+Mr3e6zyBHvokF5WuZ2u0ex6AZ1gLDRVYW2AeDNEJ4zB7511I6nZ
         UHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=rhq6pEUnN5T9to84ykHy1lP80I30Um5z+gO9/357Kz4=;
        b=KZi7WurRr1KOyvtanN28TjeFNybBWXPRozTeIbg/SD2rfXSRhldQ/SlPE5Y9XsQcKm
         1B48y8O3qERlm+zY5uF0cEtzcpVkZxv6e08ZAw1TPGtRMZEyee71VSVzkda1gGODfkPr
         Ue33ZO+TCyb+T0yQ4AYRjBW0rJpqH+usyjclCA81DMhmir3iQVTovrXySrtScfw7PAcp
         U2kxqT1CLp+yOJDMkNuGRv1vwaTLBCX5oL0ETdz2mdtdACUi/+HdBS3YlxQIfIDV+RFc
         mZ+2XBYjjzVG8OWAht4d7k2WrGyCQYP3bn9OaJMMu4zvyCepEooa4tmfeD7rItC7nFdT
         7OBA==
X-Gm-Message-State: AOAM531Ol0QkpAgxy1gDQBwFdYC5XrczzRKW/e8Uc9n3Hz3hLSA4bH+l
        dsxdLtLLHO8ZMVfxSUazaPY=
X-Google-Smtp-Source: ABdhPJxf3DEqYHHlq8Oya1jbaNkCsCUsk9q/SNxb6+JaW60t17Yr+tPTSblMwCFNBtGGEUy+5cw1LQ==
X-Received: by 2002:a37:4854:: with SMTP id v81mr6529405qka.20.1611678805667;
        Tue, 26 Jan 2021 08:33:25 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id y56sm14023630qty.94.2021.01.26.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:33:25 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 11:33:24 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 3/6] cyclictest: Use affinity_mask for stearing
 thread placement
In-Reply-To: <20210126084145.qrtcg6dsvbya3odd@beryllium.lan>
Message-ID: <9c62a2fb-59a3-d7d-6c42-30eccdab8779@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <20201218141935.24151-4-dwagner@suse.de> <2b7c33f3-6249-5ef4-94a3-957cb8cbb3bd@redhat.com> <20210126084145.qrtcg6dsvbya3odd@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jan 2021, Daniel Wagner wrote:

> On Tue, Jan 26, 2021 at 12:39:02AM -0500, John Kacur wrote:
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Is there any reason why you picked this version of the patch? It was
> also part of v2?
> 

I reviewed the correct version of your patch, which I pulled from git,
but when I went to reply to it, I replied to the wrong email, sorry for
the confusion.

John
