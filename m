Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F6C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFFC224D3
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgLVSE6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Dec 2020 13:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgLVSE5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Dec 2020 13:04:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB1C0613D3
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2020 10:04:17 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v126so8144965qkd.11
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2020 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=niIOOJZwi6Rd9rd5VQccd8tyaLI6hOLSM5mEtLx1BTg=;
        b=JY8Yv8oQQCj7OWusrRmCimwWG2jcLaY5R8Jc56fXiYuNSQphuNjSVMXAPD9A4+iJHx
         we+s3yZT7GxH3uZ9lNDmJxF/YAQdaXpufgllcpyqd/9RBE7Tw6ez8GsMg6bGaTviTSgx
         5QIkU/i6bRvbQfkLr2rIfbZTSyKoSNJuIo6ScOmPRmq0PcqTZ9U5NROsLxR7Q7apRpku
         ajWUvxoWK80OoILZK1tzPftph6v0001C93n8Z12549ditoGNGkVevO7pbgTTSK17o8s9
         XluVUFDs8T5qfXoaE67QcpnkWr0uDb7Z69lpDyTSwH9p6C8j2bAsPPnzRRnH1Qa+EHSj
         B8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=niIOOJZwi6Rd9rd5VQccd8tyaLI6hOLSM5mEtLx1BTg=;
        b=BtVHyBM4XnkLpoZWe104Ds/Ik12iOHLgKLQFKG1+XJ4BJd4XdiQlA8x4fPhmU4bMGE
         //Usiil6ATNXuhu4WJWH4Nlf/RZiZCodwAR/ZRcs28nTccHwblkQrL3mlohL5w515V7F
         D6ONhB4Z+4Kfrm7TpcSANo8Jjb4AOySLxgTJ6a2ehGKGZKd2Cp+v7rAlVhIvQVpg5yQM
         vO+3YOZv2oqem1mDEw0m5q9/18z1ZZeegNcZX4zetjjeCNF+iWgy2VJbvWKfXM4ijE/V
         YhaLuMwyyJz5WZ3iJXiE4EZNJJSdJpe3napO0y1Tq0be7F4FECjUO0rE2w+yb7OO1An4
         QP8w==
X-Gm-Message-State: AOAM530nPYw/JpTlqiWlCZHrossdknbGV32iJj75Q8/0G/JSGnGthysh
        ggiigUxXtHuM2ZgLzYoyBOY=
X-Google-Smtp-Source: ABdhPJzHjcQlb5Fj3i6JRrlVLKijTLZKImv+ad0l0h2cHTzuL6TYVEUxQSNSJllPT3m2F6WHIKwPoA==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr22685677qkg.479.1608660256651;
        Tue, 22 Dec 2020 10:04:16 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id n66sm13515768qkn.136.2020.12.22.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:04:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 22 Dec 2020 13:04:07 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Alison Chaiken <achaiken@aurora.tech>
cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
In-Reply-To: <CAFzL-7tCyVb03ibT5NgOh+xUhEfMzSQB1efL6a114TVk9vfk+w@mail.gmail.com>
Message-ID: <e70ff32-279b-e341-284-211f5ba2db94@redhat.com>
References: <20201218141935.24151-1-dwagner@suse.de> <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com> <CAFzL-7tCyVb03ibT5NgOh+xUhEfMzSQB1efL6a114TVk9vfk+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 22 Dec 2020, Alison Chaiken wrote:

> On Fri, Dec 18, 2020 at 7:59 AM John Kacur <jkacur@redhat.com> wrote:
> > I also maintain the rteval program which uses cyclictest for measuring
> > performance while running loads, changes to the cyclictest API sometimes
> > require me to tweak how rteval works.
> 
> What is the authoritative source of rteval?  I don't see it in
> rt-tests, in kernel source or in Debian packages.
> 
> Thanks,
> Alison Chaiken
> Aurora Innovation
>


Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git
https://git.kernel.org/pub/scm/utils/rteval/rteval.git
https://kernel.googlesource.com/pub/scm/utils/rteval/rteval.git
