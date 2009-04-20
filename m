From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
Date: Mon, 20 Apr 2009 10:12:27 +0800
Message-ID: <1240193547.25532.52.camel@falcon>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <hofrat@hofr.at>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Zhang Le <r0bertz@gentoo.org>, linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:34757 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZDTCMy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Apr 2009 22:12:54 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi, all

I just update "RT_PREEMPT for loongson" to the latest RT_PREEMPT
(patch-2.6.29.1-rt8), welcome to pull & test it.

$ git clone git://dev.lemote.com/rt4ls.git
or
http://dev.lemote.com/http_git/rt4ls.git

this version include basic-RT support for mips, ftrace support for mips
(static function tracer/dynamic function tracer/function graph
tracer/system call tracer). 

* current status

the "system call tracer" need to fix when compiled in 64bit, because
there are several sys_call_table entries for different mips64
standards(o32, n32), currently, i only use the one in
arch/mips/kernel/scall64-o32.S via EXPORT(sys_call_table).

the "function graph tracer" is not stable under 100% load(lots of
"find /" background). 

best regards,
Wu Zhangjin

-- 
Wu Zhangjin
DSLab, Lanzhou University, China
www.lemote.com, Jiangsu Province, China

