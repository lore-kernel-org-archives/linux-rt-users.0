From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: Real time USB2Serial devices and behaivor
Date: Wed, 26 Mar 2008 16:24:19 -0700
Message-ID: <20080326232419.GC15468@kroah.com>
References: <20080326152559.GA17164@linux.intel.com> <20080326162728.GC6020@kroah.com> <20080326164946.GA17928@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark gross <mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080326164946.GA17928-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 26, 2008 at 09:49:46AM -0700, mark gross wrote:
> On Wed, Mar 26, 2008 at 09:27:28AM -0700, Greg KH wrote:
> > On Wed, Mar 26, 2008 at 08:25:59AM -0700, mark gross wrote:
> > > At home I'm playing with a real time amateur robotics application with a
> > > micro controller talking over its serial port to a Linux box running an RT
> > > kernel and some RT user mode software to suck in the serial port data
> > > and do some processing in real time.  One example of what I want to do
> > > with this type of configuration is to create a type of IMU thing and run
> > > the data through a kalman filter to see how good I can do with my
> > > hardware.
> > > 
> > > I'll be sending data regularly at data rates between 50 and 500 HZ from
> > > the MCU (depending on mode)
> > > 
> > > Anyway, I have the RT code and the system prototyped using the hardware
> > > serial port on my desktop and I'm getting rock solid RT delivery times
> > > of the data +/- 30usec.  While stressing the system in CPU and disk. (I
> > > still need to do the test while flood pinging the box)  However; when I
> > > use my USB dongle instead of the hardware serial port the system falls
> > > over WRT real time behavior.
> > > 
> > > I'm just starting to look into the behavior now but has anyone looked at
> > > the RT'ness of USB2Serial + USB stack yet?  I would like to see what
> > > other folks have done.  My googleing last night didn't get any useful
> > > hits.
> > 
> > I have, and others have in the past, and it's something that you can not
> > really do.  USB is not "deterministic", and these cheap usb to serial
> > devices introduce a very big lag that also is not deterministic.
> > 
> 
> I'm seeing some of that today :(
> 
> > I wouldn't recommend using USB for anything that you need to be able to
> > accuratly control the latency of, it's just not going to work as that is
> > not what it was designed for at all.
> 
> Oh, thats a drag.  I know bulk has retries, and that on a clean bus they
> don't happen (well as far as my hobby use they shouldn't, real
> applications should use isochronous streams to avoid them.)
> 
> What is the root cause for the non deterministic behavior?  HW or USB
> stack?

The USB hardware.  Go read the spec for the gory details, in short,
nothing is guaranteed :(

> Is there any reason to think that if I created my own isochronous
> USB2Serial adapter and iso-usb-driver that I couldn't get determinism?

I strongly doubt it as others have tried and failed in the past.

sorry,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
