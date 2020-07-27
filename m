Return-Path: <SRS0=/zSf=BG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C23C433E5
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB6920719
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG0TKj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgG0TKi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jul 2020 15:10:38 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC06207FC;
        Mon, 27 Jul 2020 19:10:36 +0000 (UTC)
Date:   Mon, 27 Jul 2020 15:10:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Joe Korty <joe.korty@concurrent-rt.com>
Subject: Re: [ANNOUNCE] v4.4.231-rt202
Message-ID: <20200727151033.7c37df2b@oasis.local.home>
In-Reply-To: <3732c1c4-36d4-2cdc-677a-cb58a9507df1@suse.de>
References: <159559806551.29587.13643956941367278015@beryllium>
        <3732c1c4-36d4-2cdc-677a-cb58a9507df1@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 26 Jul 2020 13:55:12 +0200
Daniel Wagner <dwagner@suse.de> wrote:

> Hi,
> 
> On 24.07.20 15:41, Daniel Wagner wrote:
> > Known issues:
> > 
> >     sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
> >     the same as reported for the v4.4.220-rt196 release. As it turns
> >     out it was not triggered by BPF.
> >     https://paste.opensuse.org/view/raw/58939248  
> 
> Joe pointed out [1] that v4.4-rt is missing 9567db2ebe56 ("signal: 
> Prevent double-free of user struct") from devel-rt. With this
> patch all my tests pass.
> 
> @stable-rt team: Can you please add it to the missing trees?

Good catch,

I'll pull this in on Friday.

-- Steve

> 
> Thanks,
> Daniel
> 
> [1] 
> https://lore.kernel.org/linux-rt-users/20200626130544.GA37967@zipoli.concurrent-rt.com/

