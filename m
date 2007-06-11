From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.21-rt2..8 troubles
Date: Mon, 11 Jun 2007 20:36:10 +0100
Message-ID: <466DA42A.6010600@rncbc.org>
References: <23932.213.58.131.130.1170156409.squirrel@www.rncbc.org>	 <460FE7F3.4060303@rncbc.org> <20070401183928.GB27614@elte.hu>	 <46574DE4.2080900@rncbc.org> <1180195709.4264.7.camel@chaos>	 <4658A4F4.1080204@rncbc.org>  <46660369.2070104@rncbc.org>	 <1181317625.4404.332.camel@chaos>	 <59605.213.13.107.141.1181326897.squirrel@www.rncbc.org> <1181328636.4404.335.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpa1.netcabo.pt ([212.113.174.16]:19191 "EHLO
	exch01smtp03.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752480AbXFKTiR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 15:38:17 -0400
In-Reply-To: <1181328636.4404.335.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2007-06-08 at 19:21 +0100, Rui Nuno Capela wrote:
>> Just built from linux-2.6.22-rc4.tar.bz2, with patch-2.6.22-rc4-hrt5.
>> All's working apparentely nice on this offending machine (laptop, intel
>> core2 T7200). In fact, I'm writing this very reply under it and through
>> ipw3945 wifi module--which never was so pragmatic on -rt2..9 ;)
>>
>> Nevertheless, this is not preempt-realtime (-rt) is it? And I it never
>> complained about vanilla.
>>
>> Is this good news though?
> 
> Well, the patch carries the same high resolution timer fixes as -rt, so
> I just wanted to exclude those. Thanks for testing.
> 
> I'm spinning -rt10 with a couple of fixes. Should be out sometimes
> tomorrow. If the problem persists, we need to dig deeper.
> 

Uhoh. I'm sorry to tell, but the problem is still creeping on
2.6.21.4-rt11 and -rt12 :(

So sorry.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
