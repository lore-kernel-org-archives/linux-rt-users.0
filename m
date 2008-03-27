From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Real time USB2Serial devices and behaivor
Date: Thu, 27 Mar 2008 12:48:40 -0700
Message-ID: <200803271248.40519.david-b@pacbell.net>
References: <20080326152559.GA17164@linux.intel.com> <20080326162728.GC6020@kroah.com> <20080326164946.GA17928@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080326164946.GA17928-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 26 March 2008, mark gross wrote:
> On Wed, Mar 26, 2008 at 09:27:28AM -0700, Greg KH wrote:
> > Give up and use a "real" serial port, you'll have better luck :)
> 
> but its getting very hard to find real serial ports any more :(

I happened across this the other day, and saved the URL since
the price was relatively sane ... $15 vs the $60 I saw at
another site, although ISTR Fry's used to have them at $5:

  http://www.wrighthobbies.net/catalog/index.php?cPath=47

Yeah, I know.  "It's getting very hard to find real PCI slots
any more."  :(

It seems like some companies (notably *cough* Intel) are
on a little jihad to get rid of serial ports...


I'd think that in a controlled environment (fixed set of
USB connections) USB should be able to meet fairly chosen
"real time" latency ceilings.  The stack probably needs a
few semantic updates to make it happen -- e.g. URB completions
are issued in_irq() -- but it shouldn't be insurmountable.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
