From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [RFC PATCH 0/3] Series short description
Date: Tue, 11 Nov 2008 13:31:39 -0600
Message-ID: <4919DD9B.1070104@nortel.com>
References: <20081111142323.28477.41235.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, rostedt@goodmis.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zcars04f.nortel.com ([47.129.242.57]:55353 "EHLO
	zcars04f.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYKKTbs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Nov 2008 14:31:48 -0500
In-Reply-To: <20081111142323.28477.41235.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> Hi Ingo, Steven, Peter,
>   This series applies roughly to mainline as an enhancement to the sched_rt
>   logic.  Peter and I were discussing some of the unecessary overhead in
>   pull_rt_tasks() via IRC, and this is my RFC attempt to address the problem.
> 
>   I have built/booted this on a 4-way C2D Xeon box and it passes preempt-test.

At first blush it looks reasonable, but do you have any performance numbers?

Chris
