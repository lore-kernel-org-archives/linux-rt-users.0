From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] kexec: reenable HPET before kexec
Date: Mon, 27 Aug 2007 11:06:56 +0530
Message-ID: <20070827053656.GC9809@in.ibm.com>
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru> <20070823090845.GA13065@in.ibm.com> <20070823154936.3b7ae498@windmill.dev.rtsoft.ru>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andi Kleen <ak@suse.de>
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754217AbXH0FhR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070823154936.3b7ae498@windmill.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 23, 2007 at 03:49:36PM +0400, Konstantin Baydarov wrote:
> On Thu, 23 Aug 2007 14:38:45 +0530
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > Does your kernel 2 boot normally? I mean through BIOS and boot-loader?
> > This explanation seems to be suggesting that because PM and ACPI is
> > disabled, kernel 2 does not search for HPET. If this is the case,
> > this kernel will not boot even through normal boot-loader and will
> > try to use PIT instead?
> > 
> > If so, it is not an kexec issue at all.
> > 
> > Thanks
> > Vivek
> 
> kernel 2 boots normally through BIOS and boot-loader. I agree with your
> explanation.
> It seems that kernel 2 can't enable PIT, when it is executed by kexec.
> As kernel 1 disabled HPET(IRQ0 source) and PIT is "broken"(or isn't
> enabled) IRQ0 are not triggered at all, and kernel 2 hangs.

My hunch is that PIT might be disabled here. Because when first kernel
must have detected HPET and enabled it, then it might have disabled
PIT and second kernel never sees the interrupts from PIT. But it should
have seen the interrupts from HPET as no body disabled it?

I think kexec does not enable/disable any timer devices. It just tries
to bring LAPIC/IOAPIC in a state so that next kernel still seems
timer interrupts before next kernel sets up LAPIC and IPAOIC.
 
> As kernel 2 boots normally through BIOS and boot-loader, than
> additional code needed(in Linux kernel init code) for PIT or ACPI
> or APIC initialization, I mean the same code as executed on BIOS stage.

I am not sure which initial code you are referring to? During kexec, we
will run kernel initial code (except real mode code). But one thing to find
out here will be how does BIOS pass the control to the OS when HPET device is
present. Does it enable the HPET and put LAPIC and IOAPIC in virtual wire
mode or it enables PIT and then later kernel switches from PIT to HPET?

> I agree that it's not an kexec issue. But can we use my fix as a
> workaround(to make kexec work) until PIT will be fixed?
> Everything above is correct for i386/x86_64 RT(2.6.23-rc2-rt2) kernel
> and for i368 "plain"(2.6.23-rc3) kernel. Bug isn't reproduced in 2.6.23-rc3
> x86_64 kernel, because x86_64 code never disables HPET. So on every
> boot(initiated by kexec or BIOS) IRQ0 are triggered.

I think we should dive little deeper to find out the root cause of the problem
instead of putting the intermediate patch. These timer issues are tricky
ones and we have already solved few of these.

Going back to your original mail where you specify root cause.

- You mentioned that first kernel disables HPET while enabling Local APIC
timer. Can you please point me when exactly it happens. I had thought local
APIC timer and HPET server different purpose and co-exist.

- You also mentioned that kernel tries to setup PIT as it does not find
HPET in second kernel. Where exactly does it do that? I think we need to
then go deeper to find out why PIT is not working now? Is it disabled? or
LAPIC/IOAPIC have not been setup properly and PIT interrupts never reach
CPU? 

Thanks
Vivek
