Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371FC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44E422CAE
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DoF+Otei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHGOPH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgHGOPG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 10:15:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FDBC061756;
        Fri,  7 Aug 2020 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EvxegMET6SRik4gYgGQR0Dd7+QyragdUTKLmQyo3dFM=; b=DoF+OteitJ9vvqCnXBKw3OAb8P
        3bq2zGoiXpaE7zG0noxQ1lFKOirqBEvU6lpONi1LYKxnP/+VctxgI/kHPF413T++0+DVvZaE3wPKw
        8c2vEQ7/fB3BtH0QTnCafRYrFU5t1leoItEIu9UZASqkwBEFM9xvlhBrHJb5xPex8uVpkF1M2tSIZ
        6BbUseldYrv+oOx23U+n7mWGT+5DXHvpJhoLMAKMI/ycmJT3T71zrd0BUq7sAK8l4S5f5I1yORyuJ
        zqwBleSJ2994bwqIZZbSSA/FtW48Rq2pXwrhAFJO2ydbJ0ovh4Aw0V8qKxItdrLVWKZWtoLw5+a0m
        eeKswkww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4396-0006E2-VR; Fri, 07 Aug 2020 14:14:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AF03304E03;
        Fri,  7 Aug 2020 16:14:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D16E21451925; Fri,  7 Aug 2020 16:14:55 +0200 (CEST)
Date:   Fri, 7 Aug 2020 16:14:55 +0200
From:   peterz@infradead.org
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200807141455.GM2674@hirez.programming.kicks-ass.net>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807151632.36dc6200@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807151632.36dc6200@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 07, 2020 at 03:16:32PM +0200, luca abeni wrote:

> If I understand well, the patchset does not apply deadline servers to
> FIFO and RR tasks, right? How does this patchset interact with RT
> throttling?

ideally it will replace it ;-)

But of course, there's the whole cgroup trainwreck waiting there :/
