From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 15:02:48 +0100
Message-ID: <CAMJs5B_UGDTkT6xA_cKq7DW1P8JOQ-f3O7=UQT+KWTOf1q5MjQ@mail.gmail.com>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
	<20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
	<BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Cartwright <joshc@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>
To: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34078 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbcBKOIU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 09:08:20 -0500
Received: by mail-yw0-f174.google.com with SMTP id h129so39607968ywb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Feb 2016 06:08:20 -0800 (PST)
In-Reply-To: <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 11, 2016 at 11:46 AM, Jaggi, Manish
<Manish.Jaggi@caviumnetworks.com> wrote:
> Thanks Josh.
> I tried both options
> a) replace prempt_XXX with migrate_XXX as per the patch
> b) replacing spin_lock in kvm_vgic_flush_hwstate with raw_spin_lock
>
> Host and guest has NO_HZ_FULL=y
> The cyclictest avg latency / max latency are very high in guest.
>
> host: Avg:   28 Max:     180
> guest: Avg:  168 Max:   19532
>
> Running guest within a cset created with -k option
>
Our interrupt delivery slowdown is quite high due to the expensive
world-switch path on KVM/ARM.

Marc (cc'ed) recently did some optimizations in this area which may be
worth looking at.

-Christoffer
