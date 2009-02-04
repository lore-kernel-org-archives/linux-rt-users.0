From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Hard lockup with 2.6.24.7-rt26 on x86
Date: Wed, 4 Feb 2009 12:56:26 +0100
Message-ID: <3efb10970902040356y46cb304bi2855769398d16439@mail.gmail.com>
References: <37144.1233608136@vtxmail.ch>
	 <3efb10970902031120g21b4586k4e7f2f03bbca6c77@mail.gmail.com>
	 <902d99b50902040046u3257591fxe29cef4e62315b1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Denis Borisevich <dennisfen@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:30196 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZBDL41 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 06:56:27 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1367799qwe.37
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Feb 2009 03:56:26 -0800 (PST)
In-Reply-To: <902d99b50902040046u3257591fxe29cef4e62315b1a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Denis,

Please keep the mailinglist on the CC.

Kind Regards,

Remy

2009/2/4 Denis Borisevich <dennisfen@gmail.com>:
> 2009/2/3 Remy Bohmer <linux@bohmer.net>:
>> In noticed some hangups too while using 2.6.24.7-rt26, while
>> 2.6.24.7-rt20 was running fine.
>> I can reproduce it here on an ARM11 core, when
>> CONFIG_DEBUG_LOCKING_API_SELFTESTS is set the system hangs during boot
>> on rt26, while it boots properly on rt20. So, there is a regression
>> here.
>
> I second that. With CONFIG_DEBUG_LOCKING_API_SELFTEST system hangs on
> boot with -rt26.
>
> --
> Denis
>
