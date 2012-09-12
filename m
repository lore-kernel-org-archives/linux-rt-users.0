From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 0/2] rt-tests: Makefile fixes for PYLIB and hwlatdetect
Date: Tue, 11 Sep 2012 17:41:51 -0700
Message-ID: <1347410513-23165-1-git-send-email-dvhart@linux.intel.com>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51659 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab2ILAmd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 20:42:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For cross-build-systems, it is necessary to specify the PYLIB path. It is also
useful to treat hwlatdetect separately from the rest of the tests as it pulls in
a number of python dependencies.

