From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/4] rt-migrate-test: fix return code
Date: Wed, 16 Mar 2016 23:14:10 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603162312320.16977@riemann>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com> <1456346981-24032-3-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33302 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbcCPWON (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 18:14:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id x188so3455768wmg.0
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Mar 2016 15:14:13 -0700 (PDT)
In-Reply-To: <1456346981-24032-3-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 24 Feb 2016, Luiz Capitulino wrote:

> Change both return codes for the stop == true case:
> 
>  * For failures, use exit(1) as exit(-1) is wrong
>    (it actually becomes 255 in the shell)
> 
>  * For success, use exit(2) instead of exit(1) as
>    exit(1) is usually used for errors
> 
> This should preserve the requirement of allowing
> shell script while loops to break when Ctrl-C is hit.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index fc6fd81..6e8acc2 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -594,9 +594,9 @@ int main (int argc, char **argv)
>  		 * loop know to break.
>  		 */
>  		if (check < 0)
> -			exit(-1);
> -		else
>  			exit(1);
> +		else
> +			exit(2);
>  	}
>  	if (check < 0)
>  		exit(-1);
> -- 
> 2.1.0
> 
> --

You can change the failure status from -1 to 1 if you wish, this is the 
normal value for EXIT_FAILURE

However the normal value for EXIT_SUCCESS is 0, so please do not change 
that.

Thanks

John
