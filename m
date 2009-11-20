From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: help needed, 2.6.31.6-rt19 hang with network user app
Date: Fri, 20 Nov 2009 15:56:12 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40419 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754083AbZKTVYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Nov 2009 16:24:53 -0500
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.11/8.12.11) with ESMTP id nAKKuH0e026016
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2009 12:56:17 -0800 (PST)
Received: from PALCAS01.lsi.com (palcas01.lsi.com [128.94.213.117])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id nAKKuLf3024434
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2009 12:56:21 -0800
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings:

I am hoping for some help troubleshooting a lockup related to networking. Apologies ahead for the detailed problem report and it is probably obvious I am a newbie to linux-rt, so this may or may not be the appropriate place to post this. Feel free to suggest the right location.   

Release:
FC10 release, 2.6.31.6-rt19 #1 SMP PREEMPT RT Wed Nov 18 22:20:20 CST 2009 i686 i686 i386 GNU/Linux
CPU core duo, T8400

Problem:
The problem does not occur when running FC10 release without RT patch.

I have three "threads" on the RT host A (affinity set to CPU0 - it seemed to work the best at reducing jitter):

Thread 1 (started using pthread, priority 49)
Start:
Set posix timer to expire in 5 msec
Output 128 packets (120 bytes each) to a single raw socket to Host B
Go to start

Thread 2 (run from main, priority 37)
Start:
Epoll for a single event on raw socket
Read one packet from Host B
Go to Start

Thread 3 (started from pthread, priority 25)
Print the rx and tx packet count

On other non-RT FC10 host B on network (connected by cisco gigE switch) the same thread is running, so they are exchanging packets. Usually I can get 30 minutes to 4 hours, and then the RT system hangs. Converting Host A to non-rt allows me to run 24 hours or more (no failures recorded). The application is meant to control packet jitter and RT does this well when it doesn't hang. I have also recorded instances of the RT system hanging when my app is not running, however, Host B is pounding the Host A interface with packets. This is more difficult to reproduce and believe I have encountered it only twice out of hundreds of tests.  I memlock about 100 Mbyte, only a fraction is used for the reduced test case.

Hang details:
1 The UI freezes. No keyboard or mouse. Graphics OK but screen freeze. 
2 Host B reports no data from Host A. When Host B is terminated and unplugged from network, the network card on Host A still blinks as if it is sending or receiving data. Unplugging Host A stops the blinking. Plugging A back in starts the blinking. I have waited up to 20 minutes or more and card still blinking.

Interrupts:
Note- I can make things better and worse by changing these settings, but am unable to resolve problem completely.
This is just last set-up I tried. I realize these may be incorrect and would appreciate some guidance.
This is heavy duty on network side so I have these at high priority. Mostly I am relying on ad-hoc & word of mouth on best settings.
It seems to be a black art. Same is true for stopped services.

I have tried both FF and RR settings.

irq rtc0 set to priority 90
irq eth0 not found.
irq eth1 set to priority 89
irq net-tx/0 set to priority 88
irq net-rx/0 set to priority 87
irq net-tx/1 set to priority 86
irq net-rx/1 set to priority 85
irq tasklet/0 set to priority 84
irq tasklet/1 set to priority 83
irq hrtimer/0 set to priority 82
irq hrtimer/1 set to priority 81
irq i8042 set to priority 20
irq bluetooth set to priority 19

Here is a sample of interrupts while things are working OK

  0:        371          7   IO-APIC-edge      timer
  1:          2          0   IO-APIC-edge      i8042
  4:          1          1   IO-APIC-edge
  7:          0          0   IO-APIC-edge      parport0
  8:         49         16   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          3          1   IO-APIC-edge      i8042
 16:        299      18241   IO-APIC-fasteoi   uhci_hcd:usb3, HDA Intel
 17:          0          1   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb7
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb8
 22:          1          2   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb5
 23:          0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb6
 24:    1228084          0  HPET_MSI-edge      hpet2
 25:          0    1744782  HPET_MSI-edge      hpet3
 31:       2288      53354   PCI-MSI-edge      ahci
 33:      56567      56124   PCI-MSI-edge      i915@pci:0000:00:02.0
 34:    8035113    7957293   PCI-MSI-edge      eth1
NMI:          0          0   Non-maskable interrupts
LOC:       1704       1593   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
PND:          0          0   Performance pending work
RES:   10942640   10060362   Rescheduling interrupts
CAL:       5795       2565   Function call interrupts
TLB:        108        158   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:         22         22   Machine check polls
ERR:          0
MIS:          0


Performance:
Here is top while things are working OK  (user app is called smash)

top - 11:25:27 up  1:48,  4 users,  load average: 0.00, 0.00, 0.00
Tasks: 173 total,   1 running, 171 sleeping,   0 stopped,   1 zombie
Cpu(s):  7.0%us,  9.5%sy,  0.0%ni, 76.3%id,  0.0%wa,  0.0%hi,  7.3%si,  0.0%st
Mem:   2004612k total,   590240k used,  1414372k free,    51744k buffers
Swap:  4030456k total,        0k used,  4030456k free,   257776k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
11190 root      -2  19  122m 122m 3088 S 32.9  6.3   6:48.44 smash
    7 root     -88  -5     0    0    0 S  8.0  0.0   1:43.43 sirq-net-rx/0
   21 root     -86  -5     0    0    0 S  7.6  0.0   4:11.65 sirq-net-rx/1
 9032 root     -90  -5     0    0    0 S  1.7  0.0   0:16.97 irq/34-eth1
    1 root      20   0  2008  772  564 S  0.0  0.0   0:02.37 init
    2 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 kthreadd
    3 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 migration/0
    4 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-high/0
    5 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-timer/0
    6 root     -89  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-net-tx/0
    8 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-block/0
    9 root     -85  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-tasklet/0
   10 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-sched/0
   11 root     -83  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-hrtimer/0
   12 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-rcu/0
   13 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 posixcputmr/0
   14 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 watchdog/0
   15 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 desched/0
   16 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 migration/1
   17 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 posixcputmr/1
   18 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-high/1
   19 root     -50  -5     0    0    0 S  0.0  0.0   0:01.08 sirq-timer/1
   20 root     -87  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-net-tx/1
   22 root     -50  -5     0    0    0 S  0.0  0.0   0:00.14 sirq-block/1
   23 root     -84  -5     0    0    0 S  0.0  0.0   0:00.02 sirq-tasklet/1
   24 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-sched/1
   25 root     -82  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-hrtimer/1
   26 root     -50  -5     0    0    0 S  0.0  0.0   0:00.00 sirq-rcu/1
   27 root      RT  -5     0    0    0 S  0.0  0.0   0:00.00 watchdog/1
   28 root      10 -10     0    0    0 S  0.0  0.0   0:00.01 desched/1
   29 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 rcu_sched_grace
   30 root      -2 -20     0    0    0 S  0.0  0.0   0:00.00 events/0
   31 root      -2 -20     0    0    0 S  0.0  0.0   0:00.19 events/1
   32 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 cpuset
   33 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 khelper
   38 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 async/mgr
  161 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 kintegrityd/0
  162 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 kintegrityd/1
  164 root      15  -5     0    0    0 S  0.0  0.0   0:00.00 kblockd/0


Services:
Here is a list of services and status.

(Some services respond to status from my script with no text output and a "0" return, so 
I call these unable to determine, but they are really dead.)

initd acpid is stopped.
initd anacron is stopped.
initd atd is stopped.
initd auditd is started.
initd avahi-daemon is stopped.
initd bluetooth is stopped.
initd btseed is stopped.
initd bttrack is stopped.
initd cpuspeed is stopped.
initd crond is started.
initd cups is stopped.
initd cups-config-daemon is stopped.
initd dnsmasq is stopped.
initd firstboot is stopped.
initd fuse is started.
initd gpm is stopped.
initd haldaemon is started.
initd halt is stopped.
initd httpd is stopped.
initd ip6tables is stopped.
initd iptables is started.
initd irda is stopped.
initd irqbalance is stopped.
initd jetty is stopped.
initd kerneloops is stopped.
initd killall is stopped.
initd lm_sensors is stopped.
initd mdmonitor is stopped.
initd messagebus is started.
initd microcode_ctl unable to determine state.
initd multipathd is stopped.
initd netconsole is stopped.
initd netfs is stopped.
initd netplugd is stopped.
initd network is started.
initd NetworkManager is stopped.
initd nfs is stopped.
initd nfslock is stopped.
initd nmb is stopped.
initd nscd is stopped.
initd ntpd is stopped.
initd ntpdate is stopped.
initd pcscd is stopped.
initd portreserve is stopped.
initd psacct is stopped.
initd rdisc is stopped.
initd restorecond unable to determine state.
initd rpcbind is stopped.
initd rpcgssd is stopped.
initd rpcidmapd is started.
initd rpcsvcgssd is stopped.
initd rsyslog is stopped.
initd saslauthd is stopped.
initd sendmail is stopped.
initd setroubleshoot is stopped.
initd smartd is stopped.
initd smb is stopped.
initd smolt is stopped.
initd snmpd is stopped.
initd snmptrapd is stopped.
initd sshd is started.
initd udev-post unable to determine state.
initd winbind is stopped.
initd wpa_supplicant is stopped.
initd xinetd is stopped.
initd ypbind is stopped.

Timers:
OK - one thing that confuses me is the timer/clock situation
Any help here on the best settings is appreciated.

I see the following timers - any guidance on implications of changing priority of these?
sirq-timer
sirq-hrtimer
posixcputimer
rtc0
HPET (same as hrtimer?)

APIC:
I'm also confused about this - what is the best state for these services? It doesn't look like APIC is running. APIC interrupts are occurring however, I did include thermal and cpu modules when the kernel was built; everything else excluded. 

Many thanks for anyone who has made it this far and still willing to offer some suggestions on helping me debug.

-Bob




