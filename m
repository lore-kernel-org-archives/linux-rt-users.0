Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63449C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BBB22B4B
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 19:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgGNTnz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgGNTnz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jul 2020 15:43:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337C022B4D;
        Tue, 14 Jul 2020 19:43:54 +0000 (UTC)
Date:   Tue, 14 Jul 2020 15:43:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
Message-ID: <20200714154352.04794760@oasis.local.home>
In-Reply-To: <20200714183512.GA18816@duo.ucw.cz>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
        <20200714183512.GA18816@duo.ucw.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 14 Jul 2020 20:35:12 +0200
Pavel Machek <pavel@denx.de> wrote:

> Hi!
> 
> > 
> > I'm pleased to announce the 4.19.132-rt59 stable release.
> > 
> > This release is just an update to the new stable 4.19.132
> > version and no RT specific changes have been made.
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > 
> >   branch: v4.19-rt
> >   Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe
> > 
> > Or to build 4.19.132-rt59 directly, the following patches should be
> > applied:  
> 
> Thanks a lot.
> 
> But now I am confused, I completely missed announcements for
> v4.19.127-rt55 to v4.19.131-rt58.
> 
> And for example -rt56 is not listed in
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/older/sha256sums.asc
> 
> ...aha, and the versions do not have signed tags, either:
> 
> pavel@amd:~/cip/k$ git show v4.19.131-rt58
> fatal: ambiguous argument 'v4.19.131-rt58': unknown revision or path not in the working tree.
> 
> Is that because they were created just as quick steps towards -rt59?
>

Ah, I was about to say this is something that Kate keeps reminding me
to add to the wiki, but looking, I already did!

https://wiki.linuxfoundation.org/realtime/documentation/start

"Tagging policy of the PREEMPT_RT stable releases. Each PREEMPT_RT
stable release is tagged with the version number of the upstream Linux
stable kernel as well as its own “-rt” counter that is appended. The
-rt counter will increment for the following:

 - When forward ported to the latest upstream Linux stable version.
 - When any merge with a upstream Linux stable causes a conflict.
 - When a backport of the PREEMPT_RT development branch is done.

A backport will not be done with a forward port of a stable version.
They will be done separately, and tagged separately."

Tom, I sign all tags, we probably should be consistent with that too.

-- Steve
