From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH -rt 0/4] ARM: OMAP: Add clocksource and clockevent driver
 for OMAP
Date: Fri, 22 Dec 2006 09:25:45 +0100
Message-ID: <458B9689.7070300@gmail.com>
References: <458A471C.3090402@gmail.com> <20061221094341.GA9203@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	David Brownell <dbrownell@users.sourceforge.net>,
	dwalker@mvista.com, khilman@mvista.com,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:19895 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945979AbWLVIZt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Dec 2006 03:25:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2906868uga
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Dec 2006 00:25:48 -0800 (PST)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061221094341.GA9203@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:
> * Dirk Behme <dirk.behme@googlemail.com> wrote:
>>
>>the following patches for CONFIG PREEMPT RT add clocksource and 
>>clockevent driver for ARM based TI OMAP devices.
>>
>>They are against linux-2.6.19 + patch-2.6.20-rc1 + 
>>patch-2.6.20-rc1-rt1. The clocksource patch went through several 
>>review cycles on OMAP list.
> 
> thanks. I've added them to the -rt tree and it should be in the next 
> release (2.6.20-rt2).

I just tried -rt3 (linux-2.6.19 + patch-2.6.20-rc1 + 
patch-2.6.20-rc1-rt3) on embedded ARM based TI OMAP OSK 
board. It compiles and boots without any additional patches :)

Hopefully -rt will be merged into mainline someday soon.

Thanks

Dirk
