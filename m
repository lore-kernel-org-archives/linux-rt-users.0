Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C4C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiFOOTf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiFOOTe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40F35A97
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 07:19:33 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655302770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34aT0VyoKRxk+afzfmpRnTn3q4tLuhlfxpEQxGvPdjo=;
        b=pB3r1yKonuvuL6dqf0qvq9bDH/gZ02do98YX/PsFhFJu6JDfJ0m17UcoUf8mpGr6Qit8m8
        9oFnRBORAVP4ZmxonejSz2RS8uMX2w9q/jylpgzd1kO6FPclQDRupfN3isPe+ktbuMujC3
        hRxX9KTGP/WInqMYgXKoeqxFUaFkkuJnrjn1d3ksmQS/TUaFKFED/bHhh4qH6I7UQZ6Fx0
        LNSLLLh++j+j9GKEoGuTYUS5ty4DgkGmPpLDRkizsK1NPVJu4HL9En5/mOE6GOnOBBZv8G
        3Eo9XVol9fJilp88Npv0Ro5n4qggFdN67roujlIh8/oaM95Xmq1KorzZVYtM3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655302771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34aT0VyoKRxk+afzfmpRnTn3q4tLuhlfxpEQxGvPdjo=;
        b=36pEaVssmlztqkwAivrZTsxLyXwm/qKyf90kHuv7D/TcuNTqCUOy4O+geST0Vk34KA8iV/
        qKhAcRGdNKVD7EDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
Message-ID: <YqnqcQmELgKYlwWA@linutronix.de>
References: <YqnExv0GkIKTSwoI@linutronix.de>
 <19f21e80-ce44-07f0-2361-ece8e6a60ad4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19f21e80-ce44-07f0-2361-ece8e6a60ad4@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-15 14:24:31 [+0200], Pierre Gondois wrote:
> Hello Sebastian,
Hi Pierre,

> Since starting the threads represents some work that can disturb
> the threads, shouldn't the main thread be migrated to the
> 'mainaffinity' mask early as it is right now ?

I doubt this such a huge impact given that once the threads are created,
they do rt_numa_set_numa_run_on_node() and pthread_setaffinity_np()
among other things.

> I think it would be better to:
> 1. Save the initial mask of the main thread somewhere
> 2. Set the affinity of the main thread
> 3. Use the initial mask when setting the affinity of the threads

If this is *that* important I would lean towards always doing the
globalt_barr so all threads start once everything is set up. If I
remember correctly, the first few cycles are not counted and just fill
the cache.

> Regards,
> Pierre

Sebastian
