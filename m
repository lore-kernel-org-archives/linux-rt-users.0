Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2CC43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFFB218A2
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553346865;
	bh=ixii/RRagtCEsBA6Ax8LV25s3Q1FXn0eJqziYZ/+8iI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=jBsd75dIi8VROTZ7hPNkU0kWiuILeRWkbmZpwfWzjOMZVq64fBO9YbhwoFw6QMAi3
	 puSCnjsq1ZbZH4pfyIhYdIumloy7I4LXyUhHXsS6PVMZnAvDSkI+FqehQIxuUzgoY7
	 0iNJBIxsNK6W8HwE8FpSkmYh72EfcAGWmRg5Wz6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCWNOU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWNOU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 09:14:20 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE082175B;
        Sat, 23 Mar 2019 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553346859;
        bh=ixii/RRagtCEsBA6Ax8LV25s3Q1FXn0eJqziYZ/+8iI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RVP06xrVoWjw0iwD1JIc2/audOmA5ZbXdT5WAZ2Dsk4+WXgRdcxhfTmre2BQxTOQn
         w7GdIDqTIssDx4JnGSe6Nb5MglGYtYi82e72UPUltYbmkKp4NmFLjQ7QulGIx32Hzx
         sM3OjCP+FVdsB12MT77AvgCT7F+CduEl5b638br0=
Message-ID: <1553346857.2307.11.camel@kernel.org>
Subject: Re: [PATCH v4 11/11] selftests/ftrace: Change stderr redirection
 for probe error_log testcase
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Sat, 23 Mar 2019 08:14:17 -0500
In-Reply-To: <20190323192851.ea9f26822f6572fafc946b74@kernel.org>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
         <ce51abd8585b775fd98e31e5feb1b1505483312f.1553268041.git.tom.zanussi@linux.intel.com>
         <20190323192851.ea9f26822f6572fafc946b74@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Sat, 2019-03-23 at 19:28 +0900, Masami Hiramatsu wrote:
> On Fri, 22 Mar 2019 10:34:37 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > On my system, /bin/sh is symlinked to dash, which doesn't
> > understand
> > the >& syntax, so the kprobe and uprobe error cases fail, with this
> > in
> > the log:
> > 
> > ./ftracetest: 26:
> > tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.t
> > c:
> > Syntax error: Bad fd number
> > 
> > Changing >& to 2> does work though, and should work in any shell.
> 
> Ah, I missed this patch.
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

OK, thanks, will merge it with the original testcase.

> BTW, where is my checkbashisms testcase ...

Haha, yeah, seems to be a problem with recent testcases.

Tom

> 
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.
> > tc | 2 +-
> >  tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.
> > tc | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git
> > a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > .tc
> > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > .tc
> > index 281665b1348c..7eb577b1d222 100644
> > ---
> > a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > .tc
> > +++
> > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > .tc
> > @@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
> >  command=$(echo "$1" | tr -d ^)
> >  echo "Test command: $command"
> >  echo > error_log
> > -(! echo "$command" > kprobe_events ) >& /dev/null
> > +(! echo "$command" > kprobe_events ) 2> /dev/null
> >  grep "trace_kprobe: error:" -A 3 error_log
> >  N=$(tail -n 1 error_log | wc -c)
> >  # "  Command: " and "^\n" => 13
> > diff --git
> > a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > .tc
> > b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > .tc
> > index 957011300bb7..ec7389b7934b 100644
> > ---
> > a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > .tc
> > +++
> > b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > .tc
> > @@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
> >  command=$(echo "$1" | tr -d ^)
> >  echo "Test command: $command"
> >  echo > error_log
> > -(! echo "$command" > uprobe_events ) >& /dev/null
> > +(! echo "$command" > uprobe_events ) 2> /dev/null
> >  grep "trace_uprobe: error:" -A 3 error_log
> >  N=$(tail -n 1 error_log | wc -c)
> >  # "  Command: " and "^\n" => 13
> > -- 
> > 2.14.1
> > 
> 
> 
