From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.1.10-rt10][PATCH 0/2] PCI: dra7xx/dwc: fix "WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu"
Date: Mon, 2 Nov 2015 21:30:24 +0200
Message-ID: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Now in kernel below code pattern is used by many drivers:
static irqreturn_t driver_xx_hw_irq_handler(int irq, void *arg)
{
	<read IRQ status register>
  	<perform HW specific operations>

	for (<each set bit in IRQ status register>) {
		<get Linux IRQ number>
		generic_handle_irq(<Linux IRQ number>);
		|- handle_simple_irq()
		|-or- handle_level_irq()
		|-or- handle_edge_irq()
		   |-handle_irq_event()
		     |-handle_irq_event_percpu()
===
"WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
 irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts"
===
	}
}

On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
will be forced threaded (by default) and, as result, generic_handle_irq()
will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).

Instead of spreading this W/A directly in many drivers this series
introduces -RT specific version of generic_handle_irq() API -
generic_handle_irq_rt_wa(). This new generic_handle_irq_rt_wa() just calls
generic_handle_irq() surrounded by raw_spin_lock_irqsave/irqrestore().
If -RT is disabled It will fallback to generic_handle_irq().

And generic_handle_irq_rt_wa() is used then to W/A similar issues
in pcie-designware.c and pcie-dra7xx.c.

Grygorii Strashko (2):
  genirq: introduce new generic_handle_irq_rt_wa() api
  PCI: dra7xx: fix "WARNING: CPU: 1 PID: 82 at  kernel/irq/handle.c:150
    handle_irq_event_percpu"

 drivers/pci/host/pci-dra7xx.c      |  3 ++-
 drivers/pci/host/pcie-designware.c |  2 +-
 include/linux/irqdesc.h            |  5 +++++
 kernel/irq/irqdesc.c               | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.6.2
