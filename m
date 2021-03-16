Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C201C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACA564FF5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhCPISy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:18:54 -0400
Received: from mail.monom.org ([188.138.9.77]:54186 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234358AbhCPIS3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Mar 2021 04:18:29 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8DF4D500328;
        Tue, 16 Mar 2021 09:18:26 +0100 (CET)
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id 543B1500182;
        Tue, 16 Mar 2021 09:18:26 +0100 (CET)
Date:   Tue, 16 Mar 2021 09:18:26 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210316081826.bthxqja6shbcp36j@beryllium.lan>
References: <20210315193707.359702-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315193707.359702-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter,

On Mon, Mar 15, 2021 at 03:37:07PM -0400, Peter Xu wrote:
> CPU list should allow to be any list rather than only the cores that are
> allowed to schedule for the current process.

See commit aaa57168dfd3 ("rt-tests: cyclictest: Only run on runtime
affinity and user supplied affinity")

> Before this patch, cyclictest will fail with below condition:
> 
> $ taskset -pc $$
> pid 2316's current affinity list: 0,2,4,6,8
> $ sudo cyclictest -m -N -p 1 -a 1,3,5,7 -t 4
> WARN: Couldn't setaffinity in main thread: Invalid argument
> 
> After this patch, it'll be allowed to run.

As John writes in the commit above message I think cyclictest should
honor to the runtime settings. The warning above could be extended and
telling you what's the problem is.

Your commit message should contain the argument why it's better not to
check the environment settings. So the question is what is the least
surprise for the user?

Thanks,
Daniel
