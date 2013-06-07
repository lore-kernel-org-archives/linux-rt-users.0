From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 07 Jun 2013 13:36:44 +0200
Message-ID: <51B1C5CC.7010306@linutronix.de>
References: <1368437465.11686.60.camel@marge.simpson.net>  <20130607090300.GC10280@linutronix.de> <1370603848.5854.42.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45889 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3FGLgq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 07:36:46 -0400
In-Reply-To: <1370603848.5854.42.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/07/2013 01:17 PM, Mike Galbraith wrote:
> On Fri, 2013-06-07 at 11:03 +0200, Sebastian Andrzej Siewior wrote:
> 
>> The "panic" says "Oops" so your karnel most likely hit a NULL pointer.
>> The completion you say is missing might run into the NULL pointer
>> problem. Any way to get the backtrace from the oops?
> 
> The oops is just me poking sysrq-c to crash the box.

Ach. This does not make any easier then.

> 
> -Mike
> 

Sebastian
