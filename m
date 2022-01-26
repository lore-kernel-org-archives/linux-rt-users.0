Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624DC28CF5
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jan 2022 07:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiAZHVP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiAZHVP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jan 2022 02:21:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9BC06161C
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jan 2022 23:21:15 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643181671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKegr6zs/dt5ju3Qeh7+/0KXIl34ZHi4eljR6A8A83Y=;
        b=k9cUEGwxuNVjz7WnIRryawv93Wr4W6JAOpiUtCiubgWBGbrBrMl7oX01cINRAwZSoX+wxE
        hY3MOV/5JRz3X4dz+UomtE8L871UDUxNt91iI73xYYXsJ0T8tOfQtx2ijLXPaiJ28+qO7m
        hOW8D6lXFIWs/48J0Fq5jZl6ceQ7Tp05Y9wDmrpU33XQHRvqb0j2SOU/jnt4QZwHJM1mYT
        ZaAsKJdriAzMKrbgaJCGFs1iDuwr5t5ulgAlZ+Ptr1T81JMrwwxNilxOPsFn5LdlnDyrCV
        19CLOkaYactufDbUpeInsCpWCxYmPpbcdTwZz0B0MHf6KMtqCKMEaM0ZO5tcag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643181671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKegr6zs/dt5ju3Qeh7+/0KXIl34ZHi4eljR6A8A83Y=;
        b=ELw9B/XkC2qcHuXBNLsaNDQJdVRZZHhlSCGblNMXkKVRNH+rUPDszOc0ahH4S0NvdKyH7I
        hEIwChiGwG7H5NBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] rt-numa: ignore runtime cpumask if -a CPULIST is
 specified
Message-ID: <YfD2Zt7xJSnMsB6z@linutronix.de>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <YfBEDR4E2dNK8XzK@fuller.cnet>
 <YfBFaNrP/1LCgWoN@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfBFaNrP/1LCgWoN@fuller.cnet>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-25 15:46:00 [-0300], Marcelo Tosatti wrote:
>  
> When using isolcpus kernel command line option, the CPUs
> specified at isolcpus= are not part of the run time environment
> cpumask.
> 
> This causes "cyclictest -a isolatedcpus" to fail with:
> 
> WARN: Couldn't setaffinity in main thread: Invalid argument
> FATAL: No allowable cpus to run on
> # /dev/cpu_dma_latency set to 0us
> 
> To fix this, ignore the runtime cpumask if neither "+", "!"
> or "all" are specified in the cpu list string.
> 
> Suggested by Sebastian Andrzej Siewior.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Yes, thanks. Looks nice.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
