From: Chris Friesen <chris.friesen@windriver.com>
Subject: semantics of reader/writer semaphores in rt patch
Date: Thu, 23 Oct 2014 13:27:52 -0600
Message-ID: <544956B8.2000406@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55807 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbaJWT1y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Oct 2014 15:27:54 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s9NJRrtm000528
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Oct 2014 12:27:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I recently noticed that when CONFIG_PREEMPT_RT_FULL is enabled we the 
semantics change.  From "include/linux/rwsem_rt.h":

  * Note that the semantics are different from the usual
  * Linux rw-sems, in PREEMPT_RT mode we do not allow
  * multiple readers to hold the lock at once, we only allow
  * a read-lock owner to read-lock recursively. This is
  * better for latency, makes the implementation inherently
  * fair and makes it simpler as well.

How is this valid?  It seems to me that there are any number of code 
paths that could depend on having multiple threads of execution be able 
to hold the reader lock simultaneously.  Something as simple as:

thread A:
take rw_semaphore X for reading
take lock Y, modify data, release lock Y
wake up thread B
wait on conditional protected by lock Y
free rw_semaphore X

thread B:
take rw_semaphore X for reading
wait on conditional protected by lock Y
send message to wake up thread A
free rw_semaphore X


In the regular kernel this would work, in the RT kernel it would deadlock.

Does the RT kernel just disallow this sort of algorithm?

Chris
