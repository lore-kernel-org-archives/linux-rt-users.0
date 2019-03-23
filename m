Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925CC43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05668218E2
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553335994;
	bh=jueNsNBggMZ+k4Ytsnu2LDSmnSPHO+ANvLfVnYuPpSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jZADE0hEtYclDKE181FoacVCIqumGXGtOGcgUHqqULJjHtdBawh0TDmmCilzW69jE
	 aT3lSThk+bbnZgIFuGZRJU7jzNel/+ykt6TvsWrRVe1+FhSt693+GRIchAoRpPVbCk
	 j8X/9c6bCuhDPD55lV8k1LfNJDcp77eFkIyglHRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfCWKNI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfCWKNI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 06:13:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229D9218A5;
        Sat, 23 Mar 2019 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553335987;
        bh=jueNsNBggMZ+k4Ytsnu2LDSmnSPHO+ANvLfVnYuPpSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2W05HuOSO9JBfZ2kTOkq/viamP75gG5Qjsg3oQwa8turY/ouSX6evdmGmJJpfjQF
         xsM504oCpf1jFChZ3Pl3czlPf1Vr+SZgq46YmFbTg1Ojj+wNgkUfyd21GO8tSF+EEf
         BCpfzwHV7gZj0Vq0SfBRbybnNhKDP2qrkH8Atrvo=
Date:   Sat, 23 Mar 2019 19:13:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 07/11] tracing: Remove trigger-extended-error-support
 testcase
Message-Id: <20190323191302.321ea1d6b9cb1c75c7e828c7@kernel.org>
In-Reply-To: <064693880a99a7ac3cb43ee375c265a938402257.1553268041.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <064693880a99a7ac3cb43ee375c265a938402257.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

This should be tagged with "selftests/ftrace:". :)

Thank you,

On Fri, 22 Mar 2019 10:34:33 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Error handling has been moved to the common tracing/error_log, so this
> test is no longer valid.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../inter-event/trigger-extended-error-support.tc  | 28 ----------------------
>  1 file changed, 28 deletions(-)
>  delete mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
> deleted file mode 100644
> index 9912616a8672..000000000000
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# description: event trigger - test extended error support
> -
> -
> -fail() { #msg
> -    echo $1
> -    exit_fail
> -}
> -
> -if [ ! -f set_event ]; then
> -    echo "event tracing is not supported"
> -    exit_unsupported
> -fi
> -
> -if [ ! -f synthetic_events ]; then
> -    echo "synthetic event is not supported"
> -    exit_unsupported
> -fi
> -
> -echo "Test extended error support"
> -echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
> -! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger 2> /dev/null
> -if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
> -    fail "Failed to generate extended error in histogram"
> -fi
> -
> -exit 0
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
