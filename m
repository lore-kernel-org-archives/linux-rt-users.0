From: Darren Hart <dvhltc@us.ibm.com>
Subject: Breaking out of pthread_mutex_lock
Date: Thu, 29 May 2008 23:41:55 +0000
Message-ID: <1212104515.14713.96.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:56749 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYE2Xl4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 19:41:56 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TNftF9015021
	for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 19:41:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4TNftWn107280
	for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 17:41:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4TNft3p021666
	for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 17:41:55 -0600
Received: from [9.67.193.238] (wecm-9-67-193-238.wecm.ibm.com [9.67.193.238])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m4TNfsQ3021637
	for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 17:41:54 -0600
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I find I need to be able to break out of the blocked state while waiting
to acquire a pthread_mutex.  I'm using PI mutexes and want to continue
to do so.  As I understand it, I can't use a signal to break out of the
lock as the man pages states:

"If a signal is delivered to a thread waiting for a mutex,  upon  return
from  the  signal handler the thread shall resume waiting for the mutex
as if it was not interrupted."

and that pthread_mutex_lock will not return EINTR.  I had considered
using cond variables, but I don't think they will provide the same PI
behavior (since the threads are not blocked on the mutex while awaiting
the pthread_cond_signal - right?).

I'm sure I'm not the first to want to do this, does anyone know of a
common best practice for accomplishing such a thing?

-- 
Darren Hart
Real-Time Linux Team
IBM Linux Technology Center

