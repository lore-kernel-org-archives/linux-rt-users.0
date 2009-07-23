From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Host latency peaks due to kvm-intel
Date: Thu, 23 Jul 2009 20:07:33 +0200
Message-ID: <4A68A6E5.6010808@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: kvm-devel <kvm@vger.kernel.org>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

did anyone recently tried current KVM for Intel over some real-time
Linux? I'm seeing more than 500 us latency peaks on the host,
specifically during VM startup. This applies to both 2.6.29.6-rt23 and
Xenomai/I-pipe. For -rt, I both tried the included (patched) KVM modules
as well as kvm.git head with some additionally required -rt fixes.
Xenomai ran over a 2.6.30 kernel with my own KVM-enabler patch.

Early instrumentation actually points to the guest exit itself: I added
markers right before and after the assembly part of vmx_vcpu_run, and
further instrumentation reports that the next host APIC tick should go
off right inside guest mode. But KVM leaves the switching part 500 us
too late in that case - as if guest exit on external IRQs was disabled.

Will debug this further, but I'm also curious to hear other user
experiences.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
