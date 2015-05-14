From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Thu, 14 May 2015 17:36:39 +0200
Message-ID: <20150514153639.GA13442@linutronix.de>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, pbonzini@redhat.com, agraf@suse.de,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mihai.caraman@freescale.com,
	b10716@freescale.com
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	scottwood@freescale.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Bogdan Purcareata | 2015-04-24 15:53:11 [+0000]:

>0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
>0002: disables in-kernel MPIC emulation for guest running on RT, in order to

Scott, I'm asking here for your explicit Acked-by on those two patches.
That you want it *that* way. We have now a nice explanation in #1 :)

Sebastian
