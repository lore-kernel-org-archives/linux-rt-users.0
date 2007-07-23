From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Mon, 23 Jul 2007 18:04:42 +0200
Message-ID: <20070723160442.GA7995@elte.hu>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
	<46A4B7C2.1070304@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <46A4B7C2.1070304@free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Sender: oprofile-list-bounces@lists.sourceforge.net
Errors-To: oprofile-list-bounces@lists.sourceforge.net
List-Id: linux-rt-users.vger.kernel.org


* John Sigler <linux.kernel@free.fr> wrote:

> > ./trace-it 1 > trace.txt
> >
> > does it produce lots of trace entries? If not then 
> > CONFIG_FUNCTION_TRACING is not enabled. Once you see lots of output 
> > in the file, the tracer is up and running and you can start tracing 
> > the latency in your app.
> 
> # ./trace-it 1 >/tmp/trace.txt
> # wc /tmp/trace.txt
>   65555  393277 4096317 /tmp/trace.txt
> 
> preemption latency trace v1.1.5 on 2.6.20.7-rt8

>    <...>-939   0D...    0us : read_tsc (get_monotonic_cycles)

add 'notrace' to the definition of read_tsc in arch/i386/kernel/tsc.c. 
(check recent -rt's read_tsc() definition) (or do echo 1 > 
/proc/sys/kernel/trace_use_raw_cycles - if you are using recent enough 
-rt)

> >To track it down, use the method that trace-it.c uses to start/stop 
> >tracing, i.e. put the prctl(0,1); / prctl(0,0); calls into your app 
> >to start/stop tracing and the kernel will do the rest once you've set 
> >/proc/sys/kernel/preempt_max_latency back to 0: /proc/latency_trace 
> >will always contain the longest latency that your app triggered, of 
> >the critical path you programmed into it.
> 
> Here's what I came up with:
> http://linux.kernel.free.fr/latency/check_dektec_input3.cxx
> (I enable tracing only 1% of the time.)
> 
> The output looks very much like the one I got when I ran trace-it

> 1. Again, shouldn't there be other functions in the output?

there should be, once you fix read_tsc().

> 2. How much overhead do the prctl calls incur? Is it possible that 
> they are somehow masking my problem? (I'll let the program run all 
> night to maximize the chances of capturing the anomalous latency.)

it's not the prctl calls that matter but the fact that every kernel 
function will be traced if you have FUNCTION_TRACING on. It mask any 
races - but latencies are usually not masked (they are enlarged).

	Ingo

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
