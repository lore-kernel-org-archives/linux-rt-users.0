Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B28C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 15:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7842073C
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Jan 2021 15:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbhAUPmU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:42:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbhAUPmP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Jan 2021 10:42:15 -0500
Date:   Thu, 21 Jan 2021 16:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611243690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsJBtC78TCdgLmtjTWdwNyIjhZYcT0Vs0pdRwNLIrEs=;
        b=1D+LXvShRN+2+y4/3plqNnWI7AWNGKKEUAv1irNePftMjakKv3pbV+l3Mvto4/fk4ZQA+V
        jil4MVFCBe8h0Vy4rEsBzfw3X6b6vxrKWWWvmWVzTwxv0bHx8wpKUtcVcCZLMDFyoFSm0Z
        ML2KfKtOOgdLVn1YjyTsqLe1dIjV0lqm5PUTGhv6nJzBkF1N9moDTkvVbUJldkFgOKnjEZ
        K148uF8gXrwveYvJw8EnPcPew0wEcs2B9TJSKnt1DAA/+LyDiE4LL2lr82uuW3be0kfST/
        S8eLq+JUbaGXd+eOth/L32aJiDCMBgMPEju5liXN9Uy1T1qlDe4WQ2YwbhP6GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611243690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsJBtC78TCdgLmtjTWdwNyIjhZYcT0Vs0pdRwNLIrEs=;
        b=Tvaad29Lt8t3qZQaWiwhMjLZ6jgeHa0yBpxadAhGQAq6we1ttTcmxIjcfr+bHGaipE0Y5w
        bKlbaFAQQsJSJCBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: thread_do_softirq in 4.19
Message-ID: <20210121154130.hlru3m3cw4sgb7ly@linutronix.de>
References: <20210108144314.GA23597@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108144314.GA23597@hoboy.vegasvil.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-08 06:43:14 [-0800], Richard Cochran wrote:
> Dear list,
Hello Richard,

> The function thread_do_softirq() is never used anywhere in
> v4.19.135-rt60.
> 
>    git grep thread_do_softirq
> 
>    include/linux/interrupt.h:505:static inline void thread_do_softirq(void) { do_softirq(); }
>    include/linux/interrupt.h:515:extern void thread_do_softirq(void);
>    kernel/softirq.c:674:void thread_do_softirq(void)
> 
> Is it supposed to be called from somewhere, or is it simply dead code?

Dead code. My guess is, that is around unused since the softirq rework
around v3.0/v3.2. I just looked at v3.6-RT and it was unused there, too.
It has been removed it in v5.2-rt1.

> Thanks,
> Richard

Sebastian
