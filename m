From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] powerpc/kvm: Disable in-kernel MPIC emulation for
 PREEMPT_RT_FULL
Date: Thu, 14 May 2015 21:36:01 +0200
Message-ID: <20150514193601.GI13442@linutronix.de>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
 <1429890793-19487-3-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, pbonzini@redhat.com, agraf@suse.de,
	scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mihai.caraman@freescale.com, b10716@freescale.com
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429890793-19487-3-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Bogdan Purcareata | 2015-04-24 15:53:13 [+0000]:

>While converting the openpic emulation code to use a raw_spinlock_t enables
>guests to run on RT, there's still a performance issue. For interrupts sent in

>Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>

Applied with Scott's Acked-by

Sebastian
