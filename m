Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA6C4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D622173E
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 19:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgD0TG3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0TG3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 15:06:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0017B21707;
        Mon, 27 Apr 2020 19:06:27 +0000 (UTC)
Date:   Mon, 27 Apr 2020 15:06:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
Message-ID: <20200427150626.4f217c82@gandalf.local.home>
In-Reply-To: <ac4168c7-68d6-e558-644e-e0daceea1f61@prevas.dk>
References: <20200123203930.646725253@goodmis.org>
        <20200123203943.749508731@goodmis.org>
        <ac4168c7-68d6-e558-644e-e0daceea1f61@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 27 Apr 2020 15:10:00 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> However, building with their rescue initrd and booting that, the board
> would consistently hang during reboot. Sometimes I would get lines like
> 
> [   72.956630] sched: RT throttling activated
> [   72.973769] lanx: port 1(lan1) entered disabled state
> [   73.000401] lanx: port 2(lan2) entered disabled state
> [   73.974951] lanx: port 3(lan3) entered disabled state
> [   73.997473] lanx: port 4(lan4) entered disabled state
> [   74.968006] lanx: port 5(lan5) entered disabled state
> 
> other times there would be no output, but the board was still hanging.
> Reverting
> 
> b1a471ec4df1 - hrtimer: Prevent using hrtimer_grab_expiry_lock() on
> migration_base
> 40aae5708e7a - hrtimer: Add a missing bracket and hide `migration_base'
> on !SMP
> 
> on top of v4.19.94-rt39 makes that problem go away, i.e. the board
> reboots as expected.
> 
> The board is a 32 bit powerpc (mpc8309) !SMP. Any ideas what I can do to
> debug this further?

Thanks Rasmus for looking into this. Tom now maintains 4.19-rt.

Tom, care to pull in these patches on top of 4.19-rt?

-- Steve
