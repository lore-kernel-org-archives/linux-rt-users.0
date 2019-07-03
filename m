Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883BC0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 09:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DB221882
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 09:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfGCJbN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:31:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51276 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCJbN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 05:31:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hibbb-0008LC-9w; Wed, 03 Jul 2019 11:31:11 +0200
Date:   Wed, 3 Jul 2019 11:31:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arve Barsnes <arve.barsnes@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
Message-ID: <20190703093111.nlyws5z5xndtncyf@linutronix.de>
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
 <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
 <20190628103435.0d95ebe8@archlinux>
 <CAJjrzcUBU5PPSzwXwm6wD8vT_mAakE-mepN1+CQuCoPNMWwgzw@mail.gmail.com>
 <20190628115739.7fec552c@archlinux>
 <CAJjrzcWdSxHoHFP1THs4_jbFGAOCfds73W0fjFkNFib97TAQ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJjrzcWdSxHoHFP1THs4_jbFGAOCfds73W0fjFkNFib97TAQ6g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-28 12:28:44 [+0200], Arve Barsnes wrote:
> But before I removed my -rt14 config I did a diff between it and the
> -rt13 config, and they were identical, so at least the config is not
> the cause of my boot trouble. I might have done something otherwise
> wrong though, I will try to redo the upgrade from the beginning after
> the weekend.

my fault, a patched I picked for rt14 is causing it. There will be a
-rt15 later today.

Sebastian
