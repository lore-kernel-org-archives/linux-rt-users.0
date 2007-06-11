From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Mon, 11 Jun 2007 23:42:58 +0200
Message-ID: <1181598178.8176.180.camel@chaos>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Rui Nuno Capela <rncbc@rncbc.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56394 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750930AbXFKVnB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 17:43:01 -0400
In-Reply-To: <466DBDC2.8030509@rncbc.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-06-11 at 22:25 +0100, Rui Nuno Capela wrote:
> Nope. It's a Fujitsu-Siemens Amilo Si 1520 -- Intel Core2 Duo T7200@2.0Ghz.

Yeah, there are Dell ones which have similar or worse symptoms.

> Works great with 2.6.21-rt1, and 2.6.22-rc4-hrt5, but that you already
> know :)

Ok. I go back and figure out which differences we have between
2.6.21-rt>8 and the -hrt queue.

	tglx
