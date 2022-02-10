Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F558C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Feb 2022 05:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiBJFAH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Feb 2022 00:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiBJFAH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Feb 2022 00:00:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275061F7;
        Wed,  9 Feb 2022 21:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53CF8B80E19;
        Thu, 10 Feb 2022 05:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49067C004E1;
        Thu, 10 Feb 2022 05:00:05 +0000 (UTC)
Date:   Thu, 10 Feb 2022 00:00:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Subject: Re: [PATCH] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <20220210000003.6b6142f9@gandalf.local.home>
In-Reply-To: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
References: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed,  9 Feb 2022 17:24:30 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
> do_softirq fails for such kernel:
> 
>   echo do_softirq
>   ftracetest: 81: echo: echo: I/O error
> 
> Choose some other externally visible function for the test.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> I understand that the failure does not exist on mainline kernel (only
> with PREEMPT_RT patchset) but the change does not harm it.
> 
> If it is not suitable alone, please consider it for RT patchset.
> ---
>  .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> index e96e279e0533..1d0c7601865f 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> @@ -19,7 +19,7 @@ fail() { # mesg
>  
>  FILTER=set_ftrace_filter
>  FUNC1="schedule"
> -FUNC2="do_softirq"
> +FUNC2="_printk"

The problem with the above, is that it is not guaranteed to trigger (and
probably will not), where as the do_softirq is. The filtering is suppose to
trace something that actually happens.

How about using: scheduler_tick ?

-- Steve


>  
>  ALL_FUNCS="#### all functions enabled ####"
>  

