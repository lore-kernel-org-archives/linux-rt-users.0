Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8321C4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A7C24058
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgLKT1G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Dec 2020 14:27:06 -0500
Received: from mail.monom.org ([188.138.9.77]:47492 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgLKT0v (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Dec 2020 14:26:51 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id EC72650047A;
        Fri, 11 Dec 2020 20:26:01 +0100 (CET)
Received: from localhost (unknown [94.31.100.195])
        by mail.monom.org (Postfix) with ESMTPSA id CB1B25003F5;
        Fri, 11 Dec 2020 20:26:00 +0100 (CET)
Date:   Fri, 11 Dec 2020 20:26:00 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [ANNOUNCE] 5.4.82-rt45
Message-ID: <20201211192600.raig3v4mbj526dkx@beryllium.lan>
References: <20201211142236.1884a443@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211142236.1884a443@gandalf.local.home>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 11, 2020 at 02:22:36PM -0500, Steven Rostedt wrote:
> I'm pleased to announce the 5.4.82-rt45 stable release.
> 
> [ Note: There's a known issue that still needs to be fixed:
>   https://lore.kernel.org/r/20201116172221.25ymeo62tgmzwe4z@linutronix.de
>   Will be fixing this next (and seeing if there's anything else needing
>   to be backported. ]

what about

   https://lore.kernel.org/linux-rt-users/20201127135456.8145-1-zqiu2000@126.com/

?
