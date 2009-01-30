From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.28-rt on PowerPC
Date: Sat, 31 Jan 2009 00:06:33 +0100
Message-ID: <20090130230633.GG32026__13765.9039967277$1233356928$gmane$org@pengutronix.de>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru> <1233270043.3833.57.camel@localhost.localdomain> <49823A13.50703@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Steven Rostedt <srostedt@redhat.com>, avorontsov@ru.mvista.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-rt-users@vger.kernel.org,
	Uwe Kleine-Koenig <ukl@pengutronix.de>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757652AbZA3XHT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49823A13.50703@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Frank,

On Thu, Jan 29, 2009 at 03:21:55PM -0800, Frank Rowand wrote:
> > Thanks! I have not yet had the chance to apply any arch patches yet. I
> > do plan on doing so after getting the code mostly working on x86.
> 
> Your email can at an opportune time for me...  I was starting to try
> 2.6.28-rt on ARM and quickly came to the conclusion that the arch
> patches weren't the focus yet.  But I'm currently side-tracked with
> getting my board to even boot a vanilla 2.6.28 kernel first.  Do
> you expect to get to the arches in the next week or two?  If not,
> I may head down that path for ARM myself.

Uwe has collected some patches for ARM here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/52108/focus=787937

You might want to try them before starting, in order to avoid duplicate
work.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
