From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 00/11] [ANNOUNCE] 3.0.12-rt30-rc2
Date: Mon, 05 Dec 2011 03:58:19 +0100
Message-ID: <1323053899.5151.7.camel@marge.simson.net>
References: <20111204185444.411298317@goodmis.org>
	 <201112042113.37047.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201112042113.37047.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2011-12-04 at 21:13 +0100, Tim Sander wrote:
> Hi Steven
> > This is the RT stable review cycle of patch 3.0.12-rt30-rc2.
> > 
> > Please scream at me if I messed something up. Please test the patches too.
> Ok, this is a nearly blind shot, but i was expieriencing strange idle time 
> behaviour with this Ingo Molnar patch. The idle time was never incremented as 
> read from /proc/stat for several minutes. The system itself was behaving fine
> and had definetly not 100% load which was also verified with top.
> 
> I hadn't had the time to investigate further and my tests where with an ealier 
> release with the Ingo Molnar Tasklet patch on top.

Must be either config related, or something got fixed meanwhile.
rt30-rc1..

marge:~ # while sleep 1; do  grep cpu /proc/stat|grep -v cpu[0-3]; done
cpu  33066 90 10762 519426 36625 0 597 0 0 0
cpu  33110 90 10792 519643 36723 0 601 0 0 0
cpu  33149 91 10819 519869 36817 0 604 0 0 0
cpu  33189 91 10849 520099 36906 0 609 0 0 0
cpu  33231 92 10879 520329 36994 0 614 0 0 0
cpu  33273 92 10906 520561 37083 0 619 0 0 0
cpu  33312 93 10935 520789 37176 0 624 0 0 0
cpu  33356 93 10963 521017 37264 0 628 0 0 0
cpu  33394 94 10991 521250 37352 0 632 0 0 0
cpu  33435 95 11016 521478 37445 0 634 0 0 0
cpu  33480 96 11040 521700 37539 0 638 0 0 0
cpu  33517 96 11068 521911 37650 0 643 0 0 0
cpu  33551 97 11096 522113 37776 0 647 0 0 0
^C
marge:~ # 
