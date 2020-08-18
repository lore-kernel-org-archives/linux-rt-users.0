Return-Path: <SRS0=5BY9=B4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC339C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB82020658
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597768965;
	bh=A/M1//51vJ+5FDo9VUL74sB+8+mhnfzFmte3hfxV1l8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=LqLvqd1E/AyB70+/kpSXG2NW/BLlazNjC8DS4Ih3GKFGzklF7Hc3SsA0QyDeOmkds
	 z9Yelu1KIwi7r2p+oI8cACQ9OYjBWR/dVWvkLyZrv5YbtD8O0EN3WAfipVh/ESOnu8
	 IuG2qHQYcqjvRi/yr2Oe/9yEhhBmI2laoWsvqrS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHRQmo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgHRQmn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Aug 2020 12:42:43 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30BB0207DA;
        Tue, 18 Aug 2020 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597768963;
        bh=A/M1//51vJ+5FDo9VUL74sB+8+mhnfzFmte3hfxV1l8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CVKhJXdr/huug3FKRrCCxZ5+Al90RHJvD8MRBywt576UkeH9RMIG4H2XUp0aExAhh
         0TBLpZSyEutbOUiwhYCbW5u/9OfaDTIJuuRPFGkGeH4ia9EYO8Qa5wtiY2bnB3O497
         5x/XBrSWVVy3H7PDtiUr+rfm0ivpbvnZVsm16oss=
Message-ID: <41f3d6a24c22d62f796ad02ff4c0553ae33710ca.camel@kernel.org>
Subject: Re: [PATCH -RT] net: xfrm: fix compress vs decompress serialization
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-rt-users@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Date:   Tue, 18 Aug 2020 11:42:41 -0500
In-Reply-To: <20200818160300.lgrect6qy2qdfave@linutronix.de>
References: <20200814173700.1532-1-dave@stgolabs.net>
         <20200817144754.5lyhn3xtenigvfbd@linutronix.de>
         <20200818154250.evbjaxzdyzh7oz7b@linux-p48b>
         <20200818160300.lgrect6qy2qdfave@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-08-18 at 18:03 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-08-18 08:42:50 [-0700], Davidlohr Bueso wrote:
> > On Mon, 17 Aug 2020, Sebastian Andrzej Siewior wrote:
> > > So what you are saying that this patch isn't needed v5.0.19-rt10+
> > > because local_bh_disable() acts there as a lock. Repost is then
> > > with Tom
> > > in Cc because he will be the first one to apply to the v4.19
> > > tree. And
> > > please shrink the patch description to a sane amount of
> > > information.
> > 
> > Sure, but which Tom are you refering to?
> 
> Tom Zanussi (Cc:). The v4.19 kernel is top most kernel which requires
> the change [0]. So it should start with Tom and drop down.
> 

Thanks, yeah, I'll apply this to the next update as soon as I can get
to it this week..

Tom

> [0] as per 
> https://wiki.linuxfoundation.org/realtime/preempt_rt_versions
> 
> > Thanks,
> > Davidlohr
> 
> Sebastian

