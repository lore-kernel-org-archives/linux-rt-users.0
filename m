From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH][rt-tests] cyclictest: Make the tracemark option imply
 notrace
Date: Thu, 24 Mar 2016 10:52:55 -0400
Message-ID: <20160324105255.48459b11@redhat.com>
References: <alpine.LFD.2.20.1603241543150.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbcCXOw7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 10:52:59 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id E9D46C00DDE4
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 14:52:57 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603241543150.8641@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 24 Mar 2016 15:44:39 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> From 6b663b39fc5dc7c4e9c78ab22012f07490e53145 Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Thu, 24 Mar 2016 15:40:03 +0100
> Subject: [PATCH] cyclictest: Make the tracemark option imply notrace
> 
> The new --tracemark option can be used to run cyclictest under
> trace-cmd.
> 
> This means we don't want cyclictest's built-in tracing to be used, so
> this option is only compatible with --notrace.
> 
> Therefore turn --notrace on if --tracemark is invoked even if the user
> doesn't explicitly request this.

I'm not necessarily against this, but at the same time I think
I prefer options doing only one thing.

> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4844dfaf33a6..158bceda1204 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1765,6 +1765,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  #endif
>  			break;
>  		case OPT_TRACEMARK:
> +			notrace = 1; /* using --tracemark implies --notrace */
>  			trace_marker = 1; break;
>  		}
>  	}

