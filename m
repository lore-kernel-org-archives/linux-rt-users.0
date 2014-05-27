From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] arm: Set hardirq tracing to on when idling
Date: Tue, 27 May 2014 11:53:59 -0700
Message-ID: <5384DF47.2070904@codeaurora.org>
References: <1401045323-7116-1-git-send-email-minyard@acm.org> <4559339.apo3Fd10HK@wuerfel> <5384BF89.6010509@meduna.org> <4475199.26Fs5MKAfh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org,
	Corey Minyard <cminyard@mvista.com>,
	linux-kernel@vger.kernel.org, Stanislav Meduna <stano@meduna.org>,
	minyard@acm.org, linux-rt-users@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4475199.26Fs5MKAfh@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/27/14 11:49, Arnd Bergmann wrote:
>
> You also commented in that thread about stop_critical_timings()/
> start_critical_timings(). Corey, can you look at that, too? I
> think it's designed to avoid the issue you are seeing but
> for some reason doesn't.

I sent a patch last week to "solve" this problem. I'm not sure if it's
right but it works for me.

https://lkml.org/lkml/2014/5/19/607

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
