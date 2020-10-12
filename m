Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D648C433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 10:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29792080D
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 10:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oznsj9rk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFgS06jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgJLKM0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgJLKMX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 06:12:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D63C0613CE;
        Mon, 12 Oct 2020 03:12:23 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:12:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602497541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdEsPfkP6ELSvsf0xhQrsCqwY+f265qjWQciQjRTzmU=;
        b=oznsj9rk5LKQwYF5e/OJKi2GwhNvvVc0gFIgpVsqaKEHoQeSmptHXDi1C5xepjCMiIY8x8
        pamx523S1h1V8e/BxycCtQoSMZlNAfwXG2mSybw05fscQJAXE9Is6rN3GxVqd2Gfez+u2w
        nLbO0vO6klk4VUWKN1JvgA8nyJ1IZHGeUwAWaqwCJo8O9f/FBd1y1axgQFmo31ud4Lf6eP
        0DrU2PCms5gP/YM0vUPmNGpkNdcxp55B9xaAT7aKC4l3d0GQN9rbeoGZkL3M0LANzxUY40
        RwpOiMpFyCIRen6IupVzrU6ZGzHGMz4lC/mbbgW13TG4pw8ToJOD+blzGmZgng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602497541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdEsPfkP6ELSvsf0xhQrsCqwY+f265qjWQciQjRTzmU=;
        b=LFgS06jots95MgjR1Ql1efcUH5B4fFDP07YepvuO1SqQFa+Bw7qAgFtGpGNriagBj2/dGX
        T2Yu7bhsAvlelGDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <clrkwllms@kernel.org>
Cc:     rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix compile failure on RT with PREEMPT_RT off
Message-ID: <20201012101220.q2bfwq2k6xbdp77c@linutronix.de>
References: <20201010214554.389157-1-clrkwllms@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201010214554.389157-1-clrkwllms@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-10 16:45:54 [-0500], Clark Williams wrote:
> This patch is against v5.9-rc8-rt14
> 
> Fix a compile issue when CONFIG_PREEMPT_RT is not defined. If
> we're not on an RT kernel, just set the migration disabled
> status to zero.

Thank you. Let me fold it where it belongs. As of now, I don't know if
we can keep it or have to use the trace events Peter made.

> Signed-off-by: Clark Williams <clrkwllms@kernel.org>

Sebastian
