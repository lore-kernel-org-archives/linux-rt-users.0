Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593FC11D30
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6577320836
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgBXQFc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:05:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXQFc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 11:05:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j6GEb-000749-M3; Mon, 24 Feb 2020 17:05:29 +0100
Date:   Mon, 24 Feb 2020 17:05:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 15/25] sched: migrate_enable: Use select_fallback_rq()
Message-ID: <20200224160529.f5lg44gyk2mgayd4@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <eb183ce95bb3d92b426bdadf36f0648cda474379.1582320278.git.zanussi@kernel.org>
 <20200224094349.5x6dca4tggtmmbnq@linutronix.de>
 <1582558266.12738.32.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582558266.12738.32.camel@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-24 09:31:06 [-0600], Tom Zanussi wrote:
> On Mon, 2020-02-24 at 10:43 +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-02-21 15:24:43 [-0600], zanussi@kernel.org wrote:
> > > From: Scott Wood <swood@redhat.com>
> > > 
> > > v4.14.170-rt75-rc1 stable review patch.
> > > If anyone has any objections, please let me know.
> > 
> > This creates bug which is stuffed later via
> > 	sched: migrate_enable: Busy loop until the migration request is
> > completed
> > 
> > So if apply this, please take the bug fix, too. This is Stevens queue
> > for reference:
> > > [PATCH RT 22/30] sched: migrate_enable: Use select_fallback_rq()
> > 
> > ^^ bug introduced
> > 
> 
> Hmm, it seemed from the comment on the 4.19 series that it was '24/32
> sched: migrate_enable: Use stop_one_cpu_nowait()' that required 'sched:
> migrate_enable: Busy loop until the migration request is
> completed' as a bug fix.
> 
>   https://lore.kernel.org/linux-rt-users/20200122083130.kuu3yppckhyjrr4u@linutronix.de/#t
> 
> I didn't take the stop_one_cpu_nowait() one, so didn't take the busy
> loop one either.

Ach, it was the different WARN_ON() then. So this might not introduce
any bug then. *Might*. 
Steven backported the whole pile and you took just this one patch. The
whole set was tested in devel and uncovered a problem which was fixed
later. Taking only a part *may* expose other problems it *may* be fine.

Steven, any opinion on your side?

> Thanks,
> 
> Tom

Sebastian
