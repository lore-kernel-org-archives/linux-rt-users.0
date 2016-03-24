From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH][rt-tests] Revert changes to rt-migrate-test for exit(1)
Date: Thu, 24 Mar 2016 10:40:58 -0400
Message-ID: <20160324104058.55074b2f@redhat.com>
References: <alpine.LFD.2.20.1603241525570.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbcCXOlD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 10:41:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id BA3FC1E32
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 14:41:01 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603241525570.8641@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 24 Mar 2016 15:28:24 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> From 607dc3627ab7ff28a116c5bb09058aabddf10f27 Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Thu, 24 Mar 2016 15:21:54 +0100
> Subject: [PATCH] Revert changes to rt-migrate-test for exit(1)
> 
> Commit 3290f8412a4562adbc05b38d8e5212090e41587e changed
> exit(-1) to exit(1) for many programs in rt-tests for consistency.
> 
> rt-migrate-test needs tri-state exit statuses, because of the way
> some existing bash scripts consume it's results.
> 
> This could no-doubt be improved in the future, and there are some
> inconsistencies in the exit statuses in this program alone, but as they
> are not urgent to fix, and the current fix makes things worse, reverting
> this for now.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index e18beca816aa..d7b68ddac3e5 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -138,7 +138,7 @@ static void perr(char *fmt, ...)
>  
>  	perror(buffer);
>  	fflush(stderr);
> -	exit(1);
> +	exit(-1);
>  }
>  
>  static void print_progress_bar(int percent)
> @@ -226,6 +226,7 @@ static void parse_options (int argc, char *argv[])
>  			break;
>  		}
>  	}
> +
>  }
>  
>  static unsigned long long get_time(void)
> @@ -603,7 +604,7 @@ int main (int argc, char **argv)
>  			exit(1);
>  	}
>  	if (check < 0)
> -		exit(1);
> +		exit(-1);
>  	else
>  		exit(0);
>  

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
