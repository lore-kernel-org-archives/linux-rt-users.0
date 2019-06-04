Return-Path: <SRS0=a75S=UD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4CC282CE
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824E923CEB
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFDNuw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:50:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFDNuw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hY9pw-0001pl-94; Tue, 04 Jun 2019 15:50:48 +0200
Date:   Tue, 4 Jun 2019 15:50:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, Marc Zyngier <marc.zyngier@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, julia@ni.com
Subject: Re: KVM Arm Device passthrough and linux-rt
Message-ID: <20190604135047.5bwclgkvvr642ucj@linutronix.de>
References: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-04 13:58:51 [+0100], Julien Grall wrote:
> Hi,
Hi,

> This is happening because vgic_v2_fold_lr_state() is expected
> to be called with interrupt disabled. However, some of the path
> (e.g eventfd) will take a spinlock.
> 
> The spinlock is from the waitqueue, so using a raw_spin_lock cannot
> even be considered.
> 
> Do you have any input on how this could be solved?

There is swair (init_swait_queue_head() and friends) in case that works
for you.

> Cheers,

Sebastian
