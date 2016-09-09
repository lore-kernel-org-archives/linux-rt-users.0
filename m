From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: [PATCH] sc16is7xx: drop bogus use of IRQF_ONESHOT
Date: Fri, 9 Sep 2016 15:14:32 +0200
Message-ID: <20160909131432.baydlypki3wch5nv@linutronix.de>
References: <20160218084634.017c3ab4@laptop>
 <1455816372-13989-1-git-send-email-joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Kicinski <moorray3@wp.pl>, linux-serial@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        linux-kernel@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455816372-13989-1-git-send-email-joshc@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-02-18 11:26:12 [-0600], Josh Cartwright wrote:
> The use of IRQF_ONESHOT when registering an interrupt handler with
> request_irq() is non-sensical.
> 
> Not only that, it also prevents the handler from being threaded when it
> otherwise should be w/ IRQ_FORCED_THREADING is enabled.  This causes the
> following deadlock observed by Sean Nyekjaer on -rt:

So we this patch 
  http://lkml.iu.edu/hypermail/linux/kernel/1602.2/02637.html

sitting in -RT. Then someone posted
  http://www.spinics.net/lists/linux-rt-users/msg14975.html
which depends on it.
Before I was are of the first patch, I posted
  http://www.spinics.net/lists/linux-rt-users/msg14666.html

and nobody seems to care if anything of this gets merged upstream
where it belongs. Could some please carry this to Greg upstream?

Sebastian
