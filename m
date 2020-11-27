Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C9AC64E75
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB2722243
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Nov 2020 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Way3YzAB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDWBDzhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgK0Lnp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 06:43:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK0Lno (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Nov 2020 06:43:44 -0500
Date:   Fri, 27 Nov 2020 12:43:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606477423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqo5a8zJNZ3BIlEsKlT5BD1+dtJbL8alCfUjrLbrgVg=;
        b=Way3YzABw6WAqI8nv1sA8Q2AgTVtUcX80gD2pQr0KaL9USatnnuzxyNLcCQH3ESW6su2H0
        vrcbT/YBQoLHoLtH7ZH4o/LVSg77God5hXWn4oZTeKYLqyps1AMhYxalyEl74EpcAGlvqJ
        3oiA1ovSMrrrXI3jjHW000wDr41/ith5quRyG3FfNwOhRYtq/sA8WHeAvP88myasPn4hT5
        qPqWESTNnM4qg4X82f4wXvsFXBYhTjctHSiPWZXcmFkninsDs4Rkg74If1M4ij42Rl04fW
        VeHU+HBYhcgGsb6xVvh0lxrP1yqoucWKvQDY6g4E+5AtAyhT1p9QkiKlz9Yprg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606477423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqo5a8zJNZ3BIlEsKlT5BD1+dtJbL8alCfUjrLbrgVg=;
        b=KDWBDzhrlLmcQcojYIUkp4aWxCXPQbTDWvgH3vbeKZV8ipS/aqliYvW9SQoVQj26Lu06IR
        dMGYajD5eOYoc7Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zanxiong Qiu <zqiu2000@126.com>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, lcapitulino@redhat.com
Subject: Re: [PATCH RT] mm/swap: use local lock in deactivate_page()
Message-ID: <20201127114341.z6dp3nzg35eh3kek@linutronix.de>
References: <20201125142858.2559-1-zqiu2000@126.com>
 <20201126163552.ago5fpy3opi5nb7p@linutronix.de>
 <915f8627-0976-1bd5-1453-bbeee788a89b@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915f8627-0976-1bd5-1453-bbeee788a89b@126.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-27 19:31:47 [+0800], Zanxiong Qiu wrote:
> My bad, will correct the commit msg and resend, thanks.

Okay, thanks. Please also omit the stack trace from the commit message
as it does not add any additional value. The error is quite obvious if
you look at it.

Sebastian
