Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D0C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Mar 2021 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0530361A09
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Mar 2021 09:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhCXJc7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:32:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhCXJco (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Mar 2021 05:32:44 -0400
Date:   Wed, 24 Mar 2021 10:32:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616578363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kpIjaa/mmToGzBMdJSsSDMla3gynHsUQP6WFJr2IyM=;
        b=xK0mF3XlDAn3moLnQMmG4ejY2+fMcdQDE5sydDx+QO2MT6g+DtoIcC1r4YvTW4YGmg2Mym
        /PibNIJoF7gBvX18z50WS9k078Xn6ZbcVYTCchg1vlrBb41vv9AGmSf2rAcMyV0/ZmtKBx
        Sjf2bvc1t1tV3BbqEwjCbv3nlu7wM//XIr6eFzuDpZl8/Ehj5uoMhhS66x7wUNBAngRzE5
        NArj41evBBsd50WTTT96SltTJsPiRMTqHAmYbzWXzn7PKBis+4LO4brarMDqFCaKxmvvTP
        1F27HInkZ6EuW01BBJmkgvqpyiI7zVMxgYsn/9ttf39wSESzmydy4BjAYS/JzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616578363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kpIjaa/mmToGzBMdJSsSDMla3gynHsUQP6WFJr2IyM=;
        b=cM/yzJ7mOu3U9VBiDM2iu6UESfJS27DDIB5ryN4hK7oEn2gmeBIxs9eN0ou3fCj8p9GVHt
        TBMrV4xPE1/AQ2CA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
Message-ID: <YFsHN/w+2mDHr1W8@lx-t490>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
 <YDPZ0xrEcsS5SfWh@lx-t490>
 <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Jonathan,

On Mar 21, 2021, Jonathan Schwender wrote:
>
> On 2/22/21 5:20 PM, Ahmed S. Darwish wrote:
> >
> > Do you also have any numbers showing different results
> > with/without "--mainaffinity"?
>
> Sorry for the delay. I do have some numbers now, and there is a
> benefit to using this option if CPU isolation + CAT are
> used. Otherwise it's not really visible.
>

Thanks a lot for the results.

Since I'm doing some CAT-related stuff on RT tasks vs. GPU workloads,
I'm curious, how much was the benefit of CAT ON/OFF?

In your benchmarks you show that the combination of --mainaffinity, CPU
isolation, and CAT, improves worst case latency by 2 micro seconds. If
you keep everything as-is, but disable only CAT, how much change happens
in the results?

Also, how many classes of service (CLOS) your CPU has? How was the cache
bitmask divided vis-a-vis the available CLOSes? And did you assign
isolated CPUs to one CLOS, and non-isolated CPUs to a different CLOS? Or
was the division more granular?

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
