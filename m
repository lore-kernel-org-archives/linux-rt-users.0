Return-Path: <SRS0=qrdP=RI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E15C43381
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF782075B
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Mar 2019 21:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCEV6u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfCEV6u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Mar 2019 16:58:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C371204EC;
        Tue,  5 Mar 2019 21:58:49 +0000 (UTC)
Date:   Tue, 5 Mar 2019 16:58:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] tracing: common error_log for ftrace
Message-ID: <20190305165846.075a0e6c@gandalf.local.home>
In-Reply-To: <cover.1551741458.git.tom.zanussi@linux.intel.com>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon,  4 Mar 2019 17:36:43 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v3 of the frace error_log RFC patchset, which is the same as
> the previous version but adds the numbering Masami suggested before
> each item in the log.  Masami also said he was going to take over the
> kprobe events patch, but I left it in for now for completeness as it
> still provides a useful example of possible usage, for evaluation of
> the overall scheme.  I'll remove it when it's no longer an RFC.
> 
> Changes from v2:
> 
>   - Added [n] numbering as suggested by Masami
> 
>

Hi Tom,

Thanks for doing this!

Note, I'm marking this as TODO, as the merge window has opened and this
will have to wait till it closes. But that means it may get buried by
other patches and such marked as TODO. :-p

Can you send me a friendly reminder in two weeks if you don't hear from
me?

Thanks!

-- Steve
