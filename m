Return-Path: <SRS0=USbd=57=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD991C2BA19
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A864220767
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFIONclS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636167AbgDONhf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636147AbgDONhK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Apr 2020 09:37:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D132FC061A0C;
        Wed, 15 Apr 2020 06:37:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so11255762wmh.3;
        Wed, 15 Apr 2020 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pa4UHfY2/aSNPt2X2jGFb1KTFp1Ae6IbH0975jzZgos=;
        b=UFIONclS26VhRCUUT3L94esG6sHKSSxeu0B0RIPlexIIFi4hqm3TyDtiDUGKLcKRbC
         WRTJ74OJ+Kx5NXQrtvbclxCbBNeOJKHUVERX0v1ph7DY69qjNzxN05cd1aa3+SORd1zN
         yM6HvbOsjEZid7wEVE43d+wA+hMLntwAMPV33PdSm4j4VVQ6A4i0gtjvDwv7sZEAZLla
         unNO3Ge77+31zTDTDZTY24Y0h5GOxTt5GARtJuGZyc/tV1g3CmznSFZxNna1aHgaVyb1
         87XooU9yiDhS5J+WJFUqFU4/3Wpnr0LhDaLGH4SDzMfXJwjC2xHPByJpQ9K0Axr08OTz
         RzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pa4UHfY2/aSNPt2X2jGFb1KTFp1Ae6IbH0975jzZgos=;
        b=sgN0DysRkiTQqd8+HfoYKbGwsplkiBfOfQgc3wT7Vbv08gSaO7fVePYf++5ismWC58
         bP7lH2nWMtZ0XJWm8F05crRAbqGcTUUrVssQvkviR4uU3r+nVdqvUXbsSZa71+prXc1s
         O4hg1cjgpIiBIPJfZCJChV98I1GxqtM1mnAgFbuMFy/o1QVCkJB6zLRhfpH3ZrrnbCMI
         NAsmbWw1A0Ak+Q3vflrHklPzRUc7i4aXajuQiN5wmWvPngqm4GBdCYR7kAzVMsmmGSec
         Bw+YMh7JFgsH56FnAyUjGUOomdRZePbWZ6/oaIVY84okoESfiV3EZtjKWCoM5WHQqUno
         OpOQ==
X-Gm-Message-State: AGi0Puay5GPS4VLjex/6CHkys8TLxXZ5q0724onE+we23kUiPo/lHwKp
        w9mczcm630vcT9aaoodxCMH5Icq/IMs=
X-Google-Smtp-Source: APiQypLNk8T6f4p+TzUVzRkkQMgmXTc/G+NMBWXmDW1uDgwgfwaRQv3mDBfAx4pQl3KDMPLaQokoSw==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr5230330wmc.161.1586957828498;
        Wed, 15 Apr 2020 06:37:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id l5sm9843280wmi.22.2020.04.15.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:37:06 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:37:04 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.2-rt1
Message-ID: <20200415133704.GG9767@localhost.localdomain>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
 <20200408070013.GB14300@localhost.localdomain>
 <20200415111235.6gomftgifn62dylp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415111235.6gomftgifn62dylp@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 15/04/20 13:12, Sebastian Andrzej Siewior wrote:
> On 2020-04-08 09:00:13 [+0200], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > On 03/04/20 19:04, Sebastian Andrzej Siewior wrote:
> > > Dear RT folks!
> > > 
> > > I'm pleased to announce the v5.6.2-rt1 patch set. 
> > > 
> > > Changes since v5.4.28-rt19:
> > > 
> > >   - Rebase to v5.6.2
> > 
> > I was reviewing the new set and I couldn't find v5.4.28-rt19
> > 6dbbc833c99f ("mm: perform lru_add_drain_all() remotely"). Don't think
> > it has been squashed either.
> > 
> > Am I wrong? If not, why was that left out?
> 
> I was going to drop it from v5.4 but kept it last minute. I announced in
> 	https://lkml.kernel.org/r/20200309171350.kjb3pdjazhxm2li2@linutronix.de
> 
> that the problem it fixes is not limited to RT so we need a solution for
> both config switches. The current plan for local-locks is not to work
> cross CPU because it breaks the local_irq_save() / preempt_disable()
> replacement which is something this patch relies on.
> The worker triggered via vmstat_update() is also blocked if the user
> task runs at an elevated priority for longer time.

OK. Thanks for clarifying.

Best,

Juri
