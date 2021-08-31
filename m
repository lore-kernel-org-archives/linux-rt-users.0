Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8AC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 07:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A55F60FED
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 07:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhHaHPg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbhHaHPf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 03:15:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E70C061575
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Aug 2021 00:14:40 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:14:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630394078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kP5o+OHpkgwuI/Wr/6MvboU6AcVM5cTadUSuHQpGdFc=;
        b=h7pnTBtNTnAhJ359xH3912KPrOIjjaepqI22iUuEy64xBK2bpDPZWUwZ5fYpIyzcLVxvNJ
        iMn1RW4XFTn7smf/pl0bOXnIAiPOjYIY/w0XkEDVKhAs3nXaV/QbDlV9ucMHpnQ+G+8sg/
        DzgBYpiejgnSKXQ+6ZXznYIXRMC1WOnRJBpeADmsDovr2bakJCRSBHRPrDs2qu2NlMA1V0
        Ei3mbYh2TPHg/pLTsDVKztNYj3ySvlj5XbbBaq8+h1ci06bfEfNKOt5A7lGKlmYBaVUhMw
        9iPvwpZLSxKoyNvXlXvVrf7R0l6CgR31XL0fXLU3N5aAhsBNrTAC8zZZdOmL2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630394078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kP5o+OHpkgwuI/Wr/6MvboU6AcVM5cTadUSuHQpGdFc=;
        b=V7dqy1WkutjihKk6E+bb8wrFI7nbpw1p8bx91Wetck2u6ET9QbZNzZGk6Lxn42YxxjpDy1
        lH6zr45mZJE5IoCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [rteval] Fails to work without numactl
Message-ID: <20210831071436.w7ahd7twa52qcbvn@linutronix.de>
References: <20210816115809.bb4jtb56zkagqmq6@linutronix.de>
 <20210830195151.ym2svjnbekk7hvsg@linutronix.de>
 <67ce47c9-1631-bf20-8477-f6de91775062@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67ce47c9-1631-bf20-8477-f6de91775062@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-30 16:33:32 [-0400], John Kacur wrote:
> What distro are you running on Sebastian?
Debian but I didn't install it in anyway. I just run make of the git
checkout and this started it if I remember correctly.

> In rpm based distros numactl is a Requires, so that path where it is not 
> available is rarely tested - but that doesn't mean I won't take a patch or 
> try to fix it myself. I did have a quick look at it.

From the checkout there were complains about other libs but nothing
complained about numactl. Thanks.

> kcompile.py compiles an allmodconfig kernel. (not sure this is the best 
> thing to do still, but that's a different topic)
> 
> The requirements for that continues to grow. I have often seen rteval fail
> when requirements for building the kernel aren't installed on a machine.

okay.

> You can usually figure that out by looking at the debug logs in rteval, 
> but another simple thing to do is simply try an allmodconfig kernel 
> compile on your machine and when it fails figure out what 
> software is needed. It wouldn't be a bad thing to have a list of Debian 
> build requirements and Fedora build requirements, etc.

Okay.

> John

Sebastian
