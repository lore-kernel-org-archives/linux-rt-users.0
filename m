From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Two 2.6.20-rc5-rt2 issues
Date: Wed, 17 Jan 2007 08:58:29 -0000 (WET)
Message-ID: <3521.194.65.103.1.1169024309.squirrel@www.rncbc.org>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
    <20070116115638.GA6809@elte.hu>
    <47345.192.168.1.8.1168994713.squirrel@www.rncbc.org>
    <20070117063144.GB14027@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.netcabo.pt ([212.113.174.30]:26047 "EHLO
	exch01smtp12.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932080AbXAQI7E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jan 2007 03:59:04 -0500
In-Reply-To: <20070117063144.GB14027@elte.hu>
To: "Ingo Molnar" <mingo@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, January 17, 2007 06:31, Ingo Molnar wrote:
>
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> Building this already with -rt5, still gives:
>> ...
>> LD      arch/i386/boot/compressed/vmlinux
>> OBJCOPY arch/i386/boot/vmlinux.bin
>> BUILD   arch/i386/boot/bzImage
>> Root device is (3, 2)
>> Boot sector 512 bytes.
>> Setup is 7407 bytes.
>> System is 1427 kB
>> Kernel: arch/i386/boot/bzImage is ready  (#1)
>> WARNING: "profile_hits" [drivers/kvm/kvm-intel.ko] undefined!
>> WARNING: "profile_hits" [drivers/kvm/kvm-amd.ko] undefined!
>>
>
> ok - in my test-config i didnt have KVM modular - the patch below should
> fix this problem.
>
> Ingo
>
>
> Index: linux/kernel/profile.c
> ===================================================================
> --- linux.orig/kernel/profile.c
> +++ linux/kernel/profile.c
> @@ -332,7 +332,6 @@ out:
> local_irq_restore(flags); put_cpu(); }
> -EXPORT_SYMBOL_GPL(profile_hits);
>
>
> static int __devinit profile_cpu_callback(struct notifier_block *info,
> unsigned long action, void *__cpu) @@ -402,6 +401,8 @@ void
> profile_hits(int type, void *__pc, }
> #endif /* !CONFIG_SMP */
>
>
> +EXPORT_SYMBOL_GPL(profile_hits);
> +
> void __profile_tick(int type, struct pt_regs *regs) {
> if (type == CPU_PROFILING && timer_hook)
>

OK, now it builds alright.

Both issues seem to be fixed now, thanks.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
