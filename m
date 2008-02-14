From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2.6.24-rt1] timer:fix build warning in timer.c
Date: Thu, 14 Feb 2008 07:38:03 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802140737370.20595@gandalf.stny.rr.com>
References: <47B411A6.9030007@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	khilman@mvista.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Shi Weihua <shiwh@cn.fujitsu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36546 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223AbYBNMoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Feb 2008 07:44:46 -0500
In-Reply-To: <47B411A6.9030007@cn.fujitsu.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 14 Feb 2008, Shi Weihua wrote:

> Fix the following compile warning without CONFIG_PREEMPT_RT:
> kernel/timer.c:937: warning: =E2=80=98count_active_rt_tasks=E2=80=99 =
defined but not used
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

Thanks, applied.

-- Steve
