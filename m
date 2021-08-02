Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C5AC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9AD610A2
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 08:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhHBIZ5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 04:25:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhHBIZ5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 04:25:57 -0400
Date:   Mon, 2 Aug 2021 10:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627892747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xX182M09BsP3t5u5fpQK/eK6k4BYOmOPJnY2+XJBF4=;
        b=gMqKvYjGqdl+Su3vDIaJQrjyu8HfNvauCLg9/R6VRlnhgE6Kn+Dfx2d5wuRmHegPRFQ+7S
        5PGxIDgDlu1v1QSyLmWOyyQEEQ/JpCRY1AAUYg1uPVwxuLE/+n2vVJbb0KRhwhn1TXSLEL
        AAj8azCo/s10DFVTG7pNZySlNDqJ2AQlBrfanhweqP7vxWRYTTYIkJP9QBowWvyvJvJvbP
        vq692K/gw+pktOZPjiwCBg4nFOJppE+DRoQ8CDzyx3pqwgBCkCGROHeLvYLNLqR+GWqHK2
        vek8ZmufYCqmHVFPD+LmVqjYU6v1LkJVhjHN2lEuswGRIUndIo7fuVQGJlqwSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627892747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xX182M09BsP3t5u5fpQK/eK6k4BYOmOPJnY2+XJBF4=;
        b=fZuvLCL2R0DgklSVisM/9asgJSrfB3DLVYfILV+j5h9q5l/2KboTHartbl3OXspLb9iqFM
        n55gTLpeTaYM+4DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
Message-ID: <20210802082545.bykz23s3ouwa4drn@linutronix.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
 <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
 <87pmuzsf1p.ffs@tglx>
 <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
 <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
 <20210802070218.5js3exubjxvsicx6@linutronix.de>
 <edd2f9fd1489e1ff05bf526a3059a1dbb81107df.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edd2f9fd1489e1ff05bf526a3059a1dbb81107df.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-02 09:18:34 [+0200], Mike Galbraith wrote:
> Nope.  Before I even reverted the wake_q bits, I assembled a tree with
> the ww_mutex changes completely removed to be absolutely certain that
> they were innocent, and it indeed did retain its lost wakeup woes
> despite complete loss of newfangled ww_mutex.  5.13-rt acquired those
> same wakeup woes by receiving ONLY the wake_q bits, and 5.14-rt was
> cured of those woes by ONLY them being reverted. I'm not seeing the
> why, but those bits are either the source or the trigger of 5.14-rt
> lost wakeup woes... they're toxic in some way shape fashion or form.

Okay. So the ww-mutex bits are not the cure then. All you do is booting
KDE/Plasma in kvm with virtio as GPU or did I mix up things?

> 	-Mike

Sebastian
