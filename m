From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 16:19:55 +0000
Message-ID: <56BCB4AB.70304@arm.com>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
 <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <CAMJs5B_UGDTkT6xA_cKq7DW1P8JOQ-f3O7=UQT+KWTOf1q5MjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Josh Cartwright <joshc@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>,
	"Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55985 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcBKQT6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 11:19:58 -0500
In-Reply-To: <CAMJs5B_UGDTkT6xA_cKq7DW1P8JOQ-f3O7=UQT+KWTOf1q5MjQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/02/16 14:02, Christoffer Dall wrote:
> On Thu, Feb 11, 2016 at 11:46 AM, Jaggi, Manish
> <Manish.Jaggi@caviumnetworks.com> wrote:
>> Thanks Josh.
>> I tried both options
>> a) replace prempt_XXX with migrate_XXX as per the patch
>> b) replacing spin_lock in kvm_vgic_flush_hwstate with raw_spin_lock
>>
>> Host and guest has NO_HZ_FULL=y
>> The cyclictest avg latency / max latency are very high in guest.
>>
>> host: Avg:   28 Max:     180
>> guest: Avg:  168 Max:   19532
>>
>> Running guest within a cset created with -k option
>>
> Our interrupt delivery slowdown is quite high due to the expensive
> world-switch path on KVM/ARM.
> 
> Marc (cc'ed) recently did some optimizations in this area which may be
> worth looking at.

You can have a look at the branch I have on

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
kvm-arm64/suck-less

though most of it is for GICv2 (and my suspicion is that we're talking
about GICv3 here, given the email addresses...).

Anyway, if there is some specific things that should be looked at to
improve RT in guests with KVM, I'm all ears.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
