From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v2 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Wed, 14 Oct 2015 16:54:16 +0200
Message-ID: <561E6C98.8080805@bmw-carit.de>
References: <1444808602-29500-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1444808602-29500-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444808602-29500-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/14/2015 09:43 AM, Daniel Wagner wrote:
>  arch/arm/kvm/arm.c                  |  4 ++--
>  arch/arm/kvm/psci.c                 |  4 ++--
>  arch/powerpc/include/asm/kvm_host.h |  4 ++--
>  arch/powerpc/kvm/book3s_hv.c        | 23 +++++++++++------------
>  arch/s390/include/asm/kvm_host.h    |  2 +-
>  arch/s390/kvm/interrupt.c           |  8 ++++----
>  arch/x86/kvm/lapic.c                |  6 +++---
>  include/linux/kvm_host.h            |  5 +++--
>  virt/kvm/async_pf.c                 |  4 ++--
>  virt/kvm/kvm_main.c                 | 17 ++++++++---------
>  10 files changed, 38 insertions(+), 39 deletions(-)

As reported by the 0day build robot, at least the mips arch part needs
also to be updated.
