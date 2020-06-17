Return-Path: <SRS0=83CY=76=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6526C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 07:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D8A21501
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jun 2020 07:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFQHmZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHmY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jun 2020 03:42:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C3C061573
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jun 2020 00:42:24 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlSiF-0003oD-3x; Wed, 17 Jun 2020 09:42:23 +0200
Date:   Wed, 17 Jun 2020 09:42:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200617074223.wtd5lsxbpvqvbxs7@linutronix.de>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
 <20200616165536.GA306273@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616165536.GA306273@fuller.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-16 13:55:36 [-0300], Marcelo Tosatti wrote:
> > We had this
> >   https://lore.kernel.org/linux-mm/20190424111208.24459-1-bigeasy@linutronix.de/
> 
> Will reply to that thread. Do you want to refresh/resend that patchset or
> should I?

I don't plan to refresh/resend it because what we have now with local-locks
in v5.8-rc1 works for RT.
I dropped that from RT in v5.4.26-rt17 so the previous release should have
the last version of this. Please be aware that Joe Korty reported that
this patch somehow breaks a workload for him. The report never made it
to the list but he confirmed in
   https://lkml.kernel.org/r/20200330154110.GA2975@zipoli.concurrent-rt.com

that is problem is gone with the removal of the patch.

Sebastian
