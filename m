Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6BC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 19:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7779720829
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 19:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMT2k (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMT2j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 15:28:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EB320774;
        Thu, 13 Aug 2020 19:28:37 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:28:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH RT 1/6] signal: Prevent double-free of user struct
Message-ID: <20200813152835.7dd92d57@oasis.local.home>
In-Reply-To: <b4c933e7-62e2-7018-d848-b5cde0d9ef26@prevas.dk>
References: <20200813014534.833107526@goodmis.org>
        <20200813014555.384329363@goodmis.org>
        <b4c933e7-62e2-7018-d848-b5cde0d9ef26@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 13 Aug 2020 10:25:45 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> On 13/08/2020 03.45, Steven Rostedt wrote:
> > 5.4.54-rt33-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> >  
> 
> No objections, quite the contrary. I think this should also be applied
> to 4.19-rt:

Yep. We have a rule that no earlier supported stable release should
have a fix that a more recent stable release does not have. So this
needs to be accepted in 5.4-rt before 4.19-rt can have it. And those
maintainers have been waiting patiently for me to push this ;-)


> Three requests (in order of importance):
> 
> * pull this into 4.19-rt
> * add a note about the sigwaittest reproducer to the commit log

We don't usually add comments to the commit log for backported patches.

> * do publish the rt-rcs in some git repository; that makes it a lot
> easier to cherry-pick and test patches

This has been talked about before. Perhaps you should bring up posting
stable RT RC releases into git repositories at the RT microconference
at Plumbers ;-) Especially since the last time I asked about it, people
said it wasn't necessary.

https://linuxplumbersconf.org/event/7/page/80-accepted-microconferences#rt-cr

-- Steve

