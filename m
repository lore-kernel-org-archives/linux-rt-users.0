Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81AC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3122244C
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhnktz3P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="82Ck8bCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKDKAw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDKAv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 05:00:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C04FC0613D3;
        Wed,  4 Nov 2020 02:00:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604484049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q22pwsM6Tj1e0wp7DHmM0yF6sfQnnx66IYQwrUyKPjs=;
        b=nhnktz3P0gZM+rjMsMcZ5kltHAUM1F/6Dr0BKbAhD98nRv8KkAk9f5fITxx9tES7cDs7Zo
        0HVDtox5v/Ax0X/+zpDYO4a+52EFP+79sPTLAdgXaZrrCf0lHxWNCV9KFPN0P3//0CgVJ5
        0pLWEgWC091auw2dWcqKwSBN3XLoBBNrbL2Y4oLc7DGtIgmehR8AiRj2nvVMiP/moTCzKf
        CsfhBJztAqM705AR9We4UzIxpOJJSWDDsMhSi3cYWwObOysrOVAGpPXmfoPoi797El2H5l
        dpUqVrIQF6ynua8arqZz9THL6wHGQd+L/9NNKPNof6IYMt97ratAOInnVCGsDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604484049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q22pwsM6Tj1e0wp7DHmM0yF6sfQnnx66IYQwrUyKPjs=;
        b=82Ck8bCSuZedBxpRO91qHX94plmSW0hsbkBVa9zsfns3HU/kYX6O035x5SGqQmTGGqcFfc
        DUjrle6GW7oODMBQ==
To:     Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
In-Reply-To: <878sbixbk4.fsf@ni.com>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
Date:   Wed, 04 Nov 2020 11:00:49 +0100
Message-ID: <877dr1mofi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 03 2020 at 17:31, Gratian Crisan wrote:
> I apologize for waking up the futex demons (and replying to my own
> email), but ...

I was staring at it already but couldn't wrap my head around it.

> Gratian Crisan writes:
> I was able to reproduce the BUG_ON(!newowner) in fixup_pi_state_owner()
> with a 5.10.0-rc1-rt1 kernel (currently testing 5.10.0-rc2-rt4).
>
> I've captured the reproducer, boot messages, OOPS, full event ftrace
> dump and some kgdb info here: https://github.com/gratian/traces
>
> The abbreviated OOPS (w/o the ftrace dump since it's too large to
> include inline; see link[1]):

Let me start at that then.

Thanks,

        tglx
