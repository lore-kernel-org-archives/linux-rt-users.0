From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.28-rt on PowerPC
Date: Fri, 30 Jan 2009 13:11:50 +1100
Message-ID: <1233281510.18767.17.camel__43042.9222215482$1233281725$gmane$org@pasglop>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: avorontsov@ru.mvista.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759802AbZA3CNp@vger.kernel.org>
In-Reply-To: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> This is trivially solved by converting arch/powerpc/sysdev/ipic.c
> back to spinlocks (ipic_lock).
> 
> Assuming that converting-back is automatic, there are few other
> chained interrupt controllers you might want to convert-back:
> 
> arch/powerpc/sysdev/i8259.c (i8259_lock)
> arch/powerpc/sysdev/mpic.c (mpic_lock)
> arch/powerpc/sysdev/qe_lib/qe_ic.c (qe_ic_lock)

Except that a bunch of those can be both primary and chained... It's
simply not a solution to have to "convert" interrupt controller code to
use a different locking scheme depending on whether they are chained or
primary...

Cheers,
Ben.
