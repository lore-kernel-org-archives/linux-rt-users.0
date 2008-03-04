From: David Brownell <david-b@pacbell.net>
Subject: Re: High resolution timers on AT91SAM926x
Date: Mon, 3 Mar 2008 17:29:18 -0800
Message-ID: <200803031729.19264.david-b@pacbell.net>
References: <200803011457.40857.david-b@pacbell.net> <200803031039.57909.david-b@pacbell.net> <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: "Bosko Radivojevic" <bosko.radivojevic@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:47970 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754780AbYCDB3V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Mar 2008 20:29:21 -0500
In-Reply-To: <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Monday 03 March 2008, Bosko Radivojevic wrote:
> I had CONFIG_ATMEL_TCLIB enabled, but not TCB_CLKSRC and
> TCB_CLKSRC_BLOCK=0. With all those options, I finally have HRT
> functionality. But, strange thing is that jitter of my little example
> (get time, sleep 1ms, get time, show the difference) is around 250us.
> Maybe this is normal for this architecture?

I have no idea why that would be.  Maybe you can find out.  :)


> System is (as noted on rt.wik site) very slow with NO_HZ option enabled.

It doesn't exactly say *why* or compare to other arm926ejs
chips ... 

Could the 64-bit math (ktime stuff) be a factor there?  Your
board probably only runs at 95 (or-so) bogomips after all.

And is that just a NO_HZ issue, or generically an issue when
oneshot timer modes are in heavy use?

- Dave
 
