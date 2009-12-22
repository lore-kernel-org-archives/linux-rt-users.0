From: David Sommerseth <davids@redhat.com>
Subject: [PATCH 2/4] Missing parsing of --mlockall in signaltest
Date: Tue, 22 Dec 2009 16:47:36 +0100
Message-ID: <1261496858-12744-3-git-send-email-davids@redhat.com>
References: <1261496858-12744-1-git-send-email-davids@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com,
	David Sommerseth <davids@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbZLVPrn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 10:47:43 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMFlhsf029515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 10:47:43 -0500
In-Reply-To: <1261496858-12744-1-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: David Sommerseth <davids@redhat.com>
---
 src/signaltest/signaltest.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b637aae..24ac959 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -235,6 +235,7 @@ static void process_options (int argc, char *argv[])
 			{"quiet", no_argument, NULL, 'q'},
 			{"threads", required_argument, NULL, 't'},
 			{"verbose", no_argument, NULL, 'v'},
+			{"mlockall", no_argument, NULL, 'm'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-- 
1.6.2.5

