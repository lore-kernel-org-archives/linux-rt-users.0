Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2638C433B4
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 May 2021 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A426F6143B
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 May 2021 16:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhEMQoY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 May 2021 12:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhEMQoX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 May 2021 12:44:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FDA61438;
        Thu, 13 May 2021 16:43:11 +0000 (UTC)
Date:   Thu, 13 May 2021 12:43:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, stable-rt@vger.kernel.org
Subject: Re: [PATCH net-next] net: Treat __napi_schedule_irqoff() as
 __napi_schedule() on PREEMPT_RT
Message-ID: <20210513124310.1d8b33f0@gandalf.local.home>
In-Reply-To: <20210512205046.7eabe8fc@oasis.local.home>
References: <YJofplWBz8dT7xiw@localhost.localdomain>
        <20210512214324.hiaiw3e2tzmsygcz@linutronix.de>
        <87k0o360zx.ffs@nanos.tec.linutronix.de>
        <20210512205046.7eabe8fc@oasis.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 12 May 2021 20:50:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 13 May 2021 00:28:02 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > No matter which variant we end up with, this needs to go into all stable
> > RT kernels ASAP.  
> 
> Is this in rt-devel already?
> 
> I'll start pulling in whatever is in there.

I don't see this in the rt-devel tree. The stable-rt releases always pull
from there (following the stable vs mainline relationship).

Is there going to be a new rt-devel release?

-- Steve
