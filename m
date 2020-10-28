Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B6C388F7
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 00:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6079420791
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 00:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQ7KKjaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubOqM/XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgJ2AfR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbgJ1WT0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F120C0613CF;
        Wed, 28 Oct 2020 15:19:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 21:24:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603916642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6YhIGdNQ5rBLEhRQpo5JZ6jxzEoNLg4mGh4uT8QOFo=;
        b=bQ7KKjaKvTATCslxvYVv738SVtO0oSRAdN/5+ofh1b95Bit5y2BuTMzrockvrVwBsgcLXs
        T2hnGbZ7s/f7QioFkG+gEDFQaSm47PQm/LRhp94xZewPmxLXFCWtZrwknGTY4LYAP3fUAp
        1GPXz2RoQ0Tdn87BIZ9egkUym7qmrfzrm4KKXAmyxz/ugypL7Bp4QDmGcz3h1drnOOm7kY
        Sdr49uPMZEt2vfNB/9PAvYbXaYYBWCS5MC6Mei6wGNQZClphOnoqSubPaquYVbj/kUdPuX
        u/pJzA04mmMIiVevIFPwRZ4NgFASN7UKdPRIDV3QlVHpLntE3vAOng6WZmE3BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603916642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6YhIGdNQ5rBLEhRQpo5JZ6jxzEoNLg4mGh4uT8QOFo=;
        b=ubOqM/XL54xJnO8hZY4Co3MX0qmXw4b5+LhRzq9oA7HHpB+LgLm/82o+ARe5DYWmJG6Nqd
        36ar7YW81FAJaGBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
Message-ID: <20201028202401.jqksp2ycpbinsmzc@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <20201021131449.qlwjiq2l6embaii3@linutronix.de>
 <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
 <20201027082247.rs2h7l3wdzxc5f7i@linutronix.de>
 <bef33500-43b1-5895-2511-e39d8f1da1d0@ccrma.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bef33500-43b1-5895-2511-e39d8f1da1d0@ccrma.stanford.edu>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-27 10:07:35 [-0700], Fernando Lopez-Lezcano wrote:
> The compilation process went ahead (not finished yet), let me know if there
> is a proper patch. No hurry...

I just released -rt20 and it compiles now. I looked at the code and I
wouldn't recommend to use it unless you know exactly what you do.

> Thanks!
> -- Fernando

Sebastian
