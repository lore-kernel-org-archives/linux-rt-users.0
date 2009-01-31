From: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.26.8-rt12 - No hwclock - works under 2.6.24-rt1
Date: Sat, 31 Jan 2009 14:36:56 -0800
Message-ID: <5bdc1c8b0901311436vae23e5du3ceb54e6fdb19988@mail.gmail.com>
References: <5bdc1c8b0901301600k13a06b0laf048293f037374c@mail.gmail.com>
	 <20090131085221.7fc4458d@torg>
	 <5bdc1c8b0901310958s555cfc0eg3ba649947d2581@mail.gmail.com>
	 <20090131132041.6b65408c@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:4767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbZAaWg6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Jan 2009 17:36:58 -0500
Received: by rv-out-0506.google.com with SMTP id k40so958591rvb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Jan 2009 14:36:57 -0800 (PST)
In-Reply-To: <20090131132041.6b65408c@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jan 31, 2009 at 11:20 AM, Clark Williams <williams@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Sat, 31 Jan 2009 09:58:28 -0800
> Mark Knecht <markknecht@gmail.com> wrote:
>>
>> Clark,
>>    CONFIG_RTC_DRV_CMOS=y is set. However all of the specific chip
>> versions immediately below it are not set so without at least one of
>> those is the CONFIG_RTC_DRV_CMOS doing anything?
>>
>>    If by change I need to set at least one of those chip options how
>> do I determine what's on this motherboard?
>>
>>    Scanning around this area I also notice that I've going none of the
>> I2C RTC drivers selected either.
>>
>>    I haven't had time to check yet but the 2.6.27-gentoo-r8 kernel
>> didn't have this problem. I'll compare .config files between the two
>> and see what differences I can find.
>>
>> Thanks,
>> Mark
>
> Mark,
>
> I don't have any of the platform drivers set for my laptop (Lenovo T60)
> other than the CMOS driver.  None of the I2C or SPI drivers set. I
> still think you need to look at what device the startup scripts are
> looking for (probably /dev/rtc).
>
> Here's a snippet of my config:
>
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_DEBUG=y
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
>
> #
> # SPI RTC drivers
> #
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_V3020 is not set
>
>
> Clark

Clark,
   Thanks. This is helpful. Turns out I have a number of
inconsistencies in these 3 kernels. Neither of my old RT kernels have
CONFIG_RTC_DRV_CMOS set. However 2.6.24-rt1 worked and 2.6.26.8-rt12
doesn't. Now, the newer Gentoo kernel, 2.6.27-gentoo-r8 did have that
set and that kernel works, so for now I'm suspecting that if I enable
that maybe 2.6.26.8-rt12 will start working. We'll see. I cannot do
anything until some other work on the machine finishes. In the
meantime I'm looking around for how Gentoo sets the /dev/rtc link.

I've snipped out anything not set for readability.

[[ Real-Time - WORKS ]]

lightning src # cat linux-2.6.24-rt1/.config | grep CONFIG_RTC
CONFIG_RTC=y
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y



[[ Real-Time - FAILS ]]

lightning src # cat linux-2.6.26.8-rt12/.config | grep CONFIG_RTC
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y



[[ Gentoo non-RT - WORKS]]

lightning src # cat linux-2.6.27-gentoo-r8/.config | grep CONFIG_RTC
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_DRV_CMOS=y

thanks much!

- Mark
