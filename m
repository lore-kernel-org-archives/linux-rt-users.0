Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D82C83007
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E3820731
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 23:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OONEBeUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgD1XUq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726042AbgD1XUn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 19:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588116042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awX/WDzY4v/mrZcN7vzH0b6aC46+DakYZAFmWm381lc=;
        b=OONEBeUWIz7E9HFIfaaO6af/jd0+Ct3MFOeHdiSTzVtez7nn8Kah4zZI3HLj9zZR7T2liS
        vxQKTmhBnynJ4kbswY00bumavvZF7MiAp+6ob0gdsMvpVgrnkliWqLnbCLN3VLDj44cqFE
        uRaekJadpUSaACNvI0kcovmUFfkOHWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-tV07bsIDNPug05Cx3avFfg-1; Tue, 28 Apr 2020 19:20:36 -0400
X-MC-Unique: tV07bsIDNPug05Cx3avFfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E68800C78;
        Tue, 28 Apr 2020 23:20:34 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D634C5D710;
        Tue, 28 Apr 2020 23:20:32 +0000 (UTC)
Message-ID: <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Tue, 28 Apr 2020 18:20:32 -0500
In-Reply-To: <20200428230204.GE16027@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com>
         <20200428220917.GB16027@hirez.programming.kicks-ass.net>
         <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
         <20200428230204.GE16027@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-04-29 at 01:02 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 05:55:03PM -0500, Scott Wood wrote:
> > On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:
> > > Also, if you move it this late, this is entirely the wrong place. If
> > > you
> > > do it after the context switch either use the balance_callback or put
> > > it
> > > in the idle path.
> > > 
> > > But what Valentin said; this needs a fair bit of support, the whole
> > > reason we've never done this is to avoid that double context switch...
> > > 
> > 
> > balance_callback() enters with the rq lock held but BH not separately
> 
> BH? softirqs you mean? Pray tell more.

In https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/ the need to
keep softirqs disabled during rebalance was brought up, but simply wrapping
the lock dropping in local_bh_enable()/local_bh_disable() meant that
local_bh_enable() would be called with interrupts disabled, which isn't
allowed.

> > disabled, which interferes with the ability to enable interrupts but not
> > BH.
> > It also gets called from rt_mutex_setprio() and __sched_setscheduler(),
> > and
> > I didn't want the caller of those to be stuck with the latency.
> 
> You're not reading it right.

Could you elaborate?

-Scott


