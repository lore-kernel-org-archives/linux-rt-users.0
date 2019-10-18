Return-Path: <SRS0=Yxvf=YL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921ACA9EA4
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4720700
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 11:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407741AbfJRLA2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:00:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56500 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407520AbfJRLA2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Oct 2019 07:00:28 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iLPzY-0005U9-EK; Fri, 18 Oct 2019 13:00:20 +0200
Date:   Fri, 18 Oct 2019 13:00:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT v2 0/3] migrate disable fixes and performance
Message-ID: <20191018110020.nq5xvghmawrua4vd@linutronix.de>
References: <20191012065214.28109-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191012065214.28109-1-swood@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-12 01:52:11 [-0500], Scott Wood wrote:
> These are the unapplied patches from v1, minus the sched deadline
> patch, and with stop_one_cpu_nowait() in place of clobbering
> current->state.

Thank you. They will be part of the next release.

Sebastian
