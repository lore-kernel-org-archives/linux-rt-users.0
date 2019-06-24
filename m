Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF2EC43613
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20023212F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 13:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfFXN1x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:27:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfFXN1x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 09:27:53 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hfP0e-0002mg-W3; Mon, 24 Jun 2019 15:27:49 +0200
Date:   Mon, 24 Jun 2019 15:27:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, mwhitehe@redhat.com
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190624132748.n4lgg4swj4nzirdb@linutronix.de>
References: <20190622081954.GA10751@amd>
 <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
 <20190624105340.GA21414@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624105340.GA21414@amd>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-24 12:53:40 [+0200], Pavel Machek wrote:
> Hi!
Hi,

> > >Is full preemption supposed to work on x86-32 machines?
> > >
> > >Because it does not work for me. It crashes early in boot, no messages
> > >make it to console. Similar configuration for x86-64 boots ok.
> > >
> > 
> > Maybe you can also tell which version(s) you tried, and in which
> > configuration(s), and how the crash looked like.
> 
> I wanted to know if the configuration is supposed to work at all
> before starting heavy debugging. From your reply I assume that it
> should work.
> 
> I tried 4.19.13-rt1-cip1 among others. Crash is early in boot, I can
> try some early printing...

The latest is v4.19.50-rt22 I would suggest that one. There was a bug
which was fixed either in 4.19.23-rt14 or in the following version.

If the latest one does not work please let me know and I will have a
look.

> Best regards,
> 									Pavel

Sebastian
