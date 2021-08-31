Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF7EC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 11:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E7660249
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 11:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhHaLLV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbhHaLLU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 07:11:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F557C061575;
        Tue, 31 Aug 2021 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xIcniAXVEz+AXN/0a4kDY1GAZnOitc7zGFHH2uOA5CU=; b=ljw4Ct+lubDUoFc4ijz3NpAu0X
        x6JBsVemBNt562JSa2TK1R9BqpyNgOuDDVW2l3KSMDETd2LDQmi6uEPgPNb5zf/lzaFW+XZ+FWolY
        4SVqAsJ7rSXz0Qxt+hDYqUIPrn9UWlA1C4m7ngt8KSapHWc4QowuwbaphXZOHf39UuzCgH5N61N3W
        IQIAhDG60KSjI/DLPxkrd8/yESMJRjlaNxiF9vJ5bc/jlc8FcGbSm/pKwVSW282qjKTf7eknfXqpR
        Y4zJQ1FN7mpMyfyFo/B+LJ3PnbgFsnZosKFPEbBw2PsK1cczP2Z/y99CtsQmQEok6RXwUAF27KGsk
        9UgZNo2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL1dE-0017y2-9Z; Tue, 31 Aug 2021 11:08:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 823713005AD;
        Tue, 31 Aug 2021 13:08:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 746642C83EADD; Tue, 31 Aug 2021 13:08:43 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:08:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 4/7] sched: make the output of schedstats independent
 of fair sched class
Message-ID: <YS4Nu6LJwwxfcTr1@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
 <20210824112946.9324-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824112946.9324-5-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:43AM +0000, Yafang Shao wrote:
> The per cpu stats can be show with /proc/sched_debug, which includes the
> per cpu schedstats of each task group. Currently these per cpu
> schedstats only show for the fair sched class. If we want to support
> other sched classes, we have to make these output independent of fair
> sched class.

Arguably the whole rt group stuff needs to die, please don't enable it
further.
