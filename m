Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A0BC48BD6
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21B2080C
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFZQtY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZQtY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 12:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54DFD3082AEF;
        Wed, 26 Jun 2019 16:49:20 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7635C224;
        Wed, 26 Jun 2019 16:49:17 +0000 (UTC)
Message-ID: <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
From:   Scott Wood <swood@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 11:49:16 -0500
In-Reply-To: <20190626110847.2dfdf72c@gandalf.local.home>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-5-swood@redhat.com>
         <20190620211826.GX26519@linux.ibm.com>
         <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
         <20190621235955.GK26519@linux.ibm.com>
         <20190626110847.2dfdf72c@gandalf.local.home>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 16:49:24 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2019-06-26 at 11:08 -0400, Steven Rostedt wrote:
> On Fri, 21 Jun 2019 16:59:55 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > I have no objection to the outlawing of a number of these sequences in
> > mainline, but am rather pointing out that until they really are outlawed
> > and eliminated, rcutorture must continue to test them in mainline.
> > Of course, an rcutorture running in -rt should avoid testing things that
> > break -rt, including these sequences.
> 
> We should update lockdep to complain about these sequences. That would
> "outlaw" them in mainline. That is, after we clean up all the current
> sequences in the code. And we also need to get Linus's approval of this
> as I believe he was against enforcing this in the past.

Was the opposition to prohibiting some specific sequence?  It's only certain
misnesting scenarios that are problematic.  The rcu_read_lock/
local_irq_disable restriction can be dropped with the IPI-to-self added in
Paul's tree.  Are there any known instances of the other two (besides
rcutorture)?

-Scott


