Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BAC43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F86218B0
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553336565;
	bh=G3qTKmOseAR58ZODxZsb5koIUY8J3p8yEEyno26NAPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OLEkzAhPP3ubPA8uX3Fa+ZVveezglwDbG5ZO7gl97TOKEwywrlUrxSuZd+Uj75WQ+
	 D6YgQZhvIHFPj1D55JXXcWZJcdj/wTEA1tShWi1bMj1erAl8V8RUn+rF8FaO9XOUsk
	 JkjB+rFwAqc0X4YkeozqSG8rbtGC5ZJFxHBgBlRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCWKWk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCWKWk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 06:22:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B409218A5;
        Sat, 23 Mar 2019 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553336559;
        bh=G3qTKmOseAR58ZODxZsb5koIUY8J3p8yEEyno26NAPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IOtx6ArLbNujV85CjsfbBjOThR8DRPptkcFRMvXbtraTsgCUyfOCdAyd7ZPIDXo92
         NWYSbS6YUEiECnFm8EivZ2+VVrYnV1JQ0jP/SKiOj9lrSzcdFJSh12kUwyPnJxxTnh
         ScFReQAwFOG1p7Jr7bOHD9NhDFo05LncKuDhj1xQ=
Date:   Sat, 23 Mar 2019 19:22:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 06/11] selftests/ftrace: Add error_log testcase for
 probe errors
Message-Id: <20190323192234.7884a15d9fab262ef70d3cab@kernel.org>
In-Reply-To: <c620157fa19f9df4ebf33e3e138c1234a4b5def7.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <c620157fa19f9df4ebf33e3e138c1234a4b5def7.1553268040.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 22 Mar 2019 10:34:32 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Add error_log testcase for error logs on probe events.
> This tests most of error cases and checks the error position
> is correct.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 93 ++++++++++++++++++++++
>  .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   | 31 ++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> new file mode 100644
> index 000000000000..281665b1348c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -0,0 +1,93 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event parser error log check
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +[ -f error_log ] || exit_unsupported
> +
> +check_error() { # command-with-error-pos-by-^
> +pos=$(echo -n "${1%^*}" | wc -c) # error position
> +command=$(echo "$1" | tr -d ^)
> +echo "Test command: $command"
> +echo > error_log
> +(! echo "$command" > kprobe_events ) >& /dev/null

Oops, this one. This must be

(! echo "$command" > kprobe_events ) > /dev/null 2>&1

[...]
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> new file mode 100644
> index 000000000000..957011300bb7
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Uprobe event parser error log check
> +
> +[ -f uprobe_events ] || exit_unsupported # this is configurable
> +
> +[ -f error_log ] || exit_unsupported
> +
> +check_error() { # command-with-error-pos-by-^
> +pos=$(echo -n "${1%^*}" | wc -c) # error position
> +command=$(echo "$1" | tr -d ^)
> +echo "Test command: $command"
> +echo > error_log
> +(! echo "$command" > uprobe_events ) >& /dev/null

Here too.

Tom, if you don't mind, could you update it when you update
the series? Or should I resend it?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
