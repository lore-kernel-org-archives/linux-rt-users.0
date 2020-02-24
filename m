Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1228C11D2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CB520838
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 16:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgBXQR0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgBXQR0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 11:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEFA20714;
        Mon, 24 Feb 2020 16:17:25 +0000 (UTC)
Date:   Mon, 24 Feb 2020 11:17:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     zanussi@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 19/25] userfaultfd: Use a seqlock instead of seqcount
Message-ID: <20200224111723.415a940d@gandalf.local.home>
In-Reply-To: <20200224090317.shfeuxfukkvxvqaf@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
        <889f5b989b28eb7b29f21092432948cd12d97c48.1582320278.git.zanussi@kernel.org>
        <20200224090317.shfeuxfukkvxvqaf@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 24 Feb 2020 10:03:17 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-02-21 15:24:47 [-0600], zanussi@kernel.org wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > v4.14.170-rt75-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> This is required but it is not part of the next "higher" tree
> (v4.19-RT). Which means if someone moves from v4.14-RT to the next tree
> (v4.19-RT in this case) that someone would have the bug again.
> 
> Could you please wait with such patches or did the I miss the v4.19-RT
> tree with this change?
> 

No, I'm just behind in backporting patches.

We need to work on synchronizing better what gets backported. :-/

-- Steve
