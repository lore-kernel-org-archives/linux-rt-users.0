Return-Path: <SRS0=aCPW=2H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCEC43603
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 08:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E872072D
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Dec 2019 08:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLQIOx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:14:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQIOw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Dec 2019 03:14:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ih80H-0000eO-Hv; Tue, 17 Dec 2019 09:14:49 +0100
Date:   Tue, 17 Dec 2019 09:14:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.21-rt15
Message-ID: <20191217081449.xsrfpma4frgynkmg@linutronix.de>
References: <20191216173416.2dcmfis4xza2dqf5@linutronix.de>
 <20191217044549.GB1363@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217044549.GB1363@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-16 20:45:49 [-0800], Richard Cochran wrote:
> On Mon, Dec 16, 2019 at 06:34:16PM +0100, Sebastian Andrzej Siewior wrote:
> > 
> >   - Since the migrate_disable() rework, with heave changing of the
> >     task's affinity mask the kernel could issue a warning in
> >     migrate_enable() and crash later.
> 
> What is "heave changing?"

Sorry. "heavy changing". You need to change the affinity mask of a task
very often and one requirement is that new affinity mask does not
contain a CPU on which the task is currently running.

> Just Curious,
> 
> Richard

Sebastian
