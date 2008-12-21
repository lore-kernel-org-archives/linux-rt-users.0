From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: processor isolation inquiry
Date: Sun, 21 Dec 2008 09:53:32 -0500
Message-ID: <494E586C.7070107@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Max Krasnyanskiy <maxk@qualcomm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-kernel-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:54788 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYLUQhS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Dec 2008 11:37:18 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It's been some time now since Max K. brought up the complete processor isolation
discussion. I know his original patch was NAK'd but some work on this was put
into cpusets. I'm unclear as to what actually has been or will be implemented.

The 2 things I'm most interested in are work queues, and local timer interrupts.
Is it yet possible to isolate a processor from either of these 2 things with
recent kernels?

The kernel doc concerning cpusets doesn't seem to clarify this for me.

The Process shielding instructions at

http://rt.wiki.kernel.org/index.php/CPU_shielding_using_/proc_and_/dev/cpuset

don't seem to help with work queues or local timer interrupts. Should they?

Thanks in advance for any pointers
Mark

