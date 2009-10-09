From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Fri, 9 Oct 2009 18:05:11 +0200
Message-ID: <200910091805.11249.arnd@arndb.de>
References: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933763AbZJIQGI@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 07 October 2009, John Kacur wrote:
> 
> I've been staring at the BKL lock in cpuid_open, and I can't see what it 
> is protecting. However, I may have missed something - even something 
> obvious, so comments are welcome.
> 

Hi John,

In general, the lock_kernel() calls in any chardev open() file operation
are the result of the BKL pushdown by Jon Corbet and others, which has happened
some time last year[1]. I'd assume that the vast majority is not needed
at all, so these are an easy target for removal.

	Arnd

[1] http://lkml.indiana.edu/hypermail/linux/kernel/0805.2/0257.html
