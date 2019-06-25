Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA0C48BD5
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35D21655
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 09:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clhpqEa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfFYJ3j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:29:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42338 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfFYJ3j (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 05:29:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so16992807wrl.9
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jun 2019 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HMbMocXStJVTeSo5P5Tkg4DfUCXwXTaysjNmuXLJE6w=;
        b=clhpqEa5mCZ0W4Ijfl/dojfnP0ngaobPwPgheSd9LUlVK6/TYYVTFSmw3wScTgBrsq
         KCjEudgfAZmg7+GsC7eavPhl+aqwlrTkHyJyaVgCUiuRCz8qwqQ3A4l6iP7luC6OPDaa
         2ukXOHGiyc9WLM0JsCj7Bcn0eNVxf+O3Mz76L8eGKccSVuUnUiq6nsb3A5pQf13zxc8J
         PfJjW0Y0U6PcPGQ8akDWyUT7k8ctd2oLDKGMV341lipFO5FnyEnRQ9rPFK80wrpGdzUX
         FYKW3LKJUAlah9Z2MpntwKI8u6y19Sixse+oxlg913+KkTs1GMYy+JS3K4xvU09aOBY/
         h1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=HMbMocXStJVTeSo5P5Tkg4DfUCXwXTaysjNmuXLJE6w=;
        b=tPuzRjoeB3iMcrn2gjg6fA2+aBB4jHyK+dI8dIwaypNfcwsThBPLhux9ToWTcHT6QM
         ar5yw+hsnpiTe9gLwHNFaFusTS4NFXGdCCSSQ0gptixCPuFdFqAO1tpg7LXOCkQULFEq
         RpJ3qoNJyab7EHHPmCaIpY4yMF/gPU+1xsFvFvhx4Sxdk9GalibQVavpnsUGfy9FqOZg
         udhhRq0mLyKKuu2eF0v8Eq8bXEAvHrhmPkVU51NZTizc9idjyoCGneAQmu2W5p5w4aTv
         8eQvOwdkbqsmrKcj3aPiamSatgV2wN3gjw0xuPp5ZQ0O1MT/OFBDVP1qJ+1s+m8MoF5Y
         UfPQ==
X-Gm-Message-State: APjAAAUgfgSpUoWv/mrbfqhDCkzDs5UmeOSqLx7kOeKnGNvjksFTc5JZ
        qAbyLn+JUN2w+okbm31HCiY=
X-Google-Smtp-Source: APXvYqwIHFPcZi3Wn51cjkzQp6COQPfjoUvAYFpPF/613nxbhpMBNzFexrZk6owa/q2xYkwr6u3OCA==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr62850098wrw.8.1561454976817;
        Tue, 25 Jun 2019 02:29:36 -0700 (PDT)
Received: from planxty ([2a02:8108:1740:237c:5dea:4cb8:6516:9736])
        by smtp.gmail.com with ESMTPSA id h6sm11151645wre.82.2019.06.25.02.29.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:29:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:29:28 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty.home
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/6] rt-tests: deadline: Remove duplicated gettid()
 code
In-Reply-To: <20190624134045.6rrfa4wq6in6zgxl@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906251117160.4274@planxty.home>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-4-kurt@linutronix.de> <alpine.LFD.2.21.1906191747000.12022@planxty> <20190624134045.6rrfa4wq6in6zgxl@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 24 Jun 2019, Sebastian Andrzej Siewior wrote:

> On 2019-06-19 17:48:09 [+0200], John Kacur wrote:
> > 
> > If anyone objects because they are actively using systems that don't have 
> > gettid() in the library, please speak-up, for now this is in 
> > unstable/devel/latest-devel
> 
> ehm. gettid() is defined in
> 	src/lib/rt-utils.c
> 
> so how should someone not have that one on his system?

The sentence does say, systems that don't have gettid() in the LIBRARY.

That being said, Kurt, would like to come up with a smarter patch that 
uses the glibc version if detected else falls back on this one?

Then you need to clean it up everywhere, not just for the deadline tests.

Consider this patch NAKed for now. (it's only in the latest-devel not the 
latest version anyway)


> 
> glibc 2.30 will have gettid() [0] so maybe you could avoid using that
> one from rt-utils.c once you detect it in glibc.
> 
> [0] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92;hp=f289e656ec8221756519a601042bc9fbe1b310fb
> 
> >  Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Sebastian
> 
