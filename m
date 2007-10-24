From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Interrupt Latency module for intel
Date: Wed, 24 Oct 2007 12:52:55 -0700
Message-ID: <1193255575.3557.2.camel@imap.mvista.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:30520 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbXJXT4y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 15:56:54 -0400
In-Reply-To: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-10-20 at 12:06 +0530, Jaswinder Singh wrote:
> hello all,
> 
> On my Intel Pentium 4 with linux-2.6.23-rc8-rt1, I am getting :
> 
> Interrupt Latency result
> ------------------------
> MAX latency : 12.570 micro-seconds
> MIN latency : 3.352 micro-seconds
> AVG latency : 4.190 micro-seconds
> Total Samples : 32583
> 
> Please review this interrupt latency module and give your feedback.

Have you noticed there is at least one other way to measure this with
existing tools? With high resolution timers you could do this from
userspace..

Daniel
