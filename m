From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Thu, 14 May 2015 12:51:41 -0500
Message-ID: <1431625901.3868.165.camel@freescale.com>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
	 <20150514153639.GA13442@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	<tglx@linutronix.de>, <pbonzini@redhat.com>, <agraf@suse.de>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mihai.caraman@freescale.com>,
	<b10716@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514153639.GA13442@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2015-05-14 at 17:36 +0200, Sebastian Andrzej Siewior wrote:
> * Bogdan Purcareata | 2015-04-24 15:53:11 [+0000]:
> 
> >0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
> >0002: disables in-kernel MPIC emulation for guest running on RT, in order to
> 
> Scott, I'm asking here for your explicit Acked-by on those two patches.
> That you want it *that* way. We have now a nice explanation in #1 :)

ACK patch 2 only.  Patch 1 is unnecessary as long as we have patch 2,
and the most likely long-term solutions do not involve converting all
the locking in that file to a raw lock.

-Scott
