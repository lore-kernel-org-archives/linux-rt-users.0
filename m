Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9AC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 17:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5405B64E04
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Jan 2021 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhA2RFM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhA2RE5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05001C06174A
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Jan 2021 09:04:17 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:04:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611939855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGnKt1blMBo1w/KvEX+f7ff+JRpZpJsPM2mWDu64NPQ=;
        b=aqbaPQHzcbtWMMcrh9Wfvj87Uu7O7iVcZs/pn1qvhBirhcGO8mw9qflRoBZzoyCiuuHHYL
        UTwsVqe40CzXfpohEPdEW/ne6aOaP0UMqvhWjBlqOTtjUUjf88hI7OQcM3H0htTc6Ld7WL
        pNS+oH95Jra3oniktDBJF9iRmE5bqnpNuSH4u/dHOj34AXAfmbPLHl0cA3iDjptDWy7b5E
        6FQMXDr2XAieUmno1/mL2hRPzP18gWvqC6EMG42B77wWH+uK3ptDItd1Vxpf85Vf0zyi7X
        dZo3t8cEMgYiIiEeO7ZkC14VjmpcsxSlZZhGbIbF5dDPC3krxsa8zgm9+HZ+8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611939855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGnKt1blMBo1w/KvEX+f7ff+JRpZpJsPM2mWDu64NPQ=;
        b=g4S0Kq2vq9X1wngzJV0aYXHopvOOLTgyX3SIJ5ALn3i9HqD2csAn/KtkH6nCQgb78aMQiu
        KMAWZl4g6x73dBBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210129170414.ugrlb6hpcnbiqqbf@linutronix.de>
References: <YAwPoaUZ1gTD5y+k@hmbx>
 <YBJZk9/77+E0TRk4@lx-t490>
 <YBMvmU+kp11f7+wF@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YBMvmU+kp11f7+wF@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-28 22:41:45 [+0100], David Runge wrote:
> kernel log for mainline:
> https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel.log
>=20
> kernel log for rt (no dice :-/):
> https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91.50.arch1-kernel.log

I don't see anything wrong. There is small difference in timing and then
the RT version does not do a thing while !RT keeps reseting=E2=80=A6
Could you try non-RT with the
	threadirqs

option?

Sebastian
