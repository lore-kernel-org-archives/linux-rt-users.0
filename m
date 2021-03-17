Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F2C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6235C64F6C
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 16:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhCQQlJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:41:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhCQQk7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 12:40:59 -0400
Date:   Wed, 17 Mar 2021 17:40:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615999258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVTUBIvGRwO8YFMq9Gc9FdbjEr7iyHSzXdrFii4o8T8=;
        b=qnZzRgMG9Qkcy/XbB2FPPCI+pH7jyTf9l4rnPRqVfxjy77Mzkb20jsvdTq8Kud07wJZgha
        XwieVx5hhjN2UEsSL+xaOYW7p9xmqE40C6gaAgXFcHdxjSbZj54ybex0eh4s036DPM9fek
        3oSKhijpdVRl675Kn8mdLIh22Jw3H/MBr+CvW6ymXGb8yeGPwrS1iUb9PbMRyp5FMBN0Xd
        QPbkIUUg40I+kMEQMBvUiu2Uj8ptnc1Mto1X4d0At3BaXjO5DTv8K7yz+cBzd0is9gKpFU
        NTJqvMoYy9wJExclD7XYa61WXWXudTKtaYsL3T2xG5P2xUrpTe0BO4lqb4WR+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615999258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVTUBIvGRwO8YFMq9Gc9FdbjEr7iyHSzXdrFii4o8T8=;
        b=bluD9Wpeuit8I/M/xgnIXkbk+gqByglknBU7uoPB4M3F2YJ9XAX0x8ZVAUXUKbw6CVShd/
        qJgrprrPs0CQgHAw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Daniel Wagner <wagi@monom.org>,
        linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <YFIxGCKCrhgaorGG@lx-t490>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
 <20210317074903.5lskayjwylnvuhks@beryllium.lan>
 <20210317125147.GH395976@xz-x1>
 <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 17, 2021 at 11:08:31AM -0400, John Kacur wrote:
>
> I also am not a cgroup / container person, and would like to play around
> with this a bit more before we make some decisions on which direction to
> go in.
>

Pardon my ignorance, but (scheduling wise) what does an RT task inside a
container/cgroup mean?

AFAIK, the RT task will still command the CPU as it pleases, no matter
the cgroup's cpu.shares configuration.

Thanks,

--
Ahmed S. Darwish
