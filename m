From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: cyclictest better values with system load than without (OMAP3530
 target)
Date: Fri, 29 Nov 2013 17:36:34 +0100
Message-ID: <5298C292.2030502@xenomai.org>
References: <5294681E.10406@gmail.com> <20131126101232.21636c8f@sluggy> <20131129125623.GB31099@linutronix.de> <5298AE4B.7070806@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Stefan Roese <stefan.roese@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sd-51317.dedibox.fr ([62.210.215.82]:56243 "EHLO
	sd-51317.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121Ab3K2QxT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 11:53:19 -0500
In-Reply-To: <5298AE4B.7070806@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/29/2013 04:10 PM, Carsten Emde wrote:
> BTW: Power saving and real-time do not necessarily exclude each other.
> If a - still deterministic - but a little longer latency is acceptable,
> some light sleep states and a somewhat lower clock frequency may be
> allowed which still may result in considerable energy saving. If,
> however, the fastest possible real-time response is required, C states
> and P states must be disabled (or set to polling and maximum speed,
> repsectively) and the power bill must be payed.

Well, I do not fully agree. To be sure that you can clock down the 
processor for executing a task which has sufficient time to meet its 
deadline, your system must be "time triggered", all the timer events 
must be known in advance. Because on a fully dynamic system, you may 
make that decision, but a new timer may be scheduled which causes the 
system to miss its deadline whereas it would not have missed it if it 
had run at full speed.

-- 
					    Gilles.
