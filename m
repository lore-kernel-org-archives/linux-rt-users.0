Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DDFC388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 11:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE842225F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 11:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP+twfJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7XJWuQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462786AbgJWLIs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 07:08:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462703AbgJWLIr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 07:08:47 -0400
Date:   Fri, 23 Oct 2020 13:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603451325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PAuxEhB/nJhk5VPc65JV893RicI0kuvbtn6fWhCVzIc=;
        b=QP+twfJLJ/w0D9rCRchyrX5YD/83Bv62jT32mgbFl0imPquXx13nZggCeRuC1e2pbJ97IS
        9CBTpRqC/UsLXbwRCdgaXRxMzA/khAa9xUCs8fsoEOQp/7J7cKwExGsFWwFF7pBRYgt+mD
        JepZySf39/XoBncGt1hN33Z70SpYkHooUUc43bC2BV9sKfgNkevOUB793vaakT3nMIu43y
        jtbe9csxfM9KBOK17F8MgU+M7QCH5ZX/JEYZzbTNpifFSvaDAQ5AuctziZNiejKqh3YNav
        hTLkOIzoVMdW1tiFtB9bEibLk9PV6wuKEA/DA21vEtZuqHAnLlDl2ZYX6G13UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603451325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PAuxEhB/nJhk5VPc65JV893RicI0kuvbtn6fWhCVzIc=;
        b=M7XJWuQjtTyl1Np9xOBVKtEBC3SvZyVe35H3XvNw7zgxptNAY3dKJYV878OC0Rvk5tAD3G
        vABVz3G9iUBxFhBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: printk: add pr_flush()
Message-ID: <20201023110844.i44l2xa4qdhhdtoj@linutronix.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
 <20201022141529.zvwafoqglnhyklj5@linutronix.de>
 <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de>
 <c2965ef22b5e95db0d9e214efb6f653628549579.camel@gmx.de>
 <20201022145214.a5sm66naswycezae@linutronix.de>
 <877drhmmma.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877drhmmma.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-23 09:29:41 [+0206], John Ogness wrote:
> Hi Sebastian,
Hi,

> The "printk: add pr_flush()" patch should be removed from PREEMPT_RT
> until this issue is resolved. I am getting several independent bug
> reports of reboot problems.
> 
> Note that on crash situations the full ringbuffer should still be
> printed. pr_flush() was only responsible for non-crash scenarios.

oki, dropping.

> John Ogness

Sebastian
