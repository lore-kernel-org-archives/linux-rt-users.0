Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1504C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 06:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0EB2173C
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552371981;
	bh=Wq1B8fb8/O8y4XGqMAIvrv0er9jHAIxGZ1LVS8oxmPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yeWcgyjkEPp911j+Qpowrh/xxj8+cUl+ruXZnLwEuSs45xJ0a1pvJkyBkeOdMMK8Z
	 fgEe7EkKvc8TKqEvJ4QXtYpe3liExvspZKhaC2DWS0MyVYoHig1DG2ihLO4i4KIpYr
	 jCkDTexAfZD+xUcBGrgpvf8g8AHv/glFuWQ6HZ8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCLG0L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfCLG0L (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 02:26:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD56214AE;
        Tue, 12 Mar 2019 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552371970;
        bh=Wq1B8fb8/O8y4XGqMAIvrv0er9jHAIxGZ1LVS8oxmPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c08Sj4hExWeXsNsEzqpS+V8lQ9l7gLsm6Od4k78ufdtm29/zxBcggj69hJytDB+q3
         cdqn4Z4D/1dks7XtsBRq8VW3ZGLG5rbRtcsZ8zdDoyAy9maTaAItPV7NOWWsneEhHj
         D1LxtJTVheBUnNgVbNbO26nlkawSKh/Pxk8W6QIQ=
Date:   Tue, 12 Mar 2019 15:26:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, rostedt@goodmis.org,
        tglx@linutronix.de, namhyung@kernel.org, bigeasy@linutronix.de,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] tracing: common error_log for ftrace
Message-Id: <20190312152605.00150aae7b781137005e9ebf@kernel.org>
In-Reply-To: <20190305230646.e7f99c46f86c0e099ac0cd30@kernel.org>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
        <20190305230646.e7f99c46f86c0e099ac0cd30@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Tue, 5 Mar 2019 23:06:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon,  4 Mar 2019 17:36:43 -0600

> > Changes from v2:
> > 
> >   - Added [n] numbering as suggested by Masami
> 

Hmm, this seems a bit different what I suggested.

I'm trying to port probe event's error report on
your error log, and I found that the number is
just shifted as below.

When I filled the log with errors.
=============
/sys/kernel/debug/tracing # cat error_log 
[1] trace_kprobe: error: Invalid unsigned integer string
  Command: r10aa00:foo/bar vfs
            ^
...

[7] trace_kprobe: error: Group name must follow C naming convention
  Command: p:a-b/bar vfs_read
             ^
[8] trace_kprobe: error: Event name is too long
  Command: p:a/barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr vfs_read
=============

And do one more error, 

=============
/sys/kernel/debug/tracing # cat error_log 
[1] trace_kprobe: error: Maxactive is too big
  Command: r0xaa00:foo/bar vfs

....

[7] trace_kprobe: error: Event name is too long
  Command: p:a/barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr vfs_read
               ^
[8] trace_kprobe: error: Event name must follow C naming convention
  Command: p:a/bar.c vfs_read
               ^
=============

The number of logs are changed :(  This can confuse users.
I think it is better to keep the number as a unique number for
each entry as below.

=============
/sys/kernel/debug/tracing # cat error_log 
[2] trace_kprobe: error: Maxactive is too big
  Command: r0xaa00:foo/bar vfs

....

[8] trace_kprobe: error: Event name is too long
  Command: p:a/barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr vfs_read
               ^
[9] trace_kprobe: error: Event name must follow C naming convention
  Command: p:a/bar.c vfs_read
               ^
=============

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
