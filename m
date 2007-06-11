From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Mon, 11 Jun 2007 22:25:22 +0100
Message-ID: <466DBDC2.8030509@rncbc.org>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>	 <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu>	 <46574DE4.2080900@rncbc.org> <1180195709.4264.7.camel@chaos>	 <4658A4F4.1080204@rncbc.org>  <46660369.2070104@rncbc.org>	 <1181317625.4404.332.camel@chaos>	 <59605.213.13.107.141.1181326897.squirrel@www.rncbc.org>	 <1181328636.4404.335.camel@chaos>  <466DA42A.6010600@rncbc.org>	 <1181591122.8176.159.camel@chaos>	 <1181591733.11539.217.camel@imap.mvista.com>  <466DB581.8050306@rncbc.org> <1181596473.8176.162.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa3.netcabo.pt ([212.113.174.18]:53325 "EHLO
	exch01smtp02.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751367AbXFKV3G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 17:29:06 -0400
In-Reply-To: <1181596473.8176.162.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Mon, 2007-06-11 at 21:50 +0100, Rui Nuno Capela wrote:
>> Thomas,
>>
>> Yes, "maxcpus=1" seems to keep it running, but then I render my Core2
>> just half-baked ;)
> 
> Yes, I know :(
> 
> /me goes into desperate mode
> 
> Is this a DELL laptop ?
> 

Nope. It's a Fujitsu-Siemens Amilo Si 1520 -- Intel Core2 Duo T7200@2.0Ghz.

Works great with 2.6.21-rt1, and 2.6.22-rc4-hrt5, but that you already
know :)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
