From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 8/9] gpio: 104-idio-16: make use of raw_spinlock variants
Date: Tue, 28 Mar 2017 11:13:29 +0200
Message-ID: <CACRpkdYZqNneQ6a8iY8GUvDonrEDm0gVTR8ejMPe4KmTO2YHHw@mail.gmail.com>
References: <cover.1490135047.git.julia@ni.com> <9b15e28c4aeeade4b44e9a2bb06c12ded5d0990b.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <9b15e28c4aeeade4b44e9a2bb06c12ded5d0990b.1490135047.git.julia@ni.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 21, 2017 at 11:43 PM, Julia Cartwright <julia@ni.com> wrote:

> The 104-idio-16 gpio driver currently implements an irq_chip for handling
> interrupts; due to how irq_chip handling is done, it's necessary for the
> irq_chip methods to be invoked from hardirq context, even on a a
> real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw spinlock.
>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
> New patch as of v2 of series.

Patch applied to the GPIO tree with William's ACK.

Yours,
Linus Walleij
