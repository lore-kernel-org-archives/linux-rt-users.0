Return-Path: <SRS0=a4Ye=BD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896E5C433E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jul 2020 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA0B2074A
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jul 2020 13:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGXNqo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:46:44 -0400
Received: from mail.monom.org ([188.138.9.77]:40748 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGXNqn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jul 2020 09:46:43 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 232BD50056B;
        Fri, 24 Jul 2020 15:46:41 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 5758150039E;
        Fri, 24 Jul 2020 15:46:40 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] v4.4.231-rt202
Date:   Fri, 24 Jul 2020 13:41:05 -0000
Message-ID: <159559806551.29587.13643956941367278015@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the v4.4.231-rt202 stable release.

This release is an update to the new stable v4.4.231 version.
It also includes the backport ("BPF: Disable on PREEMPT_RT") as
Sebastian suggested to include in v4.4-rt.

Known issues:

   sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
   the same as reported for the v4.4.220-rt196 release. As it turns
   out it was not triggered by BPF.
   https://paste.opensuse.org/view/raw/58939248

Thanks,
Daniel
