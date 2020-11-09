Return-Path: <SRS0=BKJB=EP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC345C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38A20702
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcWgCPoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgKII7e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgKII7d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 03:59:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD1C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2020 00:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vgGuUlMg4ZeYUt12ZcM6mFxATfgw8kKm2lFsPy69JCY=; b=BcWgCPoW33MY5M3ijMubZLuP2+
        097JkvO6Op0Yc6X9/YNJ+La5LACPfEwCxvxfUM+X4pNzFX6i6LQU/x332JHzqXYmZGpCjNCqX3UQm
        /4TIqhD2wMw87cUHw2s3+6JGFPZhFM2N3poF3ugsF2FcKoeOpVt5AjNnt6SUU0G/V/cIcrI529Ljy
        3YzxHxWRLPTqCjuRm0SSD1TYlnKtWOBw3cKFVEfJdlJhQX3E1T3vucWP9Ebu8Rwn57Isipn7X+FnT
        uG3WAxHFS+j5AD0XR6DoS7zlDvZYLMOFZxTrTc0irU0UkItHa2GoFD4XaVf3WwS8xsmx3dBLgH+fC
        wQyWTOmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc31P-0004uH-GX; Mon, 09 Nov 2020 08:59:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26EAF305C16;
        Mon,  9 Nov 2020 09:59:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08A682C356CA3; Mon,  9 Nov 2020 09:59:31 +0100 (CET)
Date:   Mon, 9 Nov 2020 09:59:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [5.9.1-rt20] affine_move_task does not always release rq lock
Message-ID: <20201109085930.GB2594@hirez.programming.kicks-ass.net>
References: <20201106203921.GA48461@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106203921.GA48461@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 06, 2020 at 03:39:21PM -0500, Joe Korty wrote:
> FYI. There is one path through affine_move_task() which
> does not release the rq lock.  This appears to be in error.
> 
> 	 * Either way, we really should have a @pending here.
> 	 */
> 	if (WARN_ON_ONCE(!pending))
> 		return -EINVAL;

Indeed so. I'm assuming you didn't actually hit the warning but found
this through inspection?

Anyway, let me go ammend this. Thanks!
