Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA276C43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728F8218E2
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553336937;
	bh=lJi6CXQSMwVzumijs3EMM8dN+bdwp67TeX8tTTTH5Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CT7868Q+shhj45EnIn1iHJlKBJ0G9M+KTCNTyPYUefVA6NdvvpFMW4pXwXwKz96Ko
	 UxyZSU7p+0qHZ1tfNd+l76J3c8AlzW91gQoT0DsiNpCDOFKWOfKnAngIa5NLP/Iar0
	 gTRyW5rpsqfeG1nf4urWCzw3Lk+DcWVzsZHAHdtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCWK24 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfCWK24 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 06:28:56 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1F920883;
        Sat, 23 Mar 2019 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553336936;
        bh=lJi6CXQSMwVzumijs3EMM8dN+bdwp67TeX8tTTTH5Lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hPsI3bH4y4YSy7SVWWjyo0fl8CSQxCPyUmY2x5Ts+HvJf6ZBlyF+UoKXCBCPZFth9
         P8gcAPpK9egAJNEMcr7yBw4zl4JgtCbhJY/bCUhY3tItSLj+kjIBPqDBxteBAUGAXh
         Vd5hXDvV1Jo4nnkLOsKlkrRoLPzrXCKlijM01x3E=
Date:   Sat, 23 Mar 2019 19:28:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 11/11] selftests/ftrace: Change stderr redirection
 for probe error_log testcase
Message-Id: <20190323192851.ea9f26822f6572fafc946b74@kernel.org>
In-Reply-To: <ce51abd8585b775fd98e31e5feb1b1505483312f.1553268041.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <ce51abd8585b775fd98e31e5feb1b1505483312f.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 22 Mar 2019 10:34:37 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> On my system, /bin/sh is symlinked to dash, which doesn't understand
> the >& syntax, so the kprobe and uprobe error cases fail, with this in
> the log:
> 
> ./ftracetest: 26: tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc:
> Syntax error: Bad fd number
> 
> Changing >& to 2> does work though, and should work in any shell.

Ah, I missed this patch.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, where is my checkbashisms testcase ...

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc | 2 +-
>  tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index 281665b1348c..7eb577b1d222 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
>  command=$(echo "$1" | tr -d ^)
>  echo "Test command: $command"
>  echo > error_log
> -(! echo "$command" > kprobe_events ) >& /dev/null
> +(! echo "$command" > kprobe_events ) 2> /dev/null
>  grep "trace_kprobe: error:" -A 3 error_log
>  N=$(tail -n 1 error_log | wc -c)
>  # "  Command: " and "^\n" => 13
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> index 957011300bb7..ec7389b7934b 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> @@ -11,7 +11,7 @@ pos=$(echo -n "${1%^*}" | wc -c) # error position
>  command=$(echo "$1" | tr -d ^)
>  echo "Test command: $command"
>  echo > error_log
> -(! echo "$command" > uprobe_events ) >& /dev/null
> +(! echo "$command" > uprobe_events ) 2> /dev/null
>  grep "trace_uprobe: error:" -A 3 error_log
>  N=$(tail -n 1 error_log | wc -c)
>  # "  Command: " and "^\n" => 13
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
