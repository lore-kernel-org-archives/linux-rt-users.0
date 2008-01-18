From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Would like to run better stress test.
Date: Fri, 18 Jan 2008 06:39:25 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801180637360.7574@gandalf.stny.rr.com>
References: <5bdc1c8b0801171553g4f19b844gb29cff10d905a3b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:41257 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYARLj2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Jan 2008 06:39:28 -0500
In-Reply-To: <5bdc1c8b0801171553g4f19b844gb29cff10d905a3b4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 17 Jan 2008, Mark Knecht wrote:

> I found source code for hackbench but no instructions for someone at
> my level to build it. I tried pi_stress but it hung my machine.

$ gcc -o hackbench hackbench.c
$ while :; do ./hackbench 50; done

That's basically all I do.

-- Steve
