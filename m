Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102ECC2BB48
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE15207B6
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 14:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgLNOZu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440159AbgLNOXP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 09:23:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF8522B4B;
        Mon, 14 Dec 2020 14:22:34 +0000 (UTC)
Date:   Mon, 14 Dec 2020 09:22:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [ANNOUNCE] 5.4.82-rt45
Message-ID: <20201214092232.0cb558d7@gandalf.local.home>
In-Reply-To: <20201211192600.raig3v4mbj526dkx@beryllium.lan>
References: <20201211142236.1884a443@gandalf.local.home>
        <20201211192600.raig3v4mbj526dkx@beryllium.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 11 Dec 2020 20:26:00 +0100
Daniel Wagner <wagi@monom.org> wrote:

> On Fri, Dec 11, 2020 at 02:22:36PM -0500, Steven Rostedt wrote:
> > I'm pleased to announce the 5.4.82-rt45 stable release.
> > 
> > [ Note: There's a known issue that still needs to be fixed:
> >   https://lore.kernel.org/r/20201116172221.25ymeo62tgmzwe4z@linutronix.de
> >   Will be fixing this next (and seeing if there's anything else needing
> >   to be backported. ]  
> 
> what about
> 
>    https://lore.kernel.org/linux-rt-users/20201127135456.8145-1-zqiu2000@126.com/
> 
> ?

Crap, I forgot about that.

-- Steve
