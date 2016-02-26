From: Daniel Wagner <wagi@monom.org>
Subject: Re: swait question
Date: Fri, 26 Feb 2016 11:33:25 +0100
Message-ID: <56D029F5.1080605@monom.org>
References: <56CC0355.6010200@monom.org> <56D02123.5090908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:38470 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcBZKd2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 05:33:28 -0500
In-Reply-To: <56D02123.5090908@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On 02/26/2016 10:55 AM, Sebastian Andrzej Siewior wrote:
> On 02/23/2016 07:59 AM, Daniel Wagner wrote:
>> Sebastian would you mind integrating the new version of the swait
>> patches? I guess it doesn't hurt to give them a some testing via the -rt
>> tree.
> 
> I will integrate them in a later release. Not the one I plan for today
> but probably one after that.

Excellent. Thomas applied the patches to tip/sched/core yesterday. So I
guess they will show up in 4.6 if things work out.

cheers,
daniel
