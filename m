From: Joakim Hernberg <jbh@alchemy.lu>
Subject: [RFC PATCH] make SMP option only use online cpus (cyclictest)
Date: Thu, 14 Aug 2014 19:29:29 +0200
Message-ID: <20140814192929.004ab9d7@alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:44703 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbaHNR3h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 13:29:37 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When I boot my 8 core i7 laptop with the maxcpus=4 kernel boot flag,
cyclictest -S runs 8 threads.  This patch makes it only use the online
cpus instead.

diff --git a/src/cyclictest/cyclictest.c
b/src/cyclictest/cyclictest.c index 4547831..92fc346 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1740,7 +1740,7 @@ int main(int argc, char **argv)
        sigset_t sigset;
        int signum = SIGALRM;
        int mode;
-       int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+       int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
        int i, ret = -1;
        int status;
 
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index e64c446..c2b3e85 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -128,7 +128,7 @@ static int rt_numa_numa_node_of_cpu(int cpu)
        int max_node, max_cpus;
 
        max_node = numa_max_node();
-       max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+       max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
        if (cpu > max_cpus) {
                errno = EINVAL;

--

   Joakim
