Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CCCC63697
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7466B222E8
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 18:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgKPSCh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbgKPSCg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 13:02:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FEC222E8;
        Mon, 16 Nov 2020 18:02:36 +0000 (UTC)
Date:   Mon, 16 Nov 2020 13:02:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tom Zanussi <tzanussi@gmail.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT v2] net: Add missing seqcount_release() to
 qdisc_run_end()
Message-ID: <20201116130234.7e889b04@gandalf.local.home>
In-Reply-To: <20201116172221.25ymeo62tgmzwe4z@linutronix.de>
References: <edf053cb3e36a3640cff920d74f582415896373d.camel@gmail.com>
        <20201116172221.25ymeo62tgmzwe4z@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 16 Nov 2020 18:22:21 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > This was tested on 5.14 but applies cleanly to rt-devel as well.  
> 
> as just explained in the other thread, I would recommend to simply drop
> that backported patch instead. There should be no splat in the devel
> tree.

I'll do that. Thanks!

-- Steve
