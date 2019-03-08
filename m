Return-Path: <SRS0=UNtE=RL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0346C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D15620851
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCHROa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:14:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33007 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCHROa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Mar 2019 12:14:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h2J4i-0000R3-Pf; Fri, 08 Mar 2019 18:14:24 +0100
Date:   Fri, 8 Mar 2019 18:14:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Message-ID: <20190308171424.ftuowj7g7z6sratb@linutronix.de>
References: <20190304172053.17340-1-julien.grall@arm.com>
 <20190307123823.fnzb7njqdib4xghk@flow>
 <c86522b3-cc38-1559-5011-22de1d08db99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c86522b3-cc38-1559-5011-22de1d08db99@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-07 18:14:46 [+0000], Julien Grall wrote:
> Hi Sebastian,
Hi,

> This description looks better. I will update the commit message. Do you mind
> if I had your signed-off-by as you provided the commit message?

Sure. However you might also want to "just" add something like
	[bigeasy@linutronix.de: commit description]

or something in plain English :)

> From my understanding, the stack frames across exceptions are chained. So
> the stacktrace will be able to unwind to the previous context.

Ah okay.

Sebastian
