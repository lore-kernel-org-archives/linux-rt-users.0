Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B022C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9C720700
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfC1MAZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:00:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53002 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1MAZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 08:00:25 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9Thn-0003wX-3Y; Thu, 28 Mar 2019 13:00:23 +0100
Date:   Thu, 28 Mar 2019 13:00:23 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190328120022.bhwijbp2roizysiw@linutronix.de>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-28 12:30:30 [+0100], Bernhard Landauer wrote:
> @Ralf
> > does Manjaro use additional patches, maybe those used by linux-rt from
> > AUR?
> Our PKGBUILD can be seen here:
> https://gitlab.manjaro.org/packages/community/realtime-kernels/linux50-rt/raw/master/PKGBUILD
> 
> 
> As you can see we did not (yet) apply the nf-tables patch
> Apart from that Manjaro only uses the bootsplash patches and the same
> add-sysctl patch as the AUR
> 
> Our config can be found here:
> https://gitlab.manjaro.org/packages/community/realtime-kernels/linux50-rt/raw/master/config.rt

"You need to sign in or sign up before continuing."

> @Sebastian
> 
> > Is this only related to 5.0-RT or are also previous RT versions
> > affected?
> >
> My alternative is 4.19.31_rt18. No such issue with this one.
> > This is not helpful. Do you have an reproducer?
> >
> Afraid not. Could you instruct what to get, how to use?

Can you compile with:
| CONFIG_DEBUG_PREEMPT=y
| CONFIG_LOCK_DEBUGGING_SUPPORT=y
| CONFIG_PROVE_LOCKING=y
| # CONFIG_LOCK_STAT is not set
| CONFIG_DEBUG_RT_MUTEXES=y
| CONFIG_DEBUG_SPINLOCK=y
| CONFIG_DEBUG_MUTEXES=y
| CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
| CONFIG_DEBUG_LOCK_ALLOC=y
| CONFIG_LOCKDEP=y
| # CONFIG_DEBUG_LOCKDEP is not set
| CONFIG_DEBUG_ATOMIC_SLEEP=y
| # CONFIG_LOCK_TORTURE_TEST is not set
| # CONFIG_WW_MUTEX_SELFTEST is not set
| CONFIG_TRACE_IRQFLAGS=y
| CONFIG_STACKTRACE=y
| # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
| # CONFIG_DEBUG_KOBJECT is not set
| # CONFIG_DEBUG_KOBJECT_RELEASE is not set
| CONFIG_DEBUG_BUGVERBOSE=y
| CONFIG_DEBUG_LIST=y

and check dmesg if the kernel says anything out of the ordinary after the
crash?

> regards
> Bernhard

Sebastian
