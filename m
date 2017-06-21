From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH 0/3] cyclictest: Better handle offline CPUs
Date: Wed, 21 Jun 2017 15:25:31 -0700
Message-ID: <20170621222534.24125-1-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Allen Martin <amartin@nvidia.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13271 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdFUWZr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2017 18:25:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When running cyclictest with -t and -a options one thread is created
per online CPU.  However if there are any offline CPUs the affinity of
the threads created is incorrect.  This is because cyclictest assumes
the online CPUs are numbered 0..N where N is the number of online
CPUs.  In reality there can be holes in the online CPU numbering.
This patch series fixes this by checking the online status of each CPU
via sysfs before setting the CPU affinity.  It also adds some sanity
checking by reading back the CPU affinity after setting it to see if
it was set correctly.

Allen Martin (3):
  Android: add pthread_getaffinity_np()
  cyclictest: read back CPU affinity to verify
  cyclictest: Handle non sequential online CPU numbering

 src/cyclictest/cyclictest.c | 61 +++++++++++++++++++++++++++++++++++++--------
 src/include/bionic.h        |  6 +++++
 2 files changed, 57 insertions(+), 10 deletions(-)

-- 
2.11.0

