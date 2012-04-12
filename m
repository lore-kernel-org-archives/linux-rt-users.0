From: "Moore, Thomas (FtWorth)" <Thomas.Moore2@ATK.COM>
Subject: File I/O in a Realtime Process
Date: Thu, 12 Apr 2012 16:21:48 +0000
Message-ID: <7B6FE55CD594D7478CED8A39DF3BFC0A02B4FE@UT40SEM2.atk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx-ut1.atk.com ([192.112.60.130]:52649 "EHLO atk.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757840Ab2DLQg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Apr 2012 12:36:56 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

In reviewing the documentation for the PREEMPT_RT patch, it's made pretty clear that performing file I/O (or page faults in general) will degrade realtime performance. The "HOWTO: Build an RT-application" on the wiki also states that page faults from one application will not interfere with the realtime performance of an application. Based on this understanding, if a system utilizing the PREEMPT_RT patch had requirements to perform file I/O, would it be required to have a separate non-realtime process that performs this task or would it be possible to use a low priority thread in the realtime process?

Thanks,

Thomas Moore
