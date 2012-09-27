From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH-v3] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Thu, 27 Sep 2012 09:53:53 -0700
Message-ID: <20120927165353.GA20469@kroah.com>
References: <20120925154707.33aa2fa4@pyramind.ukuu.org.uk>
 <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
 <20120927141522.7d3e26de@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivo Sieben <meltedpianoman@gmail.com>,
	Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org,
	RT <linux-rt-users@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120927141522.7d3e26de@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Sep 27, 2012 at 02:15:22PM +0100, Alan Cox wrote:
> On Thu, 27 Sep 2012 13:58:21 +0200
> Ivo Sieben <meltedpianoman@gmail.com> wrote:
> 
> > When low_latency flag is set the TTY receive flip buffer is copied to the
> > line discipline directly instead of using a work queue in the background.
> > Therefor only in case a workqueue is actually used for copying data to the
> > line discipline we'll have to flush the workqueue.
> > 
> > This prevents unnecessary spin lock/unlock on the workqueue spin lock that
> > can cause additional scheduling overhead on a PREEMPT_RT system. On a 200
> > MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
> > overhead on the TTY read call.
> > 
> > Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
> 
> Acked-by: Alan Cox <alan@linux.intel.com>
> 
> (but for 3.8 not 3.7 ...)

Yes, I will hold onto this until 3.7-rc1 is out, thanks.

greg k-h
