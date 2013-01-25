From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH-v2] tty: Use raw spin lock to protect the TTY read section
Date: Fri, 25 Jan 2013 08:13:51 -0800
Message-ID: <20130125161351.GA9929@kroah.com>
References: <1348150166-4868-1-git-send-email-meltedpianoman@gmail.com>
 <1359023699-27050-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359023699-27050-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jan 24, 2013 at 11:34:59AM +0100, Ivo Sieben wrote:
> The "normal" spin lock that guards the N_TTY line discipline read section
> is replaced by a raw spin lock.
> 
> On a PREEMP_RT system this prevents unwanted scheduling overhead when data is
> read at the same time as data is being received: while RX IRQ threaded handling
> is busy a TTY read call is performed from a RT priority > threaded IRQ priority.
> The read call tries to take the read section spin lock (held by the threaded
> IRQ) which blocks and causes a context switch to/from the threaded IRQ handler
> until the spin lock is unlocked.
> 
> On a 240 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
> overhead on the TTY read call.

Out of how many us total?

And this really makes a difference?  I'd like to hear the rt developers
opinoin of this.

> Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com

Forgot the trailing '>' :)

thanks,

greg k-h
