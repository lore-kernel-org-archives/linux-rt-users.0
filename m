From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 17:37:37 +0100
Message-ID: <45CF4651.506@grandegger.com>
References: <45CEF997.3020101@grandegger.com>	 <20070211112933.GN29553@pengutronix.de>  <45CF0E90.2080806@grandegger.com> <1171209448.3661.10.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58814 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXBKQhT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 11:37:19 -0500
In-Reply-To: <1171209448.3661.10.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> Wolfgang,
> 
> On Sun, 2007-02-11 at 13:39 +0100, Wolfgang Grandegger wrote:
>> As I see it, 2.6.20-rt3 has the same issues (have now attached the 
>> missing make output). I fixed them manually and are now able to boot and 
>> run the 2.6.20-rt5 on my Icecube board. Nevertheless, cyclictest returns 
>> high values of around 8000-10000 (8-10ms). The fact that the unknown 
>> field 'is_continuous' in arch/powerpc/kernel/time.c is still present 
>> gives me the impression, that the code in there is not up-to-date. See 
>> you next week on the Embedded World.
> 
> Yup, I did not come around to do the fixups. Is top on my todo list
> though.

Apart from that, I also realized that it's not possible to enable 
HIGH_RES_TIMERS, because GENERIC_CLOCKEVENTS is not selected or 
available for PowerPC.

Wolfgang.
