Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A5C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 11:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF14323108
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 11:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404685AbhAZLCC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 06:02:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404672AbhAZLB4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 06:01:56 -0500
Date:   Tue, 26 Jan 2021 12:01:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611658864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGYfNPt0xvJoL3IHZ8teJqt73zDoR2I+6WYyRZwLXUc=;
        b=ga4GoRkzUP3eM/AeBxGwc2CdTAV6IrhpNmHZjcvUQaf32fLd6TUpuqvQ8q8+AkG6NEn/II
        0fxLsGRvKWxakkRukpKtObpUtSlotK+E46I0FONQaroX5C5YKIGqanw6XQPuz+Mr/ikP5o
        u1sdg96L/2mBSnu9PxB+zBDQkAXOJTOCr1/9bL35vhvdDwf+tubeeY6ekRG88OUSfPpqKf
        aEmZiGf/cJorn0GTAL5hnSckngLEVCzrCVlU+qw8gBBUQPtmGu0e09KBdtA5ehK0B7b9FA
        fQRBcInZ/7d0taehqQplbVbi48vubmtsXcdLVhX21s4pFuXhWARQa2h8kBi/Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611658864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGYfNPt0xvJoL3IHZ8teJqt73zDoR2I+6WYyRZwLXUc=;
        b=YujJtwhSR1Nsdr5957Xn0KqyRki5xSBg1S49e4kxPBQO3GCgQMUkiE0tiSy7F4iTIOkvDp
        W22xUi2Yh2fX4wDw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v4 00/12] Generate machine-readable output
Message-ID: <YA/2b3+WwqqWrBdo@lx-t490>
References: <20210126091946.1241-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126091946.1241-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 10:19:34AM +0100, Daniel Wagner wrote:
...
> {
>   "file_version": 1,
>   "version:": "cyclictest V 1.90",
>   "num_threads": 2,
>   "resolution_in_ns": 0,
>   "cmdline:": "./cyclictest --affinity=1-2 --duration=1s --output=dump.json -h 1000 -p 80",
>   "sysinfo": {
>     "sysname": "Linux",
>     "nodename": "beryllium",
>     "release": "5.9.14-1-default",
>     "version": "#1 SMP Sat Dec 12 06:57:32 UTC 2020 (c648a46)",
>     "machine": "x86_64"
>   },

Wouldn't it be also helpful to add `"realtime": "true"` if
/sys/kernel/realtime exists and equal to 1?

Thanks,

--
Ahmed S. Darwish
