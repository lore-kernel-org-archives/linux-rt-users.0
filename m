From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 1/9] cyclictest: consistently make all functions
 'static'
Date: Wed, 2 Sep 2015 15:03:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509021503240.19826@riemann>
References: <cover.1441038216.git.joshc@ni.com> <60a552bb4d5fabbc615cf31f3533b696e30e7d5f.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35799 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbbIBNDz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 09:03:55 -0400
Received: by wicge5 with SMTP id ge5so40176055wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Sep 2015 06:03:54 -0700 (PDT)
In-Reply-To: <60a552bb4d5fabbc615cf31f3533b696e30e7d5f.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> Most functions in cyclictest were already 'static', with a few
> exceptions.  Fixup those exceptions, in the interest of consistency,
> optimization, etc.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/cyclictest.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 34053c5..9aebe32 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -392,7 +392,7 @@ static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
>  	return diff;
>  }
>  
> -void traceopt(char *option)
> +static void traceopt(char *option)
>  {
>  	char *ptr;
>  	if (traceopt_count + 1 > traceopt_size) {
> @@ -442,7 +442,7 @@ static void tracemark(char *fmt, ...)
>  
>  
>  
> -void tracing(int on)
> +static void tracing(int on)
>  {
>  	if (on) {
>  		switch (kernelversion) {
> @@ -638,7 +638,7 @@ static void setup_tracer(void)
>   *
>   * the return value is a value in seconds
>   */
> -int parse_time_string(char *val)
> +static int parse_time_string(char *val)
>  {
>  	char *end;
>  	int t = strtol(val, &end, 10);
> @@ -749,7 +749,7 @@ try_again:
>   * - CLOCK_REALTIME
>   *
>   */
> -void *timerthread(void *param)
> +static void *timerthread(void *param)
>  {
>  	struct thread_param *par = param;
>  	struct sched_param schedp;
> @@ -1766,7 +1766,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
>   * thread that creates a named fifo and hands out run stats when someone
>   * reads from the fifo.
>   */
> -void *fifothread(void *param)
> +static void *fifothread(void *param)
>  {
>  	int ret;
>  	int fd;
> -- 
> 2.5.0
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>
