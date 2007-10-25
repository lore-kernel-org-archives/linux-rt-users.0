From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: How to debug complete kernel lock-ups
Date: Wed, 24 Oct 2007 22:06:36 -0600
Message-ID: <20071025040636.GA3608@colo.lackof.org>
References: <471E1D3A.8000705@free.fr> <471F0DB4.1080709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761656AbXJYEHJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <471F0DB4.1080709@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 24, 2007 at 11:17:40AM +0200, John Sigler wrote:
...
> I've tested with a vanilla 2.6.22.10 kernel (no PREEMPT_RT patch).
> That system also locks up and remains completely unresponsive (I can't open 
> new ssh sessions, the system won't answer ICMP echo requests).
>
> How do driver writers deal with complete kernel hangs?

Use different HW. Both IA64 and PARISC gives useful diagnostics
when the machine has a hard crash (MCA or HPMC respectively). I'll bet
PPC does too on the POWER machines.

Maybe a newer x86 machine can provide some MCE data as well?

Otherwise it's what gregkh said...not the "we slowly go crazy"
part. :) Well, sometimes. :)

BTW, getting PCI bus traces would be quite helpful in this case.
It'll give you clear data as to whether the devices are being programmed
as expected (also to rule out chipset/Host bus controller issues) and
whether they are responding as expected (maybe something else dies
when they do).

hth,
grant

hth,
grant
