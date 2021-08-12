Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC8C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 07:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A2D6103E
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 07:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhHLHOH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 03:14:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhHLHOG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 03:14:06 -0400
Date:   Thu, 12 Aug 2021 09:13:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628752420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TT+IOV++xmgyzv/1NzuKtd/xMzcG0MfLzaaGtPq4Xjw=;
        b=S+pNi5b5u96U7t4KmFguphqgnLFlDhwOu3DnjqE8Gm4O7hNuuQ8bUQawy8/WPzLgYwn09r
        AknDdsK6mdkTB2BFCZDVqlXPYp7M3IeO+fxSyFS7jufgButdPjSjavF0gmo1Hohy4IJTbs
        ARdfhosSWXPCdNSjvKOF+8M22op0IUswZyifbkP51oIJdmVGtzzpq1ZdmW3tcB5JB1xgkD
        ANvwMgrVe8TCjm2eeZztor5UxI0HFNfnkhEsvljcuwslRIT2H3zn3MzXeLBU5KX4nXppiw
        Z1f42yRMXKLAzZKIgn1a5J4BlG512yIj9sqm0r2392r64Uth6ErRQJnVCPvSbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628752420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TT+IOV++xmgyzv/1NzuKtd/xMzcG0MfLzaaGtPq4Xjw=;
        b=WY9RNmkB/nwIlq6xNlJx3ujiE/rGBlphf0bh4FHoEilydxQP/N35XbR8GPeFvmHR1zptJ4
        bht9Sejwp/FpypDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 0/2] cpu_pm: cpu_pm_notifier_chain vs PREEMPT_RT
Message-ID: <20210812071339.fm6kt7wugewxo3al@linutronix.de>
References: <20210811201432.1976916-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210811201432.1976916-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-11 21:14:30 [+0100], Valentin Schneider wrote:
> Hi folks,
> 
> This is v3 of:
> 
>   http://lore.kernel.org/r/20210811131405.1731576-1-valentin.schneider@arm.com
> 
> which addresses cpu_pm's notifier chain not playing nice with PREEMPT_RT.

Thank you.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
