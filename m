From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH 0/3] cyclictest: improvements to histogram overflow instance mode
Date: Wed, 19 Dec 2012 12:00:30 -0800
Message-ID: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Cc: frank.rowand@am.sony.com, jkacur@redhat.com,
	Bhavesh Davda <bhavesh@vmware.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:54306 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab2LSUA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 15:00:56 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch series makes usability improvements to the histogram overflow
instance tracking mode, as suggested by Frank Rowland.

Bhavesh Davda (3):
  cyclictest: new command line switch for histogram overflow instance
    tracking
  cyclictest: Report histogram overflow instances in seconds since
    start
  cyclictest: Print histogram overflow instances only if asked for

 src/cyclictest/cyclictest.c |   72 +++++++++++++++++++++++++++++++++---------
 1 files changed, 56 insertions(+), 16 deletions(-)

-- 
1.7.4.1

