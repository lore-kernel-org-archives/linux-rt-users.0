Return-Path: <SRS0=pHqT=DV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B53C433E7
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Oct 2020 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0CC20848
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Oct 2020 10:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxFOjm+J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rx6txo4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgJNKWE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgJNKWE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Oct 2020 06:22:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6BC061755;
        Wed, 14 Oct 2020 03:22:04 -0700 (PDT)
Date:   Wed, 14 Oct 2020 12:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602670922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTWBxJwPEISrTHTHNBPHIXp94hVnuH4jni5SQ1fMw50=;
        b=SxFOjm+J4/8CQgziXzF0CQ+PQOjjtYOPXrt299g0EBaNibsRgb9nytDf5LahAHnYm5k+wA
        vT+9IZn46WlxFlHzzgiwB+PYfQ5QcFu7P819BBI5GLacjDrLVdTcg/17CMOHOir85Ld0xT
        CxC0+VenAlm6dU7WddRCQ/T8b8QLrLdutZdA06ttlYmS4L+uTzliSXB2QS21Ue6hgSMWKB
        vt4Ve63Tt8R5YAn4HxlnAj061QuNcoUm2hqtMZ2qQXTSs+LtxQ2WiYGK5plfrDhealWqOs
        oHOd6wYk4oHDq+YIygHsc3DRcMQ521HvJZccFmf11vjus6pMTzhqPhRGtC3bHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602670922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTWBxJwPEISrTHTHNBPHIXp94hVnuH4jni5SQ1fMw50=;
        b=Rx6txo4eJAOVBXGQsYFd3e/MD5QLZYEfKSHL6FjabP5Ft2sfn5+efeR57zXCQA0YH9fknt
        OuS7UMZ1n7ChsbCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
Message-ID: <20201014102201.w4zpjby6seh6skcf@linutronix.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
 <20201012164553.kkk7aaeyb3y4wvyh@linutronix.de>
 <90459a197f5dad3b17ff8c484cc315c9b054f5c0.camel@gmx.de>
 <eb7ebf5a02208c0d2880e304f34ee1f25983ce97.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb7ebf5a02208c0d2880e304f34ee1f25983ce97.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-13 05:00:18 [+0200], Mike Galbraith wrote:
> Well, I do have a gripe from 5.6-rt, which I just took a moment to
> confirm in virgin source, but that kernel is probably EOL.

Yes. But I you patch for v5.9 so this should also work on v5.6.

Sebastian
