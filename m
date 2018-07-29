From: Mike Galbraith <efault@gmx.de>
Subject: Re: candidates for @devel-rt localversion-rt++
Date: Sun, 29 Jul 2018 13:47:47 +0200
Message-ID: <1532864867.1618.32.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532847330.1618.8.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

FYI, per kvm unit tests, 4.16-rt definitely has more kvm issues.

huawei5:/abuild/mike/kvm-unit-tests # uname -r
4.16.18-rt11-rt
huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
PASS selftest-setup (2 tests)
FAIL selftest-vectors-kernel 
FAIL selftest-vectors-user 
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
FAIL gicv2-ipi 
FAIL gicv3-ipi 
FAIL gicv2-active 
FAIL gicv3-active 
PASS psci (4 tests)
FAIL timer 
huawei5:/abuild/mike/kvm-unit-tests #

4.14-rt passes all tests.  The above is with the kvm raw_spinlock_t
conversion patch applied, but the 4.12 based SLERT tree I cloned to
explore arm-land in the first place shows only one timer failure, and
has/needs it applied as well, which would seem to vindicate it.

huawei5:/abuild/mike/kvm-unit-tests # uname -r
4.12.14-0.gec0b559-rt
huawei5:/abuild/mike/kvm-unit-tests # ./run_tests.sh
PASS selftest-setup (2 tests)
PASS selftest-vectors-kernel (2 tests)
PASS selftest-vectors-user (2 tests)
PASS selftest-smp (65 tests)
PASS pci-test (1 tests)
PASS pmu (3 tests)
PASS gicv2-ipi (3 tests)
PASS gicv3-ipi (3 tests)
PASS gicv2-active (1 tests)
PASS gicv3-active (1 tests)
PASS psci (4 tests)
FAIL timer (8 tests, 1 unexpected failures)
huawei5:/abuild/mike/kvm-unit-tests #
