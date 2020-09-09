Return-Path: <SRS0=FZAt=CS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748EC433E2
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B0B21919
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Sep 2020 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yGH9AJ1t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5YfzSV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIII7c (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:59:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60272 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgIII73 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Sep 2020 04:59:29 -0400
Date:   Wed, 9 Sep 2020 10:59:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599641967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTFH7A1qLhF9Q9Z2IReycvvbcaMRprJFGejHS6u86RU=;
        b=yGH9AJ1tqFBNaZ+9TYFZvM9/1VYbWLMgHrraLHCvLWIPM1y8M36X1ivl9CqdmxuVfUhcBQ
        XasT4wQz1e0LJ5Eqvi9NFk9kX3uFciFj47iHoUoNvbKcCYut7Qinc+TKDHEb3bEDkyvwLV
        cnV3cZWpHQeJEjvxZ38pS+f+bRW4nv+JFcDfEFHI79SwnfzClvRDMMcwHN1h2gBQ+HF3Wl
        mO2A/QjqtXjq5uK7LS/crh+APPFN/NKagvn1Wkh1gzq4W+2VF1y83ogq1pJho/vSb5LNyH
        0gvAS/mP6/e/n3u1eK6upCkwVGWPFTQtoBzFysMMHSFglUnf5Wiex7+A0M5+iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599641967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTFH7A1qLhF9Q9Z2IReycvvbcaMRprJFGejHS6u86RU=;
        b=o5YfzSV444sEZFxZBQkHS8B3mGD5PHh+PB70jV+gtrEqbMaCKDA2tIR8jezsGWFHzv3kRM
        y0GRxJ8kIG0muMBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc3-rt3
Message-ID: <20200909085925.dlakwg7kwdz7flj4@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <6ed14b9743f5ce400137a4ae5561604575e72b13.camel@gmx.de>
 <91828ea63ecd61d40bba0358e1c0efbe62976ba6.camel@gmx.de>
 <20200909082056.sw32jevyhdm4mzcm@linutronix.de>
 <327d42059a3d31bcb3439d5fae8b3c36019d8a68.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <327d42059a3d31bcb3439d5fae8b3c36019d8a68.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-09 10:56:41 [+0200], Mike Galbraith wrote:
> On Wed, 2020-09-09 at 10:20 +0200, Sebastian Andrzej Siewior wrote:
> >
> > Do you see the lockdep splat without nouveau?
> 
> Yeah.  Lappy uses i915, but lockdep also shuts itself off.

You sent the config, I will try to throw it later on kvm and actual
hardware and see what happens.

> BTW, methinks RT had nothing to do with the nouveau burp.

that is good to hear :)

> 	-Mike

Sebastian
