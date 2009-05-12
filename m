From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH]sched: fix typo in sched-rt-group.txt file
Date: Tue, 12 May 2009 17:37:39 +0900
Message-ID: <1242117459.31161.11.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9amiSwTwJ4yBkhGS20Rt"
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>, williams <williams@redhat.com>,
	a.p.zijlstra@chello.nl
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:32154 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbZELJwd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 May 2009 05:52:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-9amiSwTwJ4yBkhGS20Rt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




Dear Ingo,

I found typo about the range of static priority ( = realtime priority )
in "./Documentation/scheduler/sched-rt-group.txt" file.

If I don't understand static priority levels, Correct me.


commit d6af702008117ca489a2f5476239d1688a517e98
Author: GeunSik,Lim <leemgs1@gmail.com>
Date:   Tue May 12 17:20:32 2009 +0900

    sched: fix typo in sched-rt-group.txt file
    
    Fix typo about static priority's range.
     Kernel Space priority: 0   to 99   --> User Space RT priority 99 to 0
     Kernel Space priority: 100 to 139  --> User Space nice -20 to 19
    
    Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index 5ba4d3f..1537146 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.txt
@@ -169,7 +169,7 @@ get their allocated time.
 
 Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
 the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-139. With deadline scheduling you need to
+the limited static priority levels 0-99. With deadline scheduling you need to
 do deadline inheritance (since priority is inversely proportional to the
 deadline delta (deadline - now).
 


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://intomail.dnip.net/invain/me/
-----------------------------------------------

--=-9amiSwTwJ4yBkhGS20Rt
Content-Disposition: attachment; filename=fix-typo-static-priority-levels.patch
Content-Type: text/x-patch; name=fix-typo-static-priority-levels.patch; charset=euckr
Content-Transfer-Encoding: 7bit

commit d6af702008117ca489a2f5476239d1688a517e98
Author: GeunSik,Lim <leemgs1@gmail.com>
Date:   Tue May 12 17:20:32 2009 +0900

    sched: fix typo in sched-rt-group.txt file
    
    Fix typo about static priority's range.
     Kernel Space priority: 0   to 99   --> User Space RT priority 99 to 0
     Kernel Space priority: 100 to 139  --> User Space nice -20 to 19
    
    Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index 5ba4d3f..1537146 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.txt
@@ -169,7 +169,7 @@ get their allocated time.
 
 Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
 the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-139. With deadline scheduling you need to
+the limited static priority levels 0-99. With deadline scheduling you need to
 do deadline inheritance (since priority is inversely proportional to the
 deadline delta (deadline - now).
 

--=-9amiSwTwJ4yBkhGS20Rt--

