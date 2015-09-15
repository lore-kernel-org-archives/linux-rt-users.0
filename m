From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 7/9] cyclictest: fail if use_fifo && thread
 creation failed
Date: Wed, 16 Sep 2015 00:25:51 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509160025320.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <73a350e379f58fc06c879a6389dec78cb18ca3c7.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35504 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbIOWZx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 18:25:53 -0400
Received: by wicge5 with SMTP id ge5so49053399wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 15:25:52 -0700 (PDT)
In-Reply-To: <73a350e379f58fc06c879a6389dec78cb18ca3c7.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/cyclictest.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 896cdd7..2c44f8e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2058,8 +2058,11 @@ int main(int argc, char **argv)
>  			fatal("failed to create thread %d: %s\n", i, strerror(status));
>  
>  	}
> -	if (use_fifo)
> +	if (use_fifo) {
>  		status = pthread_create(&fifo_threadid, NULL, fifothread, NULL);
> +		if (status)
> +			fatal("failed to create fifo thread: %s\n", strerror(status));
> +	}
>  
>  	while (!shutdown) {
>  		char lavg[256];
> -- 
> 2.5.0
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>
