From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH-v3] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Tue, 23 Oct 2012 11:16:59 +0100
Message-ID: <20121023111659.6f4427c7@bob.linux.org.uk>
References: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
	<1348747325-13539-1-git-send-email-meltedpianoman@gmail.com>
	<20121022234746.GA12743@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ivo Sieben <meltedpianoman@gmail.com>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121022234746.GA12743@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Note, I took out the WARN_ON() in this patch, as what is that really
> going to help here?  It also will conflict with a patch from Jiri I'll
> ba applying after this one, so if you think it's needed, care to send
> a follow-on patch based on linux-next in a few days?

It catches anyone flipping low_latency wrongly or in other places. It's
fairly important as WARN_ON() goes !
