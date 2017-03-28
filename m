From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 7/9] gpio: 104-idi-48: make use of raw_spinlock
 variants
Date: Tue, 28 Mar 2017 07:40:26 -0400
Message-ID: <20170328114026.GA13895@sophia>
References: <cover.1490135047.git.julia@ni.com>
 <a9b84439c28b96a9b6a4cbfca85f1e13a457d25d.1490135047.git.julia@ni.com>
 <20170322124414.GA22323@sophia>
 <CACRpkdbqUmTHv7pyc+EVznzR8BiO_=pc12awsS4ygYJsbsG=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Julia Cartwright <julia@ni.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbqUmTHv7pyc+EVznzR8BiO_=pc12awsS4ygYJsbsG=EQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 28, 2017 at 11:11:59AM +0200, Linus Walleij wrote:
>On Wed, Mar 22, 2017 at 1:44 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>> On Tue, Mar 21, 2017 at 05:43:07PM -0500, Julia Cartwright wrote:
>>>The 104-idi-48 gpio driver currently implements an irq_chip for handling
>>>interrupts; due to how irq_chip handling is done, it's necessary for the
>>>irq_chip methods to be invoked from hardirq context, even on a a
>>>real-time kernel.  Because the spinlock_t type becomes a "sleeping"
>>>spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>>>
>>>A quick audit of the operations under the lock reveal that they do only
>>>minimal, bounded work, and are therefore safe to do under a raw spinlock.
>>>
>>>Signed-off-by: Julia Cartwright <julia@ni.com>
>>
>> Hi Julia,
>>
>> This driver also uses a second spinlock_t, called ack_lock, to prevent
>> reentrance into the idi_48_irq_handler function. Should ack_lock also be
>> implemented as a raw_spinlock_t?
>
>Hm, can I apply this one patch or not?
>
>Linus Walleij

Oops, sorry for missing this reply. Julia is correct that ack_lock does
not need to be implemented as raw_spinlock_t. For reference, ack_lock is
used to prevent a race condition on the device hardware itself related
to how the 104-IDI-48 acknowledges IRQ (check out the commit description
for it for a more in-depth explanation if you're curious).

Long story short: Julia's patch is prefectly acceptable as is.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

William Breathitt Gray
