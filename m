Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467E1C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD3864EC3
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBVIZy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:25:54 -0500
Received: from mail.monom.org ([188.138.9.77]:41972 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhBVIZr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 03:25:47 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id EA1BB5005E8;
        Mon, 22 Feb 2021 09:25:03 +0100 (CET)
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id 8DF1E500369;
        Mon, 22 Feb 2021 09:25:03 +0100 (CET)
Date:   Mon, 22 Feb 2021 09:25:03 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 0/3] Revert always use libnuma patches
Message-ID: <20210222082503.b2u3s2ftv3os474f@beryllium.lan>
References: <20210219184801.13905-1-jkacur@redhat.com>
 <2188166.ElGaqSPkdT@n95hx1g2>
 <59d08654-a23c-a880-b78a-43c64b1fd16d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d08654-a23c-a880-b78a-43c64b1fd16d@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 04:30:39PM -0500, John Kacur wrote:
> I think I see the problem, the patch
> rt-numa: Move thread placement code to rt-numa library
> 
> added the fatal if numa_failed.

Sorry about the mess, I thought we can relay on libnuma. The concept to
depend on compile time on a library and not during runtime escaped my
attention.

> Thanks for testing. I'll send a patch to put it back the old way.

Thanks John!
