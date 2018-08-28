From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Date: Mon, 27 Aug 2018 22:41:21 -0400
Message-ID: <20180827224121.2dc55b30@vmware.local.home>
References: <20180822141458.0b6b6af7@gandalf.local.home>
        <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
        <20180824121751.606659c9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Philip =?UTF-8?B?TcO8bGxlcg==?= <philm@manjaro.org>
To: Bernhard Landauer <oberon@manjaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824121751.606659c9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Aug 2018 12:17:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Aug 2018 18:14:43 +0200
> Bernhard Landauer <oberon@manjaro.org> wrote:
> 
> > Hello everyone,
> > 
> > for some reason I am not able to build 4.14.63-rt40 for Manjarolinux.
> > Even after removing all our custom patches build fails at
> > 
> >   LD [M]  drivers/gpu/drm/drm.o
> >   AR      drivers/gpu/built-in.o
> > make: *** [Makefile:1035: drivers] Error 2
> > 
> > My config can be found here for information:
> > https://gitlab.manjaro.org/packages/community/realtime-kernels/linux414-rt/raw/master/config.rt
> > 
> > Thank you for any advice!
> >  
> 
> Thanks for the report, I'll take a look.
> 

This appears to fix it:

-- Steve

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cedf225d4182..7df4cced6ac0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -35,6 +35,7 @@
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
+#include <linux/irq.h>
 
 #include <asm/hyperv.h>
 #include <asm/hypervisor.h>
