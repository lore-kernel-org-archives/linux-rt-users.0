From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Real time USB2Serial devices and behaivor
Date: Wed, 26 Mar 2008 22:58:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803262255320.21714-100000@netrider.rowland.org>
References: <20080326232419.GC15468@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mark gross <mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080326232419.GC15468-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 26 Mar 2008, Greg KH wrote:

> > Is there any reason to think that if I created my own isochronous
> > USB2Serial adapter and iso-usb-driver that I couldn't get determinism?
> 
> I strongly doubt it as others have tried and failed in the past.

I don't understand.  Isochronous transfers have pretty strict 
transfer-time guarantees.  Why wouldn't this work?

One reason I can think of is that Iso transfers aren't reliable.  But
then regular RS232-type serial transfers aren't reliable either.

The only other reason is that the USB stack itself has an unpredictable 
amount of overhead.  However I think it should fall within an 
acceptable range for RT applications.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
