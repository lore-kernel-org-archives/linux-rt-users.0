Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17945C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jan 2022 18:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiA1SRb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:17:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiA1SRa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jan 2022 13:17:30 -0500
Date:   Fri, 28 Jan 2022 19:17:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643393849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4G/UgMQAt2YQByYMaEQ6C0YHEn5n2WWWHOkj3bwfwwA=;
        b=kU4zqUBnP9jXglj/EhzR+YAMJ+4iW7FpK6hHyi1TsQgmsAVQLHIxMo0Jpq9ZFY5h6Wlgb7
        TGHbWe6DJJdDgf//wfHmzW31EKS3NGuiBvQGtZ5WSbMgGdTwRd2yohFtJZxweRe9HmBX0x
        YRXZLzOAkmMKVrT4JqL0btHrHODUXRjpkTjv7qDtahO3igeqIh32dM75hi5nbElrl+1oiO
        DAt2aVmEXxkBuFigjNwOWeyPDGg6BNWGtB3dIRmYvEI/hIoiWZ8rMA8/+Bdcu9bmICHtU5
        Vkte5CCcNp/nl2ypHZJSe6fkny9U+R+DZhrrnxmUvzGAL+MrHRpAXnUnQEo03A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643393849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4G/UgMQAt2YQByYMaEQ6C0YHEn5n2WWWHOkj3bwfwwA=;
        b=/0PEpwzYy0TSFpBz6P+nCcoRqrCT7mv+qagepwwQIsxFV8hbUJ5gYYJjWJzFv1bR2C7al2
        5KpwH8tXyXTCjGBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rt-numa: ignore runtime cpumask if -a CPULIST is
 specified
Message-ID: <YfQzN4/oxz9o92Va@linutronix.de>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <YfBEDR4E2dNK8XzK@fuller.cnet>
 <YfBFaNrP/1LCgWoN@fuller.cnet>
 <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ba75eb3-8a8d-65fa-8458-f7f38bad2cb4@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-28 12:44:14 [-0500], John Kacur wrote:
> I agree that our current method is too restrictive, so I like the basic 
> idea here.
> 
> I think we also need to differentiate between -a with no arguments
> and -a all. -a with no arguments should inherit the cpumask from the 
> runtime environment but -a all, should be the same as specifying all the 
> cpus and ignoring the inherited cpumask.

do you consider number of online CPUs to not deploy more threads than
CPUs online in case some were shutdown?

> Thanks
> 
> John

Sebastian
