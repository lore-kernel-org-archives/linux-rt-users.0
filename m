From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
Date: Sun, 15 Dec 2013 13:59:33 +0100
Message-ID: <20131215125933.GB31090@linutronix.de>
References: <874n6muuw4.fsf@linux.vnet.ibm.com>
 <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-stable <stable@vger.kernel.org>
To: "Hong H. Pham" <hong.pham@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55496 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3LOM7j (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 07:59:39 -0500
Content-Disposition: inline
In-Reply-To: <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Hong H. Pham | 2013-12-07 09:06:33 [-0500]:

>On PPC32, only SMP kernels are affected.
>
>On PPC64, only SMP kernels with 4K page size are affected.

$ uname -a
Linux mpc8536-1 3.12.1-rt3-00281-g9de268d #76 SMP PREEMPT RT Fri Nov 22 16:53:05 CET 2013 ppc GNU/Linux
$ uptime
 22:01:10 up 22 days, 21:01,  1 user,  load average: 443.08, 563.59, 586.20

This is from a mpc8536 box. The high load comes from a hackbench that was
running for quite some time. Are Book-E (CONFIG_PPC_BOOK3E_MMU without
CONFIG_PPC_BOOK3E set) not affected or is this bug not present if a SMP
kernel is booted on a UP machine?

Sebastian
