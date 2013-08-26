From: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Subject: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Mon, 26 Aug 2013 14:28:35 +0200
Message-ID: <OF6C5E1E92.67FE0167-ONC1257BD3.0043D8B2-C1257BD3.00448947@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:44753 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab3HZMni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Aug 2013 08:43:38 -0400
In-Reply-To: 
References: 
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT community,

I have a question regarding the configuration of real-time tasks in PREEMPT
_RT kernels > 2.6.33.
Up to now, I only have experience with 2.6.33-rt.

I use the openPOWERLINK[1] real-time ethernet stack, and have it running on an x86-box with Ubuntu 13.04.
I try to use it with two different kernel versions:
* 2.6.33.7.2-rt30
* 3.2.48-rt69

When I use kernel version 2.6.33, I get very good results (jitter of ethernet frames on the network < +/-10us).
But when I use kernel version 3.2, the results are much worse. The jitter on the network increases up to +/-50us.

In my configuration, the openPOWERLINK stack consists of a kernel module (data link layer) and a user space application.

I know that in 2.6.33 there were splitted softirqs, and that it was possible to configure each thread with its own priority.
What are the steps that need to be done in 3.x to achieve similar results as in 2.6.33?

kind regards,
Wolfgang Wallner

[1] http://sourceforge.net/projects/openpowerlink/

PS: Running cyclictest (e.g. sudo cyclictest -p 99 -n -i 500) on both kernels shows very similar results (avg latency: 15us, max latency 35us). 
