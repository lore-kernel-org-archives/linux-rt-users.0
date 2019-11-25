Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49511C432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04E20835
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 17:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfKYRbr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:31:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRbr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 12:31:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZIDB-0003Wb-Qc; Mon, 25 Nov 2019 18:31:45 +0100
Date:   Mon, 25 Nov 2019 18:31:45 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dick Hollenbeck <dick@softplc.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: wait_event_interruptible_timeout() not sleeping accurately
Message-ID: <20191125173145.57dasbthc4zxz5qm@linutronix.de>
References: <d2127c27-f53d-8b0c-5a44-6bdd6edd2204@softplc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2127c27-f53d-8b0c-5a44-6bdd6edd2204@softplc.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-22 13:39:38 [-0600], Dick Hollenbeck wrote:
> 
> In a user thread I block on wait_event_interruptible_timeout() for about 3300 usecs or
> until my threaded interrupt handler calls wake_up_interruptible() when the hardware event
> happens.
> 
> This seems to work fine for the case when the event actually happens.  But for the timeout
> case, the function wait_event_interruptible_timeout() is sleeping 9000 usecs or so rather
> than 3300 usecs as requested.  I confirmed this by toggling a GPIO pin before and after
> the call and feeding that signal to a logic analyzer.
> 
> The user thread is RT round robin at about a priority 5.
> 
> Am I doing something disallowed under PREEMPT_RT?
> What could be the reason for the inaccurate wait_event_interruptible_timeout() timeout?
> 
> 
> 			ret = wait_event_interruptible_timeout(bh->rx_waitq,
> 				bh->rx_intr_flag,
> 				usecs_to_jiffies(aTimeoutUSecs) );

Could you enable some tracing and check what delays the wakeup? There
should be some delay between time timer callback and the wakeup. Maybe
the timer itself is delayed if enough RT tasks are busy.

Sebastian
