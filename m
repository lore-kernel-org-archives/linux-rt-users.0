From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kernel 2.6.19 -rt11 make failure on UP
Date: Mon, 11 Dec 2006 07:59:07 +0100
Message-ID: <20061211065907.GA28722@elte.hu>
References: <20061211065448.24824.qmail@web28006.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54679 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762605AbWLKHBA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Dec 2006 02:01:00 -0500
To: cinetic bellini <cinetic19@yahoo.de>
Content-Disposition: inline
In-Reply-To: <20061211065448.24824.qmail@web28006.mail.ukl.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* cinetic bellini <cinetic19@yahoo.de> wrote:

>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o: In function `do_IRQ':
> : undefined reference to `irq_show_regs_callback'
> make: *** [.tmp_vmlinux1] Error 1
> 
> I am not sure if I have to enable local APIC. So I tryed different 
> configurations but always with out success.

yeah, enabling APIC support should work around this build problem.

	Ingo
