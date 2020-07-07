Return-Path: <SRS0=u1dD=AS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE403C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jul 2020 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B2D20675
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jul 2020 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ORQP0/la";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMkZV5Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGGRru (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRru (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jul 2020 13:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A70C061755
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Jul 2020 10:47:49 -0700 (PDT)
Date:   Tue, 7 Jul 2020 19:47:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594144067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+gEEzbyrGc5fk2Ns5g7x67o7bl5CODHoy3UPhFgOXk=;
        b=ORQP0/laOYCzbRCnkb06wOSwCON38Z1hT6/MHaWweaBB43GGjJortFE50qkRfALwNCNkOK
        FhzCfSx5BSRaV4AGLbYHNI847zNairAT34EAgHTvC0tL6chE5IlN4YkyHCeVkKmvSGNWsY
        P+F/S4DuURoExoUjnnPHYdG60V5z/GssaFvfgaUgid9Y/JTGqzEgXf9EBsjIWJsvc1RN3Q
        mli26iY2TkIgHMLbN04a9quPTO/NKyZbVz8+Wv6AFxALNMLOasslwlDS+cnjwvz6pAqMwu
        JQuwKSCZ3XYVxQB0B3LeqpPHD+JAT2yWk5tXKYc4sfkFawBuZkr53iR1CWijbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594144067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+gEEzbyrGc5fk2Ns5g7x67o7bl5CODHoy3UPhFgOXk=;
        b=aMkZV5Rt+SnglI2CusVQl4PKOrASkaJYZJcHDCJpPvoryhPjx+Nh4XLl3/RQEGcVyYTvLb
        IkzqXop3aL8b8sDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: 5.4.13-rt7 stall on CPU?
Message-ID: <20200707174746.qe5f6w5qju3vo3yr@linutronix.de>
References: <3ef1ba37-6b83-e12a-e493-9c45fa3bb3c1@xs4all.nl>
 <20200703194934.c5sdqwxwgzmgobtq@linutronix.de>
 <875822d3-6fcd-1ab0-4ede-ee5134e6211b@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875822d3-6fcd-1ab0-4ede-ee5134e6211b@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-07-04 05:43:32 [+0200], Udo van den Heuvel wrote:
> > I *think* this happened within the loop in __fget_files(). This function
> > is inlined by __fget_light() and the loop has a RCU-section so it would
> > make sense.
> > Do you run something at an elevated priority in the system? 
> 
> ntpd (ntpsec) elevates itself.

To the highest possible. Wonderful.

> > I don't know
> > what the other part was doing but somehow one of the file descriptors
> > (network sockets probably) was about to be closed while the other side
> > tried to poll() on it.
> 
> Thanks for explaining.

I'm puzzled. On dup() and otherwise on replacement / closing the file
pointer is replaced (with an incremented reference count or NULL ) and
then the reference count of the old file pointer is decremented. So the
zero count could be observed once and then the new pointer should be
seen. So it should not loop for seconds. And then, dup2() is only used
at startup.

> Kind regards,
> Udo

Sebastian
