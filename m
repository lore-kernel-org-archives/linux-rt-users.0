From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Fri, 11 Dec 2015 20:47:20 +0100
Message-ID: <20151211204720.3571ad93@balder.valhalla.alchemy.lu>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
	<20151211165240.GG6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:47375 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbLKUDk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 15:03:40 -0500
In-Reply-To: <20151211165240.GG6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Dec 2015 17:52:40 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Joakim Hernberg | 2015-09-23 19:33:40 [+0200]:
> 
> >Since the HWLAT_DETECTOR driver supposedly shouldn't be builtin, but
> >a module when used at all, it would make sense to limit the
> >configuration choices:  
> 
> what is wrong with it beeing built-in? The default is m already.

To be quite honest I'm not quite sure anymore, think it fails when
built in.  I also faintly remember an irc discussion where it was
claimed that it shouldn't be built into the kernel, think that was the
reason for creating the patch.

-- 

   Joakim
