From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.1.10-rt10][PATCH 0/2] PCI: dra7xx/dwc: fix "WARNING: CPU: 1
 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu"
Date: Tue, 3 Nov 2015 14:46:22 +0100
Message-ID: <5638BAAE.6050909@linutronix.de>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/02/2015 08:30 PM, Grygorii Strashko wrote:
> On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
> will be forced threaded (by default) and, as result, generic_handle_irq()
> will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
> be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).

and what happens without -RT if you boot threadedirqs?

Sebastian
