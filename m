From: Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH] cyclictest: fix accumulating overruns in periodic timer mode
Date: Mon, 10 May 2010 14:23:50 +0200
Message-ID: <20100510122350.9777.54326.stgit@leela.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab0EJMXy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 May 2010 08:23:54 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4ACNrj1019459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Mon, 10 May 2010 08:23:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When using a POSIX interval timer and an overrun occurs, a signal is always
lost. From then on cyclictest would report all measurements as increased by
N*period (where N is the number of overruns).

cyclictest can detect the overruns and adjust the expected time of the next
tick accordingly.

Reported-by: Marti Raudsepp <marti@juffo.org>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---

 src/cyclictest/cyclictest.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3a7e752..6829d34 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -713,6 +713,11 @@ void *timerthread(void *param)
 
 		next.tv_sec += interval.tv_sec;
 		next.tv_nsec += interval.tv_nsec;
+		if (par->mode == MODE_CYCLIC) {
+			int overrun_count = timer_getoverrun(timer);
+			next.tv_sec += overrun_count * interval.tv_sec;
+			next.tv_nsec += overrun_count * interval.tv_nsec;
+		}
 		tsnorm(&next);
 
 		if (par->max_cycles && par->max_cycles == stat->cycles)

