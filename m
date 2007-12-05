From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: Problems with cyclictest and ps
Date: Thu, 06 Dec 2007 00:35:46 +0100
Message-ID: <475735D2.3070003@arcor.de>
References: <47570B50.9060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Phil K." <binutz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:41887 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbXLEXf6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 18:35:58 -0500
In-Reply-To: <47570B50.9060502@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Phil K. wrote:
> I tried cyclictest under Debian Lenny with Kernel-2.6.23.8-hrt3 and
> Kernel-2.6.22 as user root. As decribed on the cyclictest-wikipage all
> cyclictest-tasks run with the scheduler class SCHED_FIFO. I controlled
> the scheduler class with "ps -ce" and ps showed me SCHED_OTHER for the
> cyclictest-task.

I had the same problem using 2.6.23.9-rt12 on Debian Etch
(schedutils-1.5.0-1) today. When checking the current state of
cyclictest with chrt (chrt -p <pid of cyclictest), it always reported
SCHED_OTHER and priority 0.
When I tried to change the scheduling policy and/or priority with chrt
it seemed to fail as well (not sure whether it tells the truth though).
On the other hand starting cyclictest via chrt did the trick:
"chrt -f 80 cyclictest..."

I can provide further details, when I am closer to the machine in
question tomorrow.

Cheers,

  Florian
