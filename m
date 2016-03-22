From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/3] rt-migrate-test: fix return code
Date: Tue, 22 Mar 2016 15:22:57 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221522050.10687@riemann>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com> <1458239345-30892-2-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35701 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654AbcCVOXA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:23:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id r129so18197466wmr.2
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:22:59 -0700 (PDT)
In-Reply-To: <1458239345-30892-2-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

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
> index d7b68dd..1362404 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -599,9 +599,9 @@ int main (int argc, char **argv)
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

NAK - I've already told you this is wrong
0 is the normal value for exit_success, not 2
you can change the failure from -1 to 1 if you wish

John
