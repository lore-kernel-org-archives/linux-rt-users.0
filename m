Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFAC4363A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD912224A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3IJBa23H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAkeEEJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787757AbgJZR0F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774755AbgJZR0F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Oct 2020 13:26:05 -0400
Date:   Mon, 26 Oct 2020 18:26:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603733163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w09g9ntG++KbDwWTJng4haKq82uB5PtCQULLzShi/Ms=;
        b=3IJBa23H363tO2mHGaelE0hr1jeHXjV39RgpGjFA/SDNCN/Byl5yh/UEpCWEfQxbGX8ZAZ
        DH0idBMZem248bzek9mcjaTHr+8TBt+jjVN33sDe2d26n7ldr1IfkFBEVojXLtX5X6YiQ8
        V5kdcq25I98QIJBP06QCSOG9Xl3Rt9Pm/3SfDF1XgM6JyVoyEpkHgW2OH2UqRkmTMOQ2wl
        EMXwqdzEUoKmRj1rLfNPJZ8Y57BCpX7bQm65Pj4Iojp6PqqmK9CcFQoZoOjk5fkMBisYM8
        zGdlQtwPhkBvJosE/TdbQ369Z7bYMSj2R1amGQEZHB4F0nVP6g/cFyV3Zkl0+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603733163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w09g9ntG++KbDwWTJng4haKq82uB5PtCQULLzShi/Ms=;
        b=gAkeEEJtqD7EH8m+mzfcZxo/1HPjkxirqbssMudnT5uScRe4Ckr8hvgIryiYbPeu3ni+Wv
        kSkvQAwAQzUdYHAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201026172602.kedrnefiaqzrwoot@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
 <20201024094224.2804-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201024094224.2804-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-24 17:42:24 [+0800], Hillf Danton wrote:
> Hmm...sounds like you learned English neither at high school nor
> college. When did you start learning it?

He learned enough to submit valid bug report where you could reply with
	Thank you Mike!

Sebastian
