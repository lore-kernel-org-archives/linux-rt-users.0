From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf and oprofile causing kernel oops on 2.6.33.7-rt29 kernel
Date: Fri, 27 Aug 2010 11:45:43 +0200
Message-ID: <1282902343.1975.2024.camel@laptop>
References: <8EA2C2C4116BF44AB370468FBF85A777017965B296@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: "Sydir, Jerry" <jerry.sydir@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36337 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab0H0Jpq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Aug 2010 05:45:46 -0400
In-Reply-To: <8EA2C2C4116BF44AB370468FBF85A777017965B296@orsmsx504.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-08-18 at 12:31 -0700, Sydir, Jerry wrote:

> I am having trouble running profiling tools on the 2.6.33.7 kernel
> with the rt29 patch. I am running on an Intel Core 2 machine. 

Then run a 64bit kernel already, seriously, your employer didn't spend
all that silicon just so you could run 32bit crap.

> When I run perf record I get a kernel oops. Here is the relevant log
> info:
> 
> BUG: sleeping function called from invalid context at arch/x86/mm/highmem_32.c:9
> pcnt: 14010003 0 in_atomic(): 1, irqs_disabled(): 1, pid: 3640, name: perf
> Pid: 3640, comm: perf Not tainted 2.6.33.7-rt29 #3
> Call Trace:
> [<c101d0c3>] ? kmap+0x41/0x52
> [<c100b66e>] ? perf_callchain+0x20d/0x2ac
> [<c106abd9>] ? perf_prepare_sample+0x1d1/0x23b
> [<c106ce0b>] ? __perf_event_overflow+0x20a/0x25e
> [<c106d4bc>] ? perf_event_overflow+0xf/0x12
> [<c100c906>] ? intel_pmu_handle_irq+0x1fd/0x25d
> [<c100b7a3>] ? intel_pmu_enable_all+0x3d/0xae
> [<c1386478>] ? perf_event_nmi_handler+0x34/0x3f

The below might cure that.

--- 
 arch/x86/kernel/cpu/perf_event.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 16307ff..4c178c3 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -2480,9 +2480,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
 		offset = addr & (PAGE_SIZE - 1);
 		size = min(PAGE_SIZE - offset, n - len);
 
-		map = kmap_atomic(page, type);
+		map = kmap_atomic_direct(page, type);
 		memcpy(to, map+offset, size);
-		kunmap_atomic(map, type);
+		kunmap_atomic_direct(map, type);
 		put_page(page);
 
 		len  += size;

