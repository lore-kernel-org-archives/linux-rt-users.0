Return-Path: <SRS0=J4zX=TK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B8C04A6B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5491020989
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEJKd1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 May 2019 06:33:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfEJKd1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 May 2019 06:33:27 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hP2q7-0004jE-1i; Fri, 10 May 2019 12:33:19 +0200
Date:   Fri, 10 May 2019 12:33:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     minyard@acm.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190510103318.6cieoifz27eph4n5@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509193320.21105-1-minyard@acm.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-09 14:33:20 [-0500], minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The function call do_wait_for_common() has a race condition that
> can result in lockups waiting for completions.  Adding the thread
> to (and removing the thread from) the wait queue for the completion
> is done outside the do loop in that function.  However, if the thread
> is woken up, the swake_up_locked() function will delete the entry
> from the wait queue.  If that happens and another thread sneaks
> in and decrements the done count in the completion to zero, the
> loop will go around again, but the thread will no longer be in the
> wait queue, so there is no way to wake it up.

applied, thank you.

Sebastian
