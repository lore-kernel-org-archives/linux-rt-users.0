From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: bisected - arm64 kvm unit test failures
Date: Tue, 21 Aug 2018 16:34:43 +0100
Message-ID: <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
 <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
 <1533061729.12487.26.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533061729.12487.26.camel@gmx.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Mike,

On 31/07/18 19:28, Mike Galbraith wrote:
> On Mon, 2018-07-30 at 18:24 +0200, Mike Galbraith wrote:
>> On Sun, 2018-07-29 at 13:47 +0200, Mike Galbraith wrote:
>>> FYI, per kvm unit tests, 4.16-rt definitely has more kvm issues.
> 
> But it's not RT, or rather most of it isn't...
> 
>>> huawei5:/abuild/mike/kvm-unit-tests # uname -r
>>> 4.16.18-rt11-rt
>>> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
>>> PASS selftest-setup (2 tests)
>>> FAIL selftest-vectors-kernel 
>>> FAIL selftest-vectors-user 
>>> PASS selftest-smp (65 tests)
>>> PASS pci-test (1 tests)
>>> PASS pmu (3 tests)
>>> FAIL gicv2-ipi 
>>> FAIL gicv3-ipi 
>>> FAIL gicv2-active 
>>> FAIL gicv3-active 
>>> PASS psci (4 tests)
>>> FAIL timer 
>>> huawei5:/abuild/mike/kvm-unit-tests #
>>>
>>> 4.14-rt passes all tests.  The above is with the kvm raw_spinlock_t
>>> conversion patch applied, but the 4.12 based SLERT tree I cloned to
>>> explore arm-land in the first place shows only one timer failure, and
>>> has/needs it applied as well, which would seem to vindicate it.
>>>
>>> huawei5:/abuild/mike/kvm-unit-tests # uname -r
>>> 4.12.14-0.gec0b559-rt
>>> huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
>>> PASS selftest-setup (2 tests)
>>> PASS selftest-vectors-kernel (2 tests)
>>> PASS selftest-vectors-user (2 tests)
>>> PASS selftest-smp (65 tests)
>>> PASS pci-test (1 tests)
>>> PASS pmu (3 tests)
>>> PASS gicv2-ipi (3 tests)
>>> PASS gicv3-ipi (3 tests)
>>> PASS gicv2-active (1 tests)
>>> PASS gicv3-active (1 tests)
>>> PASS psci (4 tests)
>>> FAIL timer (8 tests, 1 unexpected failures)
>>
>> FWIW, this single timer failure wass inspired by something in the 4-15
>> merge window.
> 
> As noted, the single timer failure is an RT issue of some sort, and
> remains.  The rest I bisected in @stable with the attached config, and
> confirmed that revert fixes up 4.16-rt as well (modulo singleton).

Could you give that patchlet[1] a go? It solves a similar issue for me
on a different platform.

Thanks,

	M.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html
-- 
Jazz is not dead. It just smells funny...
