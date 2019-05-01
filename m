Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB2C43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E80520652
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEATWo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 15:22:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfEATWo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 15:22:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57F2AAE3F;
        Wed,  1 May 2019 19:22:42 +0000 (UTC)
Date:   Wed, 1 May 2019 12:22:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190501192234.rwwuntngpi5v4unq@linux-r8p5>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <ce854251-139e-15f1-2ac5-b66a27f8284c@redhat.com>
 <20190501185400.GQ7905@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190501185400.GQ7905@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 01 May 2019, Peter Zijlstra wrote:

>Nah, the percpu_rwsem abuse by the freezer is atrocious, we really
>should not encourage that. Also, it completely wrecks -RT.
>
>Hence the proposed patch.

Is this patch (and removing rcuwait) only intended for rt?

Thanks,
Davidlohr
