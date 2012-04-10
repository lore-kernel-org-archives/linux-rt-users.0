From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.4-rc2-rt1
Date: Tue, 10 Apr 2012 16:47:28 -0700
Message-ID: <4F84C690.1010509@am.sony.com>
References: <alpine.LFD.2.02.1204101642050.2542@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:26480
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759715Ab2DJXry (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Apr 2012 19:47:54 -0400
In-Reply-To: <alpine.LFD.2.02.1204101642050.2542@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/10/12 07:46, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.4-rc2-rt1 release.
> 
> This is a straight forward update of the 3.2 series to 3.4-rc2. It's
> slightly smaller than the 3.2 series. I hope to stabilize it fast so I
> can concentrate on shuffling more parts of RT into 3.5.


Compile on the ARM panda fails because commit 615399c8 removed the defines of:

  cpu_online_map
  cpu_possible_map

These defines are used by posix-timers-thread-posix-cpu-timers-on-rt.patch


kernel/posix-cpu-timers.c: In function 'posix_cpu_thread_call':
kernel/posix-cpu-timers.c:1487: error: 'cpu_online_map' undeclared (first use in this function)
kernel/posix-cpu-timers.c:1487: error: (Each undeclared identifier is reported only once
kernel/posix-cpu-timers.c:1487: error: for each function it appears in.)
kernel/posix-cpu-timers.c: In function 'posix_cpu_thread_init':
kernel/posix-cpu-timers.c:1515: error: 'cpu_possible_map' undeclared (first use in this function)


This patch is a temporary workaround, putting back two of the defines removed
by commit 615399c8.


Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 include/linux/cpumask.h |    4 	4 +	0 -	0 !
 1 file changed, 4 insertions(+)

Index: b/include/linux/cpumask.h
===================================================================
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -764,6 +764,10 @@ static inline const struct cpumask *get_
  *
  */
 #ifndef CONFIG_DISABLE_OBSOLETE_CPUMASK_FUNCTIONS
+/* These strip const, as traditionally they weren't const. */
+#define cpu_possible_map	(*(cpumask_t *)cpu_possible_mask)
+#define cpu_online_map		(*(cpumask_t *)cpu_online_mask)
+
 #define cpumask_of_cpu(cpu) (*get_cpu_mask(cpu))
 
 #define CPU_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(NR_CPUS)

