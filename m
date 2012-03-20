From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 3/3] rt-tests: Remove unused status variable
Date: Tue, 20 Mar 2012 12:05:03 -0700
Message-ID: <c85461ecd2a73b044d01ec1880e583764e28492a.1332270303.git.dvhart@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Cc: Darren Hart <dvhart@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12150 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab2CTTGH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:06:07 -0400
In-Reply-To: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
In-Reply-To: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The status variable is not used. Remove it and avoid the warning from gcc.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Clark Williams <williams@redhat.com>
CC: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 0940567..b89dec8 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -596,10 +596,9 @@ void *reporter(void *arg)
 
 int verify_cpu(int cpu)
 {
-	int status;
 	cpu_set_t mask;
 
-	status = sched_getaffinity(0, sizeof(cpu_set_t), &mask);
+	sched_getaffinity(0, sizeof(cpu_set_t), &mask);
 
 	if (CPU_ISSET(cpu, &mask))
 		return SUCCESS;
-- 
1.7.6.5

