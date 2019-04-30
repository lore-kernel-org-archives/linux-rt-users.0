Return-Path: <SRS0=4n46=TA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A353C43219
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6221707
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Apr 2019 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfD3PKr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:10:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfD3PKr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Apr 2019 11:10:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLUP7-0002sY-SX; Tue, 30 Apr 2019 17:10:45 +0200
Date:   Tue, 30 Apr 2019 17:10:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: remove mutex usage
Message-ID: <20190430151045.jfx3vlhqpgshlps7@linutronix.de>
References: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
 <87pnpb79nv.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnpb79nv.fsf@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-24 16:36:04 [+0200], John Ogness wrote:
> The kmsg dumper can be called from any context, but the dumping
> helpers were using a mutex to synchronize the iterator against
> concurrent dumps.
> 
> Rather than trying to synchronize the iterator, use a local copy
> of the iterator during the dump. Then no synchronization is
> required.
> 
> Reported-by: Scott Wood <swood@redhat.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Applied.

Sebastian
