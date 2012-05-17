From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Real time micro benchmark suite - thread priority fix
Date: Thu, 17 May 2012 14:15:52 -0700
Message-ID: <4FB56A88.7050705@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18632 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845Ab2EQVPx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 May 2012 17:15:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Not sure whether Real time micro benchmark suite is still being 
maintained at http://sourceforge.net/projects/rtmicrobench. The latest 
code from sourceforge has issues while running rtmb_c tests. It fails 
complaining about not being able to set thread priority.  Here's a fix 
for it.

https://github.com/vsubbiah/rtmb/commit/2a6714030a4009b50b76e99a83bf4b042cc82780

Thanks,
Venkat
