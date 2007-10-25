From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Interrupt Latency module for intel
Date: Wed, 24 Oct 2007 21:35:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710242131550.13877@gandalf.stny.rr.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:56279 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbXJYBfL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 21:35:11 -0400
In-Reply-To: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sat, 20 Oct 2007, Jaswinder Singh wrote:

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

Wow 12.570 ms latencies!

Heh, thanks for showing that dynamic ticks work.

-- Steve
