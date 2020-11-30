Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B9C64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB4F2084C
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4S4px9cy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbkqf3WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgK3NwE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:52:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgK3NwD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 08:52:03 -0500
Date:   Mon, 30 Nov 2020 14:51:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606744282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxSN750vlRFXw5tq8pVO2FBe63q/9357pKDV5FwJKas=;
        b=4S4px9cyxOo4yRWkAb099VyA1PNwwi3Hcdd5R18iHZkm3/qj8CsbgAHT8R1Irt8HmtJKCx
        4dLZjTugOHgH2ZvhFmuzqtM7Akm5Cy48lonpXO8ZjU7Ym0QMlskb3GpGvJMz6NWte++1Bk
        OhDCmy6s387aagqozzcKxWqpn8MlzNE+ljeIsX0IO/eLDVvjgS3hxhY1NaCVs/nB2Ge8CD
        TN9KDYJZDTd0NswDjh+DTI7WNcF3ZF2x82/QEjSBaBmx94WPRr8XCTogNPrt7YneMpHkQm
        3f8+ixAWxSsMNmjwTELZiehWltzzgTgYjJl+ZN0CCoAadgrAOsPRt0Vo6qzmpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606744282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MxSN750vlRFXw5tq8pVO2FBe63q/9357pKDV5FwJKas=;
        b=jbkqf3WTkeqoGqBgnXPzmE2h01+UBhDtWl95g0tAmxAL4e/PZg93Cid1whCeXV4f1zUYQi
        Q1RfmiMCCeI6aODA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20201130135120.4ogw7hyjdu543tgf@linutronix.de>
References: <20201122201904.30940-1-valentin.schneider@arm.com>
 <jhj4kl7upei.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhj4kl7upei.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-30 10:09:41 [+0000], Valentin Schneider wrote:
> FWIW, still squealing under v5.10-rc5-rt11.

I could apply this into my current RT but it would be nice to get this
applied upstream.

Sebastian
