From: Greg KH <greg@kroah.com>
Subject: Re: Real time USB2Serial devices and behaivor
Date: Wed, 26 Mar 2008 21:13:06 -0700
Message-ID: <20080327041306.GA10095@kroah.com>
References: <20080326232419.GC15468@kroah.com> <Pine.LNX.4.44L0.0803262255320.21714-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mark gross <mgross@linux.intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, linux-usb@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:36227 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbYC0ELr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Mar 2008 00:11:47 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0803262255320.21714-100000@netrider.rowland.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 26, 2008 at 10:58:37PM -0400, Alan Stern wrote:
> On Wed, 26 Mar 2008, Greg KH wrote:
> 
> > > Is there any reason to think that if I created my own isochronous
> > > USB2Serial adapter and iso-usb-driver that I couldn't get determinism?
> > 
> > I strongly doubt it as others have tried and failed in the past.
> 
> I don't understand.  Isochronous transfers have pretty strict 
> transfer-time guarantees.  Why wouldn't this work?

I don't know, but the person who tried this a while ago said it wasn't
really "real-time" enough for their application (robot arm movement).

> One reason I can think of is that Iso transfers aren't reliable.  But
> then regular RS232-type serial transfers aren't reliable either.
> 
> The only other reason is that the USB stack itself has an unpredictable 
> amount of overhead.  However I think it should fall within an 
> acceptable range for RT applications.

It's all about bounding the longest latency.  Sometimes, under heavy
loads, latency can be pretty big.  But now that we have the -rt kernel,
it might be a lot better than before, so that might be possible now,
haven't tried it...

good luck,

greg k-h
