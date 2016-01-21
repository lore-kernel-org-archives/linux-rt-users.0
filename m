From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/2] cyclictest: SMI count/detection via MSR/SMI counter
Date: Thu, 21 Jan 2016 16:08:28 -0200
Message-ID: <cover.1453397401.git.bristot@redhat.com>
Cc: Len Brown <len.brown@intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759987AbcAUSIv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2016 13:08:51 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Use the MSR/SMI counter on Intel's processor to detect/count SMIs. It is
based on turbostat's implementation.

Daniel Bristot de Oliveira (2):
  cyclictest: SMI count/detection via MSR/SMI counter
  cyclictest: Add --smi description on cyclictest man page

 src/cyclictest/cyclictest.8 |   4 +
 src/cyclictest/cyclictest.c | 229 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 223 insertions(+), 10 deletions(-)

-- 
2.5.0

