Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B1FC43381
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FB521925
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553336105;
	bh=WcTWVdQSyh72/J+FBx0urkmoCjnrvcg+bh4FZVjzzDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EQxF1oxCVReI7GouS/0FN2VHQjnEAv2zehys2z3UVx8JPcFJLDthCyRfWaafxtdlC
	 eVz9fxgWtoKHZsCr5Io4IjwlWTDHbvAqIXCGB+C3XDbQzxyhFziIZAojVVWWk8WsGr
	 uc7kzrs2HryUZVeeeJJ/RI5wDbOyEKM9bUVptkGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCWKPA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCWKPA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 06:15:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE9E218A5;
        Sat, 23 Mar 2019 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553336099;
        bh=WcTWVdQSyh72/J+FBx0urkmoCjnrvcg+bh4FZVjzzDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RO2fYZokY8At6RWjpJzbkXbTu3kX293URu+R4CUPjHnNSuQdR+yRLLozXL9gfr7mD
         WcBR+uwlVXiKshdw4QYg7wtIg8ZMsUEwN0xUMLUcx9C8/QFpGorUZ+G9xHEvyyYmBC
         PxLi4sy4Wd4O+HoCoYneGBw4LCC2EwZdI6531S3A=
Date:   Sat, 23 Mar 2019 19:14:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 00/11] tracing: common error_log for ftrace
Message-Id: <20190323191455.e921b0e0dbe2d56b695bcee2@kernel.org>
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Fri, 22 Mar 2019 10:34:26 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v4 of the frace error_log patchset.  This version adds
> Masami's probe events error_log patches and removes the previous
> placeholder for that.  It also removes the hist trigger extended error
> err testcase and replaces it with a basic error_log functionality
> testcase, and replaces the error numbering with timestamps, also as
> suggested by Masami.  Finally, the Documentation and README are both
> updated to describe the error_log.

Thank you for updating this series! :)

> 
> Note: The probe event error_log test cases failed on my Ubuntu system,
> due to the >& redirection operator that dash doesn't understand, so I
> tacked on a final patch that fixes it for me.  If acceptable, feel
> free to just merge it with Masami's patch.

Oops, that's my laziness... that should be > /dev/null 2>&1, sorry.

[...]
> Below is an example session of a few failed commands and the
> corresponding error_log contents:
> 
>   # echo > /sys/kernel/debug/tracing/error_log
> 
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
>   -su: echo: write error: Invalid argument
> 
>   #  cat /sys/kernel/debug/tracing/error_log
>   [  217.431858] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
>                       ^
> 

Yeah, this looks good to me :)

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
