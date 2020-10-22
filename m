Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C933C388F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061832225F
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/A+a1g4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTdy7tkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900748AbgJVOPf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900747AbgJVOPd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 10:15:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C83C0613CE
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2020 07:15:33 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:15:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603376130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6doKj0yGuDti1k5HrTkK6ArefmkJ4rKmzlo8s2zk3I=;
        b=q/A+a1g4fh5bOTXImqQrDEmH6FyubFABn6CqRzy6H3Gzf7sMNhNx2giIeMmJCi9jwPCYzW
        liLjZ5AnA3PjY2bPji196QeGmKAIZnYdXxRRylUTvituz3vqEJvo4Ghb+jnIC/SeeRpor0
        +UnVefyPY5P/IV7djaduJqvn6i5y72j7iGWhm1YSYkpdnJJMjuDzffhPd5uyAWcBuHUbwT
        /9bEi2PFTVf28PGmMGtuzsDCea7wC1lmBml7sM9PlNXumX7h2ixqsTgbMf6sju412ZKZBi
        XlopVEMVQf4FSTzLz/fw2TP2fRbXE9L25KnXngGPPV1iFs94e4eT4v3G+9Ucug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603376130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6doKj0yGuDti1k5HrTkK6ArefmkJ4rKmzlo8s2zk3I=;
        b=YTdy7tkC002kojXUg4jTXVai4piPgANSwsfHy5Smp9NnAHIDQ0GbWg3yDi28rG5D/mdLVE
        1A061QzjkrCfoAAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: printk: add pr_flush()
Message-ID: <20201022141529.zvwafoqglnhyklj5@linutronix.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-22 16:12:41 [+0200], Mike Galbraith wrote:
> Greetings,
> 
> Seems this patch can cause hangs.  I can reliably reproduce one such
> hang by poking sysrq-b, and it goes away if I revert that.

does it still happen if the wait argument is `false'?

> 	-Mike

Sebastian
