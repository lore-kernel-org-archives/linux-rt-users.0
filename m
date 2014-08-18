From: Michael <dev@michaeljones.de>
Subject: Re: [PATCH 5/6] cyclictest: Fix help for long options only
Date: Mon, 18 Aug 2014 22:26:07 +0200
Message-ID: <53F2615F.3090007@michaeljones.de>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com> <1408033090-24866-6-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:40391 "HELO
	gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751903AbaHRU0R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Aug 2014 16:26:17 -0400
In-Reply-To: <1408033090-24866-6-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

I submitted an almost identical patch to this one a few weeks ago, but 
haven't heard anything:
http://www.spinics.net/lists/linux-rt-users/msg12140.html

I thought I might follow-up with some more patches to bring the 
comments/docs in sync with the code, but I didn't see anything happening 
with my first submission, so I haven't bothered.

What to do?  Can I resubmit mine to add the one change you made which I 
didn't (--notrace)?

Michael

On 08/14/2014 06:18 PM, John Kacur wrote:
> At some point in the history of cyclictest, a number of short options
> were removed and changed to long only options. However the display_help
> was not updated to reflect this and indicates short options that
> no longer exist. Fix this. I also found a long option that wasn't listed
> at all and added that.
>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>   src/cyclictest/cyclictest.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index ad7890ffaa95..b45041e01f3a 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1009,7 +1009,7 @@ static void display_help(int error)
>   	       "-D       --duration=t      specify a length for the test run\n"
>   	       "                           default is in seconds, but 'm', 'h', or 'd' maybe added\n"
>   	       "                           to modify value to minutes, hours or days\n"
> -	       "-e       --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
> +	       "	 --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
>   	       "-E       --event           event tracing (used with -b)\n"
>   	       "-f       --ftrace          function trace (when -b is active)\n"
>   	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
> @@ -1023,13 +1023,14 @@ static void display_help(int error)
>   	       "-m       --mlockall        lock current and future memory allocations\n"
>   	       "-M       --refresh_on_max  delay updating the screen until a new max latency is hit\n"
>   	       "-n       --nanosleep       use clock_nanosleep\n"
> +	       "	 --notrace	   suppress tracing\n"
>   	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>   	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
>   	       "-O TOPT  --traceopt=TOPT   trace option\n"
>   	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>   	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
>   	       "-q       --quiet           print only a summary on exit\n"
> -	       "-Q       --priospread       spread priority levels starting at specified value\n"
> +	       "	 --priospread       spread priority levels starting at specified value\n"
>   	       "-r       --relative        use relative timer instead of absolute\n"
>   	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
>   	       "                           times.  list of clock_gettime() values will be\n"
> @@ -1052,8 +1053,8 @@ static void display_help(int error)
>   	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
>   	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
>   	       "-W       --wakeuprt        rt task wakeup tracing (used with -b)\n"
> -	       "-X       --dbg_cyclictest  print info useful for debugging cyclictest\n"
> -	       "-y POLI  --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
> +	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\n"
> +	       "	 --policy=POLI     policy of realtime thread, POLI may be fifo(default) or rr\n"
>   	       "                           format: --policy=fifo(default) or --policy=rr\n",
>   	       tracers
>   		);
>
