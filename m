Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F546C43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 12:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55E21902
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553342903;
	bh=UDRvaXlFdveojcscNQrJKmmTeRaB6HZxZxF1KiFQTYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LyF/K1DP79lfjiioDszcNVJmMAp2AydMo/Ic06PSXWpcHUe/qyFU731UKzFYoO8zd
	 /cUtmNRAZ6eI9TqEDslqV8j2a1UhZkwXMK2ETjXFHzEUZle3WXErAmIesgivvldF6D
	 AlvogzlayUFlbrYqmkFTjc8GmHNniyZjFH92cFVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCWMIW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfCWMIW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 08:08:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015F8218A5;
        Sat, 23 Mar 2019 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553342901;
        bh=UDRvaXlFdveojcscNQrJKmmTeRaB6HZxZxF1KiFQTYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b0j1zPf3KfYYboICUpHV9q3EghZKEkNOcaMRCp5k1R5LWu9vdohrJhrSALUWMUq7g
         IGPMUdYCPagI/3WJe+D3TAb//nfXfJE9OBRe5bPANA3wdvD/jJtS6SYDwzcfuq0pYQ
         hgY4TGWaCuqdXQ+NNWHUHSgglDTkawez3pG18qMU=
Date:   Sat, 23 Mar 2019 21:08:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 08/11] selftests/ftrace: Add tracing/error_log
 testcase
Message-Id: <20190323210816.5cc19aa0d7c43c4c19c639b8@kernel.org>
In-Reply-To: <a0b936b8ba26b6c55bddc7d5ec22fc40e49a77b9.1553268041.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <a0b936b8ba26b6c55bddc7d5ec22fc40e49a77b9.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 22 Mar 2019 10:34:34 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a testcase verifying basic tracing/error_log functionality.

Would you be OK that you don't test all error cases with
error position?

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../ftrace/test.d/ftrace/tracing-error-log.tc      | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> new file mode 100644
> index 000000000000..601ffebfbb9f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: ftrace - test tracing error log support
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +# event tracing is currently the only ftrace tracer that uses the
> +# tracing error_log, hence this check
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +echo "Test tracing error log support"
> +! echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > events/signal/signal_generate/filter 2> /dev/null
> +if ! grep "error:" error_log; then
> +    fail "Failed to generate tracing error log error"
> +fi
> +
> +exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
