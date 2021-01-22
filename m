Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35947C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 06:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10CC208C7
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 06:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAVG3F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 01:29:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbhAVG11 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:27 -0500
Date:   Fri, 22 Jan 2021 07:26:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611296802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nuKb3Xq/vrmzwHDMRf1G46C3c3u4CpXthify8simzg=;
        b=boZnD4MCDx85mN9+Q1mnQceyLXK8UBKrME3EdqH1bOMb+TsXscGn3JNVjX+t3hyAgVkh59
        vHfyOEQRnUfQBf29Kdj+vsnNhtkcXPNK4BcNo8ZnnyXqJY2g0RmeSSfXkT7X1SoEsqnjuO
        j8hP6lhfvTvyUwh8EArf/mFxYeXS5hoTqXulAMguiYsLt/ERhSpytPfpsnTjU6fTr9u5pU
        vmb90QC+HxrMnHh5GYUsj3A96yCqCs7zOtzhulMMGmKx06DJ+cIr9WvaGWVcSG7GcQ64JX
        /D5ka3dJY68yjdWWD08dhSGweXU/V0rUX9h1Mi/hQiSn+Q+Um5/y6xRqCNdVUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611296802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nuKb3Xq/vrmzwHDMRf1G46C3c3u4CpXthify8simzg=;
        b=rd+hkGCHxDzAn2f5ZB+plEONYhS1m1xS3SntQorg90F8+FLSvNlfr5ThQ/B1RqSpG4sNnL
        Tsr4D0amUlXXm2AQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     jkacur@redhat.com, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Re: Some issues running rteval on arm64, arm and i386
Message-ID: <YApwIRJdMCXcMVbU@lx-t490>
References: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jan 18, 2021 at 06:00:46PM +0900, Punit Agrawal wrote:
>
> We ran into a few issues when trying to run rteval on arm64, arm and
> i386.
>
> A few of the assumptions in rteval don't hold true on these systems.
>

For some embedded devices, it can be tough to use rteval with it. In
general, it requires, *on the target*:

  1. a full development toolchain (GCC, make, flex, bison, etc.)
  2. a full kernel source tree
  3. a full Python environment

You can use a combination of stress-ng and cyclictest to properly
evaluate your preempt_rt system latencies. Just make sure to exclude the
stress-ng stressors which allocate real-time threads, which can (and do)
conflict with the cyclictest ones.

Kind regards,

--
Ahmed S. Darwish
