From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2] sched/completion: convert completions to use simple
 wait queues
Date: Thu, 12 May 2016 16:08:34 +0200
Message-ID: <fa94c34f-31ea-84fd-ac9f-52ed59c31d12@monom.org>
References: <1461848244-16469-1-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461848244-16469-1-git-send-email-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/28/2016 02:57 PM, Daniel Wagner wrote:
> As one can see above in the swait_stat output, the fork() path is
> using completion. A histogram of a fork bomp (1000 forks) benchmark
> shows a slight performance drop by 4%.
> 
> [wagi@handman completion-test-5 (master)]$ cat forky-4.6.0-rc4.txt | perl histo -min 0.12 -max 0.20 -int 0.01 -stars -scale 10
> # NumSamples = 1000; Max = 0.208; Min = 0.123
> # Mean = 0.146406; Variance = 0.000275351163999956; SD = 0.0165937085668019
> # Each * represents a count of 10
>      0.1200 - 0.1300 [   113]: ************
>      0.1300 - 0.1400 [   324]: *********************************
>      0.1400 - 0.1500 [   219]: **********************
>      0.1500 - 0.1600 [   139]: **************
>      0.1600 - 0.1700 [    94]: **********
>      0.1700 - 0.1800 [    54]: ******
>      0.1800 - 0.1900 [    37]: ****
>      0.1900 - 0.2000 [    18]: **
> 
> [wagi@handman completion-test-5 (master)]$ cat forky-4.6.0-rc4-00001-g0a16067.txt | perl histo -min 0.12 -max 0.20 -int 0.01 -stars -scale 10
> # NumSamples = 1000; Max = 0.207; Min = 0.121
> # Mean = 0.152056; Variance = 0.000295474863999994; SD = 0.0171893823042014
> # Each * represents a count of 10
>      0.1200 - 0.1300 [    17]: **
>      0.1300 - 0.1400 [   282]: *****************************
>      0.1400 - 0.1500 [   240]: ************************
>      0.1500 - 0.1600 [   158]: ****************
>      0.1600 - 0.1700 [   114]: ************
>      0.1700 - 0.1800 [    94]: **********
>      0.1800 - 0.1900 [    66]: *******
>      0.1900 - 0.2000 [    25]: ***
>      0.2000 - 0.2100 [     1]: *


I redid the above test and changed my fork bomb to this:

	for (i = 0; i < MAX_CHILDREN; i++) {
		switch(fork()) {
		case -1:
			exit(1);
		case 0:
			_exit(0);
		}
	}

	for (i = 0; i < MAX_CHILDREN; i++) {
		do {
			pid = waitpid(-1, &status, WUNTRACED );
			if (pid < 0 && errno != ECHILD)
				exit(1);
		} while (!WIFEXITED(status) && !WIFSIGNALED(status));
	}

Obviously, fork is not a very good benchmark since we might end up
into memory allocation etc. The distribution I get from baseline and
this batch look very similiar:

[wagi@handman completion (master)]$ cat results/forky-4.6.0-rc4.txt  | perl histo -min 0.09 -max 0.11 -int 0.001 -stars -scale 100
     0.0910 - 0.0920 [     3]: *
     0.0920 - 0.0930 [     8]: *
     0.0930 - 0.0940 [    52]: *
     0.0940 - 0.0950 [   404]: *****
     0.0950 - 0.0960 [  1741]: ******************
     0.0960 - 0.0970 [  2221]: ***********************
     0.0970 - 0.0980 [  1612]: *****************
     0.0980 - 0.0990 [  1346]: **************
     0.0990 - 0.1000 [  1223]: *************
     0.1000 - 0.1010 [   724]: ********
     0.1010 - 0.1020 [   362]: ****
     0.1020 - 0.1030 [   186]: **
     0.1030 - 0.1040 [    71]: *
     0.1040 - 0.1050 [    29]: *
     0.1050 - 0.1060 [    12]: *
     0.1060 - 0.1070 [     4]: *
     0.1080 - 0.1090 [     2]: *

[wagi@handman completion (master)]$ cat results/forky-4.6.0-rc4-00001-gc4c770c.txt  | perl histo -min 0.09 -max 0.11 -int 0.001 -stars -scale 100
     0.0930 - 0.0940 [     3]: *
     0.0940 - 0.0950 [     9]: *
     0.0950 - 0.0960 [    25]: *
     0.0960 - 0.0970 [    77]: *
     0.0970 - 0.0980 [   324]: ****
     0.0980 - 0.0990 [  1503]: ****************
     0.0990 - 0.1000 [  2247]: ***********************
     0.1000 - 0.1010 [  1708]: ******************
     0.1010 - 0.1020 [  1486]: ***************
     0.1020 - 0.1030 [  1215]: *************
     0.1030 - 0.1040 [   729]: ********
     0.1040 - 0.1050 [   368]: ****
     0.1050 - 0.1060 [   197]: **
     0.1060 - 0.1070 [    65]: *
     0.1070 - 0.1080 [    32]: *
     0.1080 - 0.1090 [     7]: *
     0.1090 - 0.1100 [     2]: *

A t-test (determine if two sets of data are significantly different)
returns a p value of 0 (< 1%). That means we reject the null
hypothesis of equal avarages. That means we have a 0.3% decrease in
perforamnce compared with the baseline.

 
> Compiling a kernel 100 times results in following statistics gather
> by 'time make -j200'
> 
> user
>                                         mean                std                var                max                min
>                kernbech-4.6.0-rc4      9.126             0.2919            0.08523               9.92               8.55
>    kernbech-4.6.0-rc4-00001-g0...       9.24  -1.25%     0.2768   5.17%    0.07664  10.07%      10.11  -1.92%       8.44   1.29%
> 
> 
> system
>                                         mean                std                var                max                min
>                kernbech-4.6.0-rc4  1.676e+03              2.409              5.804          1.681e+03          1.666e+03
>    kernbech-4.6.0-rc4-00001-g0...  1.675e+03   0.07%      2.433  -1.01%      5.922  -2.03%  1.682e+03  -0.03%   1.67e+03  -0.20%
> 
> 
> elapsed
>                                         mean                std                var                max                min
>                kernbech-4.6.0-rc4  2.303e+03              26.67              711.1          2.357e+03          2.232e+03
>    kernbech-4.6.0-rc4-00001-g0...  2.298e+03   0.23%      28.75  -7.83%      826.8 -16.26%  2.348e+03   0.38%  2.221e+03   0.49%
> 
> 
> CPU
>                                         mean                std                var                max                min
>                kernbech-4.6.0-rc4  4.418e+03               48.9          2.391e+03          4.565e+03          4.347e+03
>    kernbech-4.6.0-rc4-00001-g0...  4.424e+03  -0.15%      55.73 -13.98%  3.106e+03 -29.90%  4.572e+03  -0.15%  4.356e+03  -0.21%
> 
> 
> While the mean is slightly less the var and std are increasing quite
> noticeable.

The idea behind doing the kernel builds is that I wanted to see if 
there is an impact observable from a real work load. The above numbers are hard
to interpret, though if you only look at the elapsed time you see it takes
slightly longer. I repeated this test with 500 runs and the numbers I get
are the same as above. So at least it is consisted and repeatable experiment.

Obviously, I tried to micro benchmark what's going on, but so far I
have had any luck. A  kernel module which has two threads which do a 
ping-pong completion test, A typical trace looks like this:

         trigger-2376  [000]   218.982609: sched_waking:         comm=waiter/0 pid=2375 prio=120 target_cpu=000
         trigger-2376  [000]   218.982609: sched_stat_runtime:   comm=trigger pid=2376 runtime=1355 [ns] vruntime=40692621118 [ns]
         trigger-2376  [000]   218.982609: sched_wakeup:         waiter/0:2375 [120] success=1 CPU:000
         trigger-2376  [000]   218.982610: rcu_utilization:      Start context switch
         trigger-2376  [000]   218.982610: rcu_utilization:      End context switch
         trigger-2376  [000]   218.982610: sched_stat_runtime:   comm=trigger pid=2376 runtime=1072 [ns] vruntime=40692622190 [ns]
         trigger-2376  [000]   218.982611: sched_switch:         trigger:2376 [120] S ==> waiter/0:2375 [120]
        waiter/0-2375  [000]   218.982611: latency_complete:     latency=2285
        waiter/0-2375  [000]   218.982611: sched_waking:         comm=trigger pid=2376 prio=120 target_cpu=000
        waiter/0-2375  [000]   218.982611: sched_stat_runtime:   comm=waiter/0 pid=2375 runtime=1217 [ns] vruntime=40692622747 [ns]
        waiter/0-2375  [000]   218.982612: sched_wakeup:         trigger:2376 [120] success=1 CPU:000
        waiter/0-2375  [000]   218.982612: rcu_utilization:      Start context switch
        waiter/0-2375  [000]   218.982612: rcu_utilization:      End context switch
        waiter/0-2375  [000]   218.982612: sched_stat_runtime:   comm=waiter/0 pid=2375 runtime=1099 [ns] vruntime=40692623846 [ns]
        waiter/0-2375  [000]   218.982613: sched_switch:         waiter/0:2375 [120] S ==> trigger:2376 [120]


I have plotted the latency_complete (the time it takes from complete()
till the waiter is running)

https://www.monom.org/data/completion/completion-latency.png

The stats for the above plot are:

[wagi@handman results (master)]$ csvstat-3 completion-latency-4.6.0-rc4.txt
  1. 805
        <class 'int'>
        Nulls: False
        Min: 643
        Max: 351709
        Sum: 3396063015
        Mean: 715.6573082933786
        Median: 706.0
        Standard Deviation: 385.24467795803787
        Unique values: 4662
        5 most frequent values:
                697:    121547
                703:    120730
                693:    112609
                699:    112543
                701:    112370

Row count: 4745376
[wagi@handman results (master)]$ csvstat-3 completion-latency-4.6.0-rc4-00001-gc4c770c.txt
  1. 4949
        <class 'int'>
        Nulls: False
        Min: 660
        Max: 376049
        Sum: 3417112614
        Mean: 710.0990997187752
        Median: 696
        Standard Deviation: 500.7461712849926
        Unique values: 4930
        5 most frequent values:
                693:    188698
                689:    165564
                692:    158333
                688:    156896
                684:    155032

Row count: 4812163


In short, I haven't figured out yet why the kernel builds get slightly slower. 
The first idea that the fork path is a problem is not 'proofable' with the
the fork bomb. At least if it is executed in a tight loop.

cheers,
daniel
