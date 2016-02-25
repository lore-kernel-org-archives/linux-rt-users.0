From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: AW: Large latencies with 4.4.1-rt6
Date: Thu, 25 Feb 2016 17:29:01 +0100
Message-ID: <56CF2BCD.3050109@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de>
 <20160225152930.GC16161@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB691B6974A2@dlrexmbx03.intra.dlr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54301 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbcBYQ3D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:29:03 -0500
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B6974A2@dlrexmbx03.intra.dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/25/2016 05:08 PM, Martin.Wirth@dlr.de wrote:
> Hi Sebastian

Hi Martin,

> I will have access to the machine for longer testing next Monday again. But I remember that v4.4.1-rt5 showed the same long latencies.
> Will try v4.4-rt3 and v4.4-rt2 beginning of next week.

If this would be your first try I would suggest to run hwlatdetect in
case BIOS is calling for attention. However since you don't see this in
v4.1 is looks unlikely. It also might be help to have a log to see what
the other CPUs are doing around that time. Are they busy doing
something or do they pause as well. Also do try some fancy PM things
(but then again why now and not in v4.1 as well).

> Martin

Sebastian
