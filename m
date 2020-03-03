Return-Path: <SRS0=KoKX=4U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C41C3F2D8
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DADD20870
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgCCVyf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgCCVyf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Mar 2020 16:54:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1520120848;
        Tue,  3 Mar 2020 21:54:34 +0000 (UTC)
Date:   Tue, 3 Mar 2020 16:54:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 21/23] sched: migrate_enable: Busy loop until the
 migration request is completed
Message-ID: <20200303165432.773941e0@gandalf.local.home>
In-Reply-To: <f783406c0254a3b36ab1123402a7b2f26f6d5699.camel@redhat.com>
References: <cover.1582814004.git.zanussi@kernel.org>
        <fd4bda7ad49f46545a03424fd1327dff8a8b8171.1582814004.git.zanussi@kernel.org>
        <f9e97d7214906f7b34aa587b868071a6f673c69a.camel@redhat.com>
        <1583267977.12738.53.camel@kernel.org>
        <f783406c0254a3b36ab1123402a7b2f26f6d5699.camel@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 03 Mar 2020 15:19:23 -0600
Scott Wood <swood@redhat.com> wrote:

> > Thanks for making sure it wasn't missed in any case.  
> 
> Steven, any plans to merge that patch into 4.19-rt?
> 
> In the meantime, I guess it's a question of whether the bug fixed by patch
> 18/23 is worse than the (probably quite hard to hit) deadlock addressed by
> 2dcd94b443c5dcbc.

Yes, I plan on doing my backports thursday and friday.

-- Steve
