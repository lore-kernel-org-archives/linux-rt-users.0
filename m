Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020BBC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E2D20823
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 18:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfC1Sew (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:34:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1Sew (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 14:34:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9ZrW-0008DQ-4J; Thu, 28 Mar 2019 19:34:50 +0100
Date:   Thu, 28 Mar 2019 19:34:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Budiman JoJo <budimanjojo@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [BUG] /sys/firmware/efi/efivars: unknown filesystem type
 'efivars'
Message-ID: <20190328183449.l2n52mk3uio4vgbr@linutronix.de>
References: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
 <20190328083224.2ilcupnxfsal4274@linutronix.de>
 <CACvxoyqPQwK0HSLt=y47LyqQbzk3G8VSbVhKqmn+s0fSiEoxTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACvxoyqPQwK0HSLt=y47LyqQbzk3G8VSbVhKqmn+s0fSiEoxTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

please don't drop the list

On 2019-03-29 01:26:12 [+0700], Budiman JoJo wrote:
> On Thu, Mar 28, 2019, 3:32 PM Sebastian Andrzej Siewior <
> bigeasy@linutronix.de> wrote:
> > Does it work if you add
> >         efi=runtime
> >
> > to the commandline?
> 
> It works now. Thanks! :)
> So this should stay in the bootloader boot options is this something can be
> done in the kernel? Because we don't have that message on the normal
> kernel.

It is off by default by default because accessing EFI routines may
increase the latency of the system. This is the case for instance if the
system is accessing the RTC via EFI oder writing variables. You could
drop
	efi-Disable-runtime-services-on-RT.patch
there is currently no other way.

Sebastian
