From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: Should I still use pm_timer as clock source for hrt mode
Date: Thu, 23 Apr 2015 10:15:19 -0300
Message-ID: <20150423131519.GD28465@uudg.org>
References: <DDCAE26804250545B9934A2056554AA0208A7A44@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Jiang, Yunhong" <yunhong.jiang@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36082 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965927AbbDWNPX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2015 09:15:23 -0400
Received: by qcpm10 with SMTP id m10so8614832qcp.3
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Apr 2015 06:15:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DDCAE26804250545B9934A2056554AA0208A7A44@ORSMSX112.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 21, 2015 at 05:08:58PM +0000, Jiang, Yunhong wrote:
| Hi, all
| 	I noticed followed statement about TSC timer on
| https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO , " Since the TSC
| timer on PC platforms, as used in the previous versions, are now marked as
| unsuitable for hrt mode due to many lacks of functionalities and
| reliabilities, you will need i.E. pm_timer as provided by ACPI to use as
| clock source".
| 
| 	I'm testing on Intel Xeon CPU E5-2640 and has "Switched to
| clocksource tsc" on kernel log, I think it mean the TSC on my system is
| stable and reliable enough to use as clock source, right? With the
| invariant and synchronized TSC support in latest hardware, can I assume
| generally TSC would be better than pm_timer? 

Nowadays the clocksourse selection code is a bit smarter than it was a
while ago. Some TSC clocks will be reliable as long as your system does not
enter deeper C-states, some will stop in idle... the kernel will select TSC
as the preferred clocksource and will use it until the event that could
render that specific TSC unreliable happens. Then the next better
clocksource option will be selected.

And yes, reading the TSC is way faster and cheaper than reading pm_timer.
So, if TSC is available and is considered reliable, use the TSC.

Depending on your environment and operation parameters you could take some
extra steps to ensure the condition that would turn your TSC clock unreliable
never happens. E.g. avoid entering deeper C-states, booting with
idle=pool, ...

Of course, any these changes have an effect, be it in power consumption or
processor temperature. Be sure to understand that balance and then decide
whether the cost of a lighter clock (in terms of cost to read the current
time) is more important than saving a few Watts on the end of day.

Luis
