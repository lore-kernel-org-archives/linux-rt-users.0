From: Daniel Walker <dwalker@mvista.com>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Mon, 11 Jun 2007 15:34:40 -0700
Message-ID: <1181601280.11539.219.camel@imap.mvista.com>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>
	 <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu>
	 <46574DE4.2080900@rncbc.org> <1180195709.4264.7.camel@chaos>
	 <4658A4F4.1080204@rncbc.org>  <46660369.2070104@rncbc.org>
	 <1181317625.4404.332.camel@chaos>
	 <59605.213.13.107.141.1181326897.squirrel@www.rncbc.org>
	 <1181328636.4404.335.camel@chaos>  <466DA42A.6010600@rncbc.org>
	 <1181591122.8176.159.camel@chaos>
	 <1181591733.11539.217.camel@imap.mvista.com>  <466DB581.8050306@rncbc.org>
	 <1181596473.8176.162.camel@chaos>  <466DBDC2.8030509@rncbc.org>
	 <1181598178.8176.180.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:51507 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbXFKWh4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 18:37:56 -0400
In-Reply-To: <1181598178.8176.180.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-06-11 at 23:42 +0200, Thomas Gleixner wrote:
> On Mon, 2007-06-11 at 22:25 +0100, Rui Nuno Capela wrote:
> > Nope. It's a Fujitsu-Siemens Amilo Si 1520 -- Intel Core2 Duo T7200@2.0Ghz.
> 
> Yeah, there are Dell ones which have similar or worse symptoms.
> 
> > Works great with 2.6.21-rt1, and 2.6.22-rc4-hrt5, but that you already
> > know :)
> 
> Ok. I go back and figure out which differences we have between
> 2.6.21-rt>8 and the -hrt queue.

Are you sure it's strictly and HRT issue? I didn't see a
!CONFIG_HIGH_RES_TIMERS test ..

Daniel
