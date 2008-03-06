From: Daniel Walker <dwalker@mvista.com>
Subject: Re: High resolution timers on AT91SAM926x
Date: Wed, 05 Mar 2008 17:47:03 -0800
Message-ID: <1204768023.3368.0.camel@localhost.localdomain>
References: <200803011457.40857.david-b@pacbell.net>
	 <200803031039.57909.david-b@pacbell.net>
	 <d6c8ef150803031342r567aab86x776dc2a8b73714b6@mail.gmail.com>
	 <200803031729.19264.david-b@pacbell.net>
	 <3efb10970803041222j61fd8d28k5cef0994b9bd6f12@mail.gmail.com>
	 <d6c8ef150803041438h5912cedev6322f9b295e789d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Remy Bohmer <linux@bohmer.net>,
	David Brownell <david-b@pacbell.net>,
	linux-rt-users@vger.kernel.org
To: Bosko Radivojevic <bosko.radivojevic@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:42086 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757802AbYCFBrG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 20:47:06 -0500
In-Reply-To: <d6c8ef150803041438h5912cedev6322f9b295e789d8@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 2008-03-04 at 23:38 +0100, Bosko Radivojevic wrote:
> Hello Remy,
> 
> I tried today Xenomai (2.6.20.21 kernel, that is the last supported by
> I-Pipe patch), the same example program (recompiled with Xenomai
> libpthread_rt). Results are a little bit better (worst-case latency is
> around 150us). Using Xenomai in native skin (as kernel module)
> produces much better results (worst-case latency is around 50us).
> Currently, I am looking for the best way to "transfer" application to
> user land/posix.

Maybe you could attach your test application? and specifics on how your
running it?

Daniel

