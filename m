Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1645C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA384206C3
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgEZOYg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgEZOYg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 10:24:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B57C03E96D
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 07:24:36 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdaVO-000465-PQ; Tue, 26 May 2020 16:24:34 +0200
Date:   Tue, 26 May 2020 16:24:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alison Chaiken <achaiken@aurora.tech>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: remove of ktimersoftd in linux-rt-devel 5.0
Message-ID: <20200526142434.4lmv5drdjkklqcu2@linutronix.de>
References: <CAFzL-7tzwnBEnt_q2f0BPSAO3To_Zaxt4bLtfzKVOiyJTua45g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFzL-7tzwnBEnt_q2f0BPSAO3To_Zaxt4bLtfzKVOiyJTua45g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-15 16:46:48 [-0700], Alison Chaiken wrote:
> About a year ago the following commit greatly simplified softirqs:
> 
> commit 6f6ba7715a91877cf5fd2b357db3799baa331d9b
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed May 29 18:47:32 2019 +0200
>     softirq: rework
> 
> It also removed ktimersoftd, without comment as far as I can see.  Is
> it obvious that performance improvements due to lockless
> synchronization render useless the earlier split of ktimersoftd from
> ksoftirqd?   Is it now less likely that a large number of other
> softirqs that are run immediately when hard IRQs terminate will use up
> ksoftirqd's time slice and prevent the timer softirqs from getting a
> chance to run?

When hard IRQs terminate and raise the softirq then the ksoftirqd is
woken up. The softirq may be processed by the thread _or_ by anything
else that is running happens to process softirqs. That can be any
force-threaded interrupt handler.
In general nothing raises softirqs from hardirq context. One exception
here are POSIX timer. The plan was to rework POSIX-timer code.

Sebastian
