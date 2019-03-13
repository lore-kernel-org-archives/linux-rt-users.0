Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E6C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17436214AE
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCMOv7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfCMOv7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 10:51:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EC321019;
        Wed, 13 Mar 2019 14:51:58 +0000 (UTC)
Date:   Wed, 13 Mar 2019 10:51:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] tracing/probe: Check maxactive error cases
Message-ID: <20190313105156.7f1da539@gandalf.local.home>
In-Reply-To: <20190313233739.09f58a0c5762d9a43470046b@kernel.org>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248006270.10815.14600382508884855084.stgit@devnote2>
        <20190313092051.77d04675@gandalf.local.home>
        <20190313233739.09f58a0c5762d9a43470046b@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 23:37:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > So now 'p1:..." will error out and not just be ignored?  
> 
> Yes, I think it is better to tell user "your command has a
> meaningless option, maybe you made a mistake" than ignore that.
> 

OK, just making sure. Hope nobody complains about it ;-)

Are these OK to add for the next merge window, or do you want them in
now? I could probably get them ready for -rc1.

-- Steve
