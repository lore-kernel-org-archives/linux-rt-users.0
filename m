Return-Path: <SRS0=MBx+=6E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7777DC3815B
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C23C20857
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Apr 2020 13:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDTNjY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbgDTNjY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Apr 2020 09:39:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBDC061A0C
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Apr 2020 06:39:24 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jQWdu-0005jj-EL; Mon, 20 Apr 2020 15:39:22 +0200
Date:   Mon, 20 Apr 2020 15:39:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: v5.6.4-rt3 on arm64
Message-ID: <20200420133922.asskoaavxfg6dysf@linutronix.de>
References: <CAD56B7fTCFwAwENEGHDJXADwjzXxcB=aQGAa5KZJMNCtNYHHCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7fTCFwAwENEGHDJXADwjzXxcB=aQGAa5KZJMNCtNYHHCQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-17 19:40:31 [-0400], Paul Thomas wrote:
> Folks,
> 
> I finally got our Fuego test system turned back on, and I'm happy to
> report good cyclictest latencies with 5.6.4-rt3 on arm64 (Zynq
> Ultrascale+). 13us with a shielded 1 hour test.
> 
> I'll try and keep this on and report anything unusual that I see.

Thank you for the feedback.

> Nice work everyone!
> 
> -Paul

Sebastian
