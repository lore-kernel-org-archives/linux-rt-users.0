From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,3/9] powerpc: mpc52xx_gpt: make use of raw_spinlock variants
Date: Mon, 29 Jan 2018 15:13:45 +1100 (AEDT)
Message-ID: <3zVGN94KNbz9sP9@ozlabs.org>
References: <2142489eb41f758b5d04919a8efbb16794f16b0f.1490135047.git.julia@ni.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>,
        Anatolij Gustschin <agust@denx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2142489eb41f758b5d04919a8efbb16794f16b0f.1490135047.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-03-21 at 22:43:03 UTC, Julia Cartwright wrote:
> The mpc52xx_gpt code currently implements an irq_chip for handling
> interrupts; due to how irq_chip handling is done, it's necessary for the
> irq_chip methods to be invoked from hardirq context, even on a a
> real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
> 
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw spinlock.
> 
> Signed-off-by: Julia Cartwright <julia@ni.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/77720c82915a8b7797e0041af95707

cheers
