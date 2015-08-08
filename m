From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 0/6] Linux 3.14.48-rt49-rc1
Date: Sat, 8 Aug 2015 19:10:17 -0400
Message-ID: <20150808231017.GG5998@windriver.com>
References: <20150806221736.555188732@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150806221736.555188732@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[[PATCH RT 0/6] Linux 3.14.48-rt49-rc1] On 06/08/2015 (Thu 18:17) Steven Rostedt wrote:

>
> Dear RT Folks,
>
> This is the RT stable review cycle of patch 3.14.48-rt49-rc1.
>
> Please scream at me if I messed something up. Please test the patches too.
>
> The -rc release will be uploaded to kernel.org and will be deleted when
> the final release is out. This is just a review release (or release candidate).
>
> The pre-releases will not be pushed to the git repository, only the
> final release is.
>
> If all goes well, this patch will be converted to the next main release
> on 8/10/2015.
>
> Note, these changes appear to make NO_HZ_FULL work as well as 3.18-rt does.

Appears to pass a simple sanity test here as well.  Built basically a
defconfig + RT_FULL + NOHZ_FULL + FHANDLE + DEVTMPFS and ran this simple
test "t" -- meant to test 1st NOHZ and then NOHZ_FULL (loaded core).

Bootargs (below) and irqaffine and rcu-affine scripts (also below) are
meant to dump all housekeeping crap onto core zero.

---------------------------------------
root@testbox:/home/paul# cat t
cat /proc/interrupts |grep LOC
sleep 5
cat /proc/interrupts |grep LOC

taskset -c 5 ./eatme &
sleep 5
cat /proc/interrupts |grep LOC
kill %
root@testbox:/home/paul# ./t
 LOC:     220787       1635       1614       1597       1579       1563       1543       1529       1512       1492       1414       1392       1375       1360       1342       1327       1307       1290       1277       1260   Local timer interrupts
 LOC:     225795       1637       1616       1597       1579       1563       1543       1529       1512       1492       1414       1392       1375       1362       1345       1329       1310       1293       1279       1262   Local timer interrupts
 LOC:     230800       1637       1616       1599       1582       1583       1545       1532       1514       1494       1416       1394       1377       1362       1345       1329       1310       1293       1279       1262   Local timer interrupts
root@testbox:/home/paul# jobs
root@testbox:/home/paul# cat /proc/version
Linux version 3.14.48-rt49-rc1-00071-g3fdc6bccf1b7 (paul@yow-dellw-pg2) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #1 SMP PREEMPT RT Sat Aug 8 15:08:25 EDT 2015
root@testbox:/home/paul# cat /proc/cmdline
root=/dev/sda2 ro console=ttyS0,115200 isolcpus=1-20 rcu_nocbs=1-20 rcu_nocb_poll nohz_full=1-20 irqaffinity=0 idle=poll tsc=perfect
root@testbox:/home/paul# cat no-rcu
for i in `pgrep rcuo` ; do taskset -c -p 0 $i ; done
root@testbox:/home/paul# cat clear-core
#!/bin/bash
# for all interrupting devices; move them to core zero; assumes that

for i in `cat /proc/interrupts | grep '^ *[0-9]*[0-9]:' |awk {'print $1}'|sed 's/:$//' `; do
        # Timer
        if [ "$i" = "0" ]; then
                continue
        fi
        # cascade
        if [ "$i" = "2" ]; then
                continue
        fi
        echo setting $i to affine for core zero
        echo 1 > /proc/irq/$i/smp_affinity
done
root@testbox:/home/paul#
---------------------------------------

So we took 20 IRQs in 5s, or 4/s ; not quite the 1/s minimum, but definitely not
the HZ/s we'd get w/o NOHZ_FULL.  Re-running it got consistently 18-20 IRQ / 5s.

I specifically did NOT unplug and replug cores to "clean" them of tasks; the
hotplug code just seems to unstable for that from what I've seen in the past,
and by the looks of the irq counts above, there was no need to either.

The rootfs was basically a ubu 14.10 server install (no X11/gfx) -- not that
it should matter - so long as other tasks weren't running on the nohz cores.

Paul.
--

>
> Enjoy,
>
> -- Steve
>
