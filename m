Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3595C4361B
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67892208D5
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439091AbgLNIeI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:34:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgLNIeI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 03:34:08 -0500
Date:   Mon, 14 Dec 2020 09:33:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607934806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAdcvyzooTiVtSTt964I3eOn5LXhfT43CQeldzY51Us=;
        b=UA9/MGO02EnLuwks3Fig0ypLwA0o1YyzvnJDPOPJEYIhf+RXi1U9+S9RAaGkqeujuTQpLQ
        GsFVYToobXGwWKxnzjBAUrvwMD9mcW5b7FS9nRLcfVtEYrPYWroukr6yVtxM/b+VVq11BJ
        Xca+JSWX4nPzlsy2fZaxfMeRbHPeILPaY7YS6dRr6QElMRrqW3UOGo6Y7yOFsYBXLUOsRF
        tth8D0rAcD4Kf5vtQ2JJOjj6Bu2sDL2lNw5/7VrmhEYOmDniGfA9kIo7ggL3w1vNvOWrUb
        MknTQBjm0rK/Y0YBH1VBYwMzJziajeQwvyPrRuGIdxvC48zatzVxd/bDBcwwZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607934806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAdcvyzooTiVtSTt964I3eOn5LXhfT43CQeldzY51Us=;
        b=UXrS1Pc6htHKbbkoWddvBNKc0b70HnXoH7L8JY6Pe8OVv+lTTUC92l4auPw7ljUaVTNTFi
        UA/zBam+xDoDsjBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/4] Revert "hrtimer: Allow raw wakeups during boot"
Message-ID: <20201214083325.mtk4yib3ulikbso3@linutronix.de>
References: <20201211214103.954245915@goodmis.org>
 <20201211214130.387508159@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201211214130.387508159@goodmis.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-11 16:41:05 [-0500], Steven Rostedt wrote:
> 5.4.82-rt46-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This change is no longer needed since commit
>    26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

This patch has been integrated in v5.7-rc1 and it made its way into
v5.4.61. Okay, why not.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Sebastian
