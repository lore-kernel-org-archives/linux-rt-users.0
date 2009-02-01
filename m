From: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.26.8-rt12 - No hwclock - works under 2.6.24-rt1
Date: Sun, 1 Feb 2009 08:21:28 -0800
Message-ID: <5bdc1c8b0902010821yb31f841i10cc13110bc19be@mail.gmail.com>
References: <5bdc1c8b0901301600k13a06b0laf048293f037374c@mail.gmail.com>
	 <20090131085221.7fc4458d@torg>
	 <5bdc1c8b0901310958s555cfc0eg3ba649947d2581@mail.gmail.com>
	 <20090131132041.6b65408c@torg>
	 <5bdc1c8b0901311436vae23e5du3ceb54e6fdb19988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:13431 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZBAQV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 1 Feb 2009 11:21:29 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1302618wfd.4
        for <linux-rt-users@vger.kernel.org>; Sun, 01 Feb 2009 08:21:28 -0800 (PST)
In-Reply-To: <5bdc1c8b0901311436vae23e5du3ceb54e6fdb19988@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark,
   To finish up, thanks for your help. It's booting fine now with the
following settings.

Cheers,
Mark

On Sat, Jan 31, 2009 at 2:36 PM, Mark Knecht <markknecht@gmail.com> wrote:
<SNIP>

lightning ~ # uname -a
Linux lightning 2.6.26.8-rt12 #2 PREEMPT RT Sun Feb 1 08:06:03 PST
2009 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ # cat /usr/src/linux-2.6.26.8-rt12/.config | grep CONFIG_RTC
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_V3020 is not set
lightning ~ #
