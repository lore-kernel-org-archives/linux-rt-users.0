From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 07:34:38 -0600
Message-ID: <1311428078.2502.0.camel@hermosa.morreale.net>
References: <alpine.LFD.2.02.1107222203400.2702@ionos>
	 <4E2A1E75.4070709@gmail.com>
Reply-To: pmorreale@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E2A1E75.4070709@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2011-07-23 at 03:05 +0200, Maarten Lankhorst wrote:
> On 07/22/2011 10:37 PM, Thomas Gleixner wrote:
> > Dear RT Folks,
> >
> > I'm pleased to announce the 3.0-rt1 release.
> >
> > Changes versus 3.0-rc7-rt0:
> >
> >   * Update to Linus final 3.0 release
> >
> >   * RTC bugfixes (scheduled for mainline/stable)
> >
> >   * Long standing (rt only) timer_list bug (see
> >     timers-avoid-the-base-null-otptimization-on-rt.patch in the split
> >     out quilt queue)
> >
> >   * Minor non exciting fixes all over the place
> >
> > Known issues:
> >
> >   * Some weird "console=..." commandline + config dependent
> >     interactions which have been not yet investigated down to their
> >     root cause. Result in a boot hang. YMMV
> Sweet, works here :)
> 
> Only the nvidia driver fails to build because of rtmutex and migrate enable/disable being GPL only, you might want to reconsider the GPL only status of them.
> 
> ~Maarten

Or, alternatively, please ask Nvidia to GPL their driver.

Best
-PWM


> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
