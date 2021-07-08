Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC2CC07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E34B6141E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhGHPYl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhGHPYl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 11:24:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F2C06175F
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jul 2021 08:21:59 -0700 (PDT)
Date:   Thu, 8 Jul 2021 17:21:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625757717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MHEVDLJWtBf0Cm2p75+YTIMJc921KBXopi1/tNkd+w=;
        b=rcnuqKG7qK1hmOqug4lXyejZ4uiwqp7zv4dBQdrtINDXgmcXYCFSXAOzkp4m9Bvhmqsc9M
        DUqMaimRl9bSPN/MTCAAPwd7ONoNYl+Gifg8KqZ0HP/mpI48iCEO8vXouveYgokKfrweGV
        BQYDykQ6Fd0MgxQ3RpRI/45pKC8eUDhUb+l6Oq+RRTxOgVuZgoDQ+VCawf/+Yzj9s4Pr/Z
        dAtKRNsRhcO+zbAgugrCbqWQvhTThm3kSav+9ui/iLEKWoVBs+D4TZ5iGO8aXQIA+1WMoF
        F2GpYHVFO37S+AzoK2RmtN70Drs91qSP8KMr7tDGkZYCKdRb69cb6nm7dE3hJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625757717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MHEVDLJWtBf0Cm2p75+YTIMJc921KBXopi1/tNkd+w=;
        b=ntGh+BKSJwNeieHnKSv6ycGsytXsU/T03AUWAg+MItZYlYFcq81Rnd+kIq//qOcX8+P5Ze
        gxOaSVLz78/K8EAw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Matthias Klein <matthias.klein@optimeas.de>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Working sample 5.10 kernel configuration for an IMX6 board?
Message-ID: <YOcYFIo2GjTdyy5P@lx-t490>
References: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR10MB3107F4D6E0F50ECB027C06A199199@AM0PR10MB3107.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 08, 2021, Matthias Klein wrote:
>
> I am trying to get the PREEMPT_RT patch to run on a Ka-Ro TX6U-8033
> module (800MHz i.MX6U7).
>
> The kernel boots and basically works. But I have measurements with
> cyclictest with maximum latency of up to 2..3 milliseconds with only
> 100000 runs.
>

Was this an official v5.10 -rt release? If so, which?

Please note that applying the preempt_rt patch over NXP's vendor tree is
not supported.

> I would like to compare my configuration in a first step with a
> working IMX6 configuration which has no such outliers.

Attach your .config and I'll give it a quick PREEMPT_RT sanity check.

thanks,

--
Ahmed S. Darwish
Linutronix GmbH
