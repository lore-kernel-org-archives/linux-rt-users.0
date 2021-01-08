Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E6C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09C723383
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbhAHJaO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbhAHJaO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 04:30:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D82C0612F4
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Jan 2021 01:28:28 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:28:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610098106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8b8ZRfpdNTnMQBcJwv/CGIaXv/5VrDECrbbWvaBY1A=;
        b=z72BHw56jOor2yDAR2fcjpaZNoTSaCw1/jWWOZxphWPpCMSJ1KP6ux7nfDsejiqQQhHxHK
        3VTabXUfeMCwrYzaJUlEoXJHbGDKBJOWfoCrX0j6xsQiRMM80iNTZ4cxE/u3h9qAM6t6ce
        LqxiwvYXnrkyXjpYwl+lnwu+4s0r5Id4CGf9qgAzp3FLH0TmtB6swZ18cLfccC0gHFgIzF
        e5ZjyA6003Fgf4y9Wa2sMZCF50NrPLfQXcJJ2L1H+gaLKDoJeleUyXDr+ERL2Gva89/Vdb
        Xpd8GBmyQPvrCiExW49zAzZIgJXuVNWZs7ic7CQ4mG3z0eDAcR9FtSHcXwFx6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610098106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8b8ZRfpdNTnMQBcJwv/CGIaXv/5VrDECrbbWvaBY1A=;
        b=+4xdcSc/fcZUaQ88JKdiz++Tq2f+y67POqsYzApeROhunRSphQxGOntKUhPIasdSYeuBSy
        8j8dxHgRtV9IQfCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sergei Poselenov <sposelenov@emcraft.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: kernel crash with ARM64 5.4.47 preempt_rt
Message-ID: <20210108092825.mszmnauyb7lvhc7e@linutronix.de>
References: <20201230140917.50e86fc3@sergmir.emcraft.com>
 <20210107164902.5guoavadivwugsz3@linutronix.de>
 <20210108082911.cz7oropmnezhqx5p@linutronix.de>
 <d868096428ede5ef93cca7431cf67c021bf2541b.camel@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d868096428ede5ef93cca7431cf67c021bf2541b.camel@emcraft.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-08 12:15:05 [+0300], Sergei Poselenov wrote:
> Hi Sebastian,
Hi,

> Thank you for the feedback, it is very helpful.
> Could you please provide us with a pointer to the bug?

https://git.kernel.org/rt/linux-stable-rt/c/5fe7108bf940d

Please don't top-post.

> Thanks again!

Sebastian
