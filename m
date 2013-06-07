From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.11-rt8 NFS triggered seizures
Date: Fri, 07 Jun 2013 14:55:10 +0200
Message-ID: <51B1D82E.8090802@linutronix.de>
References: <1368437465.11686.60.camel@marge.simpson.net>  <20130607090300.GC10280@linutronix.de>  <1370603848.5854.42.camel@marge.simpson.net>  <51B1C5CC.7010306@linutronix.de>  <1370608481.5854.60.camel@marge.simpson.net>  <51B1D631.9040804@linutronix.de> <1370609428.5854.67.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46272 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3FGMzM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 08:55:12 -0400
In-Reply-To: <1370609428.5854.67.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/07/2013 02:50 PM, Mike Galbraith wrote:
>> This is actually something I'm looking at right now. But I can trigger
>> this only with CPU-hotplug. You don't play with CPU-hotplug, do you?
> 
> No.  Hm, I may have shut the lid due to bandwidth irritating me though.

suspend & resumes drives the CPUs down & up so this could be it.

> -Mike

Sebastian
