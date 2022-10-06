Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40349C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 06:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJFG5T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJFG5S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 02:57:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806441986
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 23:57:17 -0700 (PDT)
Date:   Thu, 6 Oct 2022 08:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665039436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uugob/txjQw9e41RpkpLPQB4yDUFJ5g82nvhFbBtT/E=;
        b=s7wl0nWvIO8bDiPMvhD5JLND6IpcXdyQ/Mf9zdFDsnCKhPJ/niHmJ2+nLUK+Y0aUeK+zFH
        aGMoqUhhsuJqOwN3KUL8KEc3Z7+2vp/PTwES7BG6k/qT7m6lhLT/3eH4/8awbOd8o/ql5w
        Jr5inJtCVUied5gUF9PIbjzF5/M5GfXnBnIe3fPmrCDskMNITPG0AyW09r07Qu68cYM6oW
        TEJ4psgeVaxN+m0WXu6EQkXZitiFEJChsD6a3yu75vl0WZRhpRAEMxG7ETTsyE8kRqVmKQ
        XBOesPX9zn1RHFIFe01IAM1RdoygEyhMSQCSeS3fxwEQPSSX44/XMxXcsjursA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665039436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uugob/txjQw9e41RpkpLPQB4yDUFJ5g82nvhFbBtT/E=;
        b=gwYCXE6vbSKQSwh5+9lZOgAK97py7ox/bn7VjyURedfhljt4O5uhBtB7XFspG/v3BGe08L
        sQOs42vy/7T9yQAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Florent Carli <fcarli@gmail.com>, linux-rt-users@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
Message-ID: <Yz58S8PXdBOO9bhL@linutronix.de>
References: <CAJuRqcBVvpTCrDTNPGeJVARYfVxGxVWGXqq7eYjJDzUmprcqBQ@mail.gmail.com>
 <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-10-05 18:03:39 [+0200], Daniel Bristot de Oliveira wrote:
> On 10/5/22 18:01, Florent Carli wrote:
> > Hello,
> > 
> > I'm trying to isolate some cores to run a CPU-bound real-time task and
> > even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rcuc
> > threads wake up, and I get RCU stall warnings on the isolated core.
> > As per the documentation, if I use rcutree.kthread_prio with a
> > priority > my RT task, then the rcu stall does not happen.
> > 
> > However I find it confusing: why are the rcuc threads woken up on the
> > isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (very
> > likely erroneous) understanding, I shouldn't have to fiddle with rcu
> > priority... In other words, how come I get rcu stalls on cores that
> > have no rcu callbacks?

There are different things:
- with CONFIG_RCU_NOCB_CPU you get addition threads and can move the
  rcuo* theads away from the isolated CPU. That means the callbacks will
  be handled on a different CPU.

- you still need to track/ follow the grace period. This still happens
  in the rcuc thread. To get around this you need to use NO_HZ_FULL with
  isolcpus/rcu_nocbs.

> Adding Joel because we had a chat about it during lpc...
> 
> > Thanks.
> > 
> -- Daniel

Sebastian
