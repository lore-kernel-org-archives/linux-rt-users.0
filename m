Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB8C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69992146E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 15:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCMPXt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfCMPXt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 11:23:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EBB20643;
        Wed, 13 Mar 2019 15:23:47 +0000 (UTC)
Date:   Wed, 13 Mar 2019 11:23:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] tracing/probe: Check event/group naming rule at
 parsing
Message-ID: <20190313112346.0b3fc25f@gandalf.local.home>
In-Reply-To: <20190314000402.3b14693f9030e891648124f1@kernel.org>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248009231.10815.12287201787254147977.stgit@devnote2>
        <20190313092355.6f434c9f@gandalf.local.home>
        <20190314000402.3b14693f9030e891648124f1@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 14 Mar 2019 00:04:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > >  		strlcpy(buf, event, slash - event + 1);
> > > +		if (!is_good_name(buf)) {
> > > +			pr_info("Group name must follow the rule of C identifier\n");  
> > 
> > What do you mean by "C identifier"?  
> 
> I meant "the naming rules of C language identifiers". It means
> that the name has to start with alphabet or "_" and only contain
> alphanumeric characters and "_". Does it clear?
> I couldn't think of a good word. maybe "naming convention"
> does not fit...

Ah, OK that now makes sense.

> 
> Would you have any idea?

I think I was more confused by the way it was stated. What about saying:

	"Group names must follow the same rules as C identifiers"

Saying "the rule of C identifiers" made me think more of "the rule of
law", and thought that this had something to do with rules of C
zealots, and those that identify with "C" ;-)

-- Steve
