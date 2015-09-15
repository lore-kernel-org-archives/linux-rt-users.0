From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 6/9] cyclictest: drop impossible use_fifo
 conditional
Date: Wed, 16 Sep 2015 00:24:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509160023580.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <6eca77cc0906aece69c31603b39a35c5e2f5e3c9.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38837 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIOWYU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 18:24:20 -0400
Received: by wiclk2 with SMTP id lk2so46508423wic.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 15:24:18 -0700 (PDT)
In-Reply-To: <6eca77cc0906aece69c31603b39a35c5e2f5e3c9.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> The fifothread is only created when use_fifo is set; having the thread
> itself perform a check is redundant and unnecessary.  Drop it.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/cyclictest.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index dc754fd..896cdd7 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1773,9 +1773,6 @@ static void *fifothread(void *param)
>  	FILE *fp;
>  	int i;
>  
> -	if (use_fifo == 0)
> -		return NULL;
> -
>  	unlink(fifopath);
>  	ret = mkfifo(fifopath, 0666);
>  	if (ret) {
> -- 
> 2.5.0
> 
> --
Signed-off-by: John Kacur <jkacur@redhat.com>
