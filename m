Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA65C43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98400206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 23:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCDXpd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCDXpd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 18:45:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D94F206B6;
        Mon,  4 Mar 2019 23:45:32 +0000 (UTC)
Date:   Mon, 4 Mar 2019 18:45:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/2] tracing: Use strncpy instead of memcpy for string
 keys in hist triggers
Message-ID: <20190304184530.7e819698@gandalf.local.home>
In-Reply-To: <5c978b4b0d629e5a914c512c14f99f6a24241407.camel@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
        <50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com>
        <20190304165000.0ce0fbdd@gandalf.local.home>
        <20190304165653.17699f9f@gandalf.local.home>
        <5643a1971831ce2d01a947f0f07cefa002bbdc25.camel@linux.intel.com>
        <5c978b4b0d629e5a914c512c14f99f6a24241407.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 04 Mar 2019 16:31:40 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> > Hmm, I don't think it's really necessary - it's not used in a key so
> > don't care about anything after the null, and TASK_COMM_LEN is used
> > in
> > the memcpy.  
> 
> Never mind, yeah, it would make sense to do this, will create another
> patch...

And probably should change the memcpy() of comm in kernel/trace/trace.c
too. It could be that memcpy() is a little bit faster than strncpy(),
and this is done on scheduling switches when tracing is active, but
still, I'm starting to think that isn't a good choice.

-- Steve
