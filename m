From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] sc16is7xx: Drop bogus use of IRQF_ONESHOT
Date: Thu, 13 Oct 2016 01:48:20 +0100
Message-ID: <20161013014820.241424bf@laptop>
References: <20161003151432.17828-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Josh Cartwright <joshc@ni.com>, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Julia Cartwright <julia@ni.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161003151432.17828-1-julia@ni.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 3 Oct 2016 10:14:32 -0500, Julia Cartwright wrote:
> The use of IRQF_ONESHOT when registering an interrupt handler with
> request_irq() is non-sensical.
> ...

Disabling the irq when kthread is pending as mentioned here:

http://www.spinics.net/lists/linux-rt-users/msg14673.html

could be beneficial but this is definitely a step in the right
direction!

Acked-by: Jakub Kicinski <kubakici@wp.pl>

Thanks a lot Julia!
