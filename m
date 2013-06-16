From: Stanislav Meduna <stano@meduna.org>
Subject: Re: [PATCH] mm: fix up a spurious page fault whenever it happens
Date: Sun, 16 Jun 2013 23:34:20 +0200
Message-ID: <51BE2F5C.8070408@meduna.org>
References: <5195ED8B.7060002@meduna.org>  <1369183168.6828.168.camel@gandalf.local.home>  <519CBB30.3060200@redhat.com>  <CA+55aFxMqvDvcVtLW-yD2PuU_CcjPOC30Zk07Kuk6S25WCzbHQ@mail.gmail.com>  <20130522134111.33a695c5@cuia.bos.redhat.com> <519D08B0.8050707@meduna.org> <1369246316.6828.176.camel@gandalf.local.home> <519D0CAB.7020800@meduna.org> <519D0FF8.5080200@redhat.com> <519D118B.6010306@zytor.com> <519D11BF.5000604@redhat.com> <519DCE2A.4010801@meduna.org> <519E095A.4000105@redhat.com> <519F24DD.5060700@meduna.org> <519F65DB.2020305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Hai Huang <hhuang@redhat.com>
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519F65DB.2020305@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

I was able to reproduce the page fault problem with
a relatively simple application, for now on the
Geode platform. It can be downloaded at

  http://www.meduna.org/tmp/PageFault.tar.gz

Basically the test application does:

- 4 threads that do nothing but periodically sleep
- 1 thread looping in a timerfd loop doing nothing
- 4 threads doing nonblocking TCP connects to an address
  in the local network that does not exist, i.e. all that
  happens are ARP requests.
- additionally a non-existing TCP congestion algorithm is
  requested resulting in repeated futile requests to load
  the module. This looks to be an important part in reproducing
  it, but the problem also occasionally happened with kernels
  that did not have modules enabled at all, so it is
  probably just pushing some probabilities.
- the application is statically linked - this might or might
  not be relevant, I just wanted the text-segment to be bigger

I know it is a weird mix, I was just trying to mimic what
our application did in the form that was able to trigger
the faults most often.

In my few tests this repeatably triggered the problem in hours,
max a day.

My feeling is that the problem is triggered best if there
is little network traffic and no other connections to the
machine, but this is only a subjective feeling.

The kernel configuration, cpuinfo, meminfo and lspci
are included in the tarball. The kernel configuration is not
very clean, it is a kernel intended to work on both Geode
and Celeron and is also a snapshot of what reproduced the
problem the best.

The environment is a current 3.4-rt with following tweaks:

 chrt -f -p 37 <pid of ksoftirqd/0>
 chrt -o -p 0 <pid of irq/14-pata>  [because of a pata_cs5536 bug]
 renice -15 <pid of irq/14-pata>
 ulimit -s 512

Before compiling change the CONNECT_ADDR define to an address
that is in the local LAN but is not present.

Other than this application a lightweight mix of usual Debian
processes is running. There are no servers except openssh and ntp.
A shell script that wakes each 2 seconds and does some
housekeeping is running, that probably recovers the system
when it enters the page-fault loop followed by the
RT throttling.

Right now a test with the same kernel with preempt none
is running to see whether the problem also happens with this
application there (due to the timing sensitivity only a positive
result has a significance). I did not have a chance to test
on an Intel processor yet.

Thanks
-- 
                                       Stano
