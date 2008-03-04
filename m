From: "Bosko Radivojevic" <bosko.radivojevic@gmail.com>
Subject: Re: High resolution timers on AT91SAM926x
Date: Tue, 4 Mar 2008 23:38:36 +0100
Message-ID: <d6c8ef150803041438h5912cedev6322f9b295e789d8@mail.gmail.com>
References: <200803011457.40857.david-b@pacbell.net>
	 <200803031039.57909.david-b@pacbell.net>
	 <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>
	 <200803031729.19264.david-b@pacbell.net>
	 <3efb10970803041222j61fd8d28k5cef0994b9bd6f12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Brownell" <david-b@pacbell.net>,
	linux-rt-users@vger.kernel.org
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:47473 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677AbYCDWij (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 17:38:39 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1371020wxd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Mar 2008 14:38:36 -0800 (PST)
In-Reply-To: <3efb10970803041222j61fd8d28k5cef0994b9bd6f12@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Remy,

I tried today Xenomai (2.6.20.21 kernel, that is the last supported by
I-Pipe patch), the same example program (recompiled with Xenomai
libpthread_rt). Results are a little bit better (worst-case latency is
around 150us). Using Xenomai in native skin (as kernel module)
produces much better results (worst-case latency is around 50us).
Currently, I am looking for the best way to "transfer" application to
user land/posix.

>  FWIW: For getting the most accurate realtime response for periodic
>  timers, I used a TC block to generate a periodic interrupt, that only
>  needs to wake up a RT-thread. This way the OS-timer framework can be
>  used for non-RT stuff, and/or slow timers. This is much less heavy on
>  this core, and gives much better/deterministic RT results.

May you give me a bit more details on this? Thanks :)

Cheers!
