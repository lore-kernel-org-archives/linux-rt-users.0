From: John Sigler <linux.kernel@free.fr>
Subject: Pin-pointing the root of unusual application latencies
Date: Thu, 12 Jul 2007 12:22:47 +0200
Message-ID: <469600F7.3060603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
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

[ Note: cross-posted to linux-rt-users and oprofile-list ]

Hello,

I'm running kernel 2.6.20.7-rt8 on x86 (1267-MHz P3) with the
following debug options:

CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_MUST_CHECK is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_STACKTRACE=3Dy
CONFIG_EVENT_TRACE=3Dy
CONFIG_FUNCTION_TRACE=3Dy
CONFIG_WAKEUP_TIMING=3Dy
CONFIG_LATENCY_TRACE=3Dy
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
CONFIG_WAKEUP_LATENCY_HIST=3Dy
CONFIG_LATENCY_TIMING=3Dy
CONFIG_LATENCY_HIST=3Dy
CONFIG_MCOUNT=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_FRAME_POINTER=3Dy
CONFIG_UNWIND_INFO=3Dy
CONFIG_STACK_UNWIND=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_DOUBLEFAULT=3Dy

http://linux.kernel.free.fr/latency/config-2.6.20.7-rt8-adlink-latency

Here's my situation:

A SCHED_RR process with priority 80 is performing blocking reads of =

1316-byte chunks from a PCI device. The data comes in at ~38 Mbit/s.

Therefore, in a perfect world, my process would wake up periodically =

every 1316*8 / 38e6 =3D 277 =B5s to handle the latest chunk.

However, periodically, my process blocks up to 400 =B5s instead of 277 =B5s.
Naturally, the next iteration, my process blocks less than 277 =B5s (the =

PCI board has 1316 bytes ready every 277 =B5s regardless).

I've captured a histogram of read latencies.
It is expressed in units of 512 ns.
e.g. there were 23,126,460 occurences of LAT=3D278 =B5s (543 * 512 ns)
http://linux.kernel.free.fr/latency/histogram.txt
http://linux.kernel.free.fr/latency/read_latency.png

The system is otherwise completely idle. In other words, 100% of the CPU =

is dedicated to the single task of waiting for an interrupt request, =

servicing it, and pushing the data to user land.

I used OProfile to frequently sample the instruction pointer while my =

application ran all night long.

http://linux.kernel.free.fr/latency/oprofile_report_all_night.txt

CPU: PIII, speed 1266.7 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a =

unit mask of 0x00 (No unit mask) count 60000
samples      %      symbol name
958075714  90.6470   default_idle
25637397    2.4256   mask_and_ack_8259A
10697948    1.0122   __copy_to_user_ll
9345347     0.8842   oprofiled
9246368     0.8748   Dta1xxIsr
6732131     0.6370   enable_8259A_irq
5153650     0.4876   __schedule
1873157     0.1772   irq_entries_start
1729897     0.1637   increment_tail
1565354     0.1481   clock_gettime
1429908     0.1353   Dta1xxDmaTransfer
1428107     0.1351   ioread16
1252095     0.1185   system_call
1081768     0.1023   try_to_wake_up
983687      0.0931   cpu_idle

I thought default_idle called HLT via safe_halt(). Since I'm only =

counting UNHALTED clock cycles, I'm surprised to see so many samples =

taken in default_idle. Does someone understand that?

Is it possible that one of these functions periodically delays the =

delivery of data to my SCHED_RR application?

Here's a /proc/latency_trace dump. What is there to understand?

# cat /proc/latency_trace
preemption latency trace v1.1.5 on 2.6.20.7-rt8
--------------------------------------------------------------------
  latency: 26 us, #2/2, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
     -----------------
     | task: softirq-timer/0-4 (uid:0 nice:0 policy:1 rt_prio:50)
     -----------------

                  _------=3D> CPU#
                 / _-----=3D> irqs-off
                | / _----=3D> need-resched
                || / _---=3D> hardirq/softirq
                ||| / _--=3D> preempt-depth
                |||| /
                |||||     delay
    cmd     pid ||||| time  |   caller
       \   /    |||||   \   |   /
    <...>-4     0D..1   26us : trace_stop_sched_switched =

(__sched_text_start)


vim:ft=3Dhelp

Is there a different diagnostic I can run to tell why data delivery
to my app is periodically delayed 100 =B5s?

# cat /proc/latency_hist/wakeup_latency/CPU0
#Minimum latency: 0 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 26 microseconds.
#Total samples: 14925698
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
     0            3682745
     1            9487737
     2            1748372
     3               1192
     4               3689
     5                 50
     6                 14
     7                 14
     8                  9
     9                 46
    10                995
    11                799
    12                  6
    13                  8
    14                  4
    15                  6
    16                  3
    17                  0
    18                  1
    19                  0
    20                  0
    21                  0
    22                  3
    23                  1
    24                  0
    25                  1
    26                  3

I would think that I might have a clearer picture if I could request the =

last N instruction pointer samples from OProfile, to figure out what the =

CPU has been doing for the past several hundred =B5s.

Regards.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
