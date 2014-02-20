From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: locking changes in tty broke low latency feature
Date: Wed, 19 Feb 2014 20:16:55 -0800
Message-ID: <20140220041655.GA29659@kroah.com>
References: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net>
 <53056E99.9070900@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Hurley <peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53056E99.9070900@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Feb 19, 2014 at 09:55:21PM -0500, Peter Hurley wrote:
> On 02/19/2014 06:06 PM, Hal Murray wrote:
> >> Can you give me an idea of your device's average and minimum required
> >> latency (please be specific)?  Is your target arch x86 [so I can evaluate the
> >> the impact of bus-locked instructions relative to your expected]?
> >
> > The code I'm familiar with is ntpd and gpsd.  They run on almost any hardware
> > or OS and talk to a wide collection of devices.
> >
> > There is no hard requirement for latency.  They just work better with lower
> > latency.  The lower the better.
> >
> > People gripe about the latency due to USB polling which is about a ms.
> 
> Have you tried 3.12+ without low_latency? I ripped out a lot of locks
> from 3.12+ so it's possible it already meets your requirements.

Once USB gets involved, I don't want to hear anyone start complaining
about "latency" issues.  Almost all USB->serial devices do not take
latency into account at all.  The ones that do are really expensive and
not showing up in GPS devices and other "normal" devices at all.

So go blame the device manufactures for this, they obviously don't care
about issues like that if they use USB bulk endpoints for their data.

And yes, there are rumors that new hardware in a few years will be able
to handle time differences with USB latencies and the like, but I'll
wait until I see that hardware ship before even start to worry about the
issues involved...

thanks,

greg k-h
