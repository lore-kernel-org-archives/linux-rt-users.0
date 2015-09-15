From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 4/9] signaltest: drop unused tsnorm()
Date: Wed, 16 Sep 2015 00:00:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509152356090.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <ce9b5fb3e680b9a355142dd91d54ce1fb02ae664.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32972 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbIOWAU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 18:00:20 -0400
Received: by wiclk2 with SMTP id lk2so47741340wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 15:00:19 -0700 (PDT)
In-Reply-To: <ce9b5fb3e680b9a355142dd91d54ce1fb02ae664.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> tsnorm() is not used at all in signaltest.  Remove it.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/signaltest/signaltest.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 9454a26..c6d1cfd 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -69,14 +69,6 @@ static int shutdown;
>  static int tracelimit = 0;
>  static int oldtrace = 0;
>  
> -static inline void tsnorm(struct timespec *ts)
> -{
> -	while (ts->tv_nsec >= NSEC_PER_SEC) {
> -		ts->tv_nsec -= NSEC_PER_SEC;
> -		ts->tv_sec++;
> -	}
> -}
> -
>  static inline long calcdiff(struct timespec t1, struct timespec t2)
>  {
>  	long diff;
> -- 
> 2.5.0
> 
> --

As you can see, many of the programs in this suite are modeled after 
cyclictest, but many of them don't unfortunately receive nearly the 
amount of testing that cyclictest does. Now the fact that this function 
was copied from cyclictest, but not used, sends off alarm bells in my 
head. We have various struct timespec in signaltest, could the fact that 
we are not calling tsnorm mean that there are some hidden potential 
defects? Rather than removing this function, I'd like to spend some time 
auditing the use of timespec here until I'm convinced.

Thanks

John
