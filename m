Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326EBC4361B
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C81206C1
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 12:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgLNMdq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgLNMdp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 07:33:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4853C0613CF;
        Mon, 14 Dec 2020 04:33:05 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:33:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607949184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMr4ajE5DsQOqT9/htmdWQwzJ4yGgYvL0YAd9GCqiuE=;
        b=MOSGk4xT937mdsGYsn25fJlBfnXkCZOtdtkOa7EAl0GUc3obK75n3SQ6RPJC9eWWFeM2od
        Fkq74XmgXUDtRfj9Q7OPjdE+u3eWJSbVSNW9XA48oxH12BXvIHCSlhclN4utijvKJOo971
        dRj+XgJokY5BeN6hu4Sniaqe3IppfRTnUcnEC5ku06wPjnY7SpMlkcGWRkVrI3EMBSvAZj
        0Uf/LbQeWBoNpeW5ig62XSYaBcO+s4lncP4guUjM6gZ/4EA5ioZu3+gQKMW0fBeYHkuwU3
        Zrfy8Epti/GlPfw9Jk6ghD39MCB7uHNMgkZ5CunCQTvmVZVkt2f80YncpSvwag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607949184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMr4ajE5DsQOqT9/htmdWQwzJ4yGgYvL0YAd9GCqiuE=;
        b=zDw1e0gMt8Q4AzFHk+ckQgAEYyxsvOFuwh7o8BzUdqvELIHz0l5/isjEUQsLAd9D3NMvaM
        39VH64C7Dgk58iDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Orivej Desh <c@orivej.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201214123302.w2bem7tlb664jdvx@linutronix.de>
References: <20201208212841.694b3022@orivej.orivej.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208212841.694b3022@orivej.orivej.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-08 23:58:27 [+0000], Orivej Desh wrote:
> Greetings!
Hi,

> With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [1]
> linux-rt defines functions migrate_disable and migrate_enable.
> They are used in linux headers in various macros and static inline
> functions, and in particular in kmap_atomic and kunmap_atomic.
> The latter are needed by ZFS which currently fails to build against
> 5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL.
> Could you export them with EXPORT_SYMBOL instead?

This is out of my jurisdiction, so just a few notes:
- v5.9 is out of maintenance. Be careful.
- We don't export symbols for out-of-tree modules.

Sebastian
