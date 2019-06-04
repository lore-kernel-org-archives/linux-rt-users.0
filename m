Return-Path: <SRS0=a75S=UD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DDC282CE
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 13:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44F02485E
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFDNQO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfFDNQO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Jun 2019 09:16:14 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120BA2484F;
        Tue,  4 Jun 2019 13:16:11 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:16:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>, julia@ni.com
Subject: Re: KVM Arm Device passthrough and linux-rt
Message-ID: <20190604091607.2e87eb36@oasis.local.home>
In-Reply-To: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
References: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 4 Jun 2019 13:58:51 +0100
Julien Grall <julien.grall@arm.com> wrote:

> This is happening because vgic_v2_fold_lr_state() is expected
> to be called with interrupt disabled. However, some of the path
> (e.g eventfd) will take a spinlock.
> 
> The spinlock is from the waitqueue, so using a raw_spin_lock cannot
> even be considered.
> 
> Do you have any input on how this could be solved?

What's the reason that vgic_v2_fold_lr_state() expects interrupts to be
disabled?

-- Steve
