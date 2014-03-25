From: "Gary S. Robertson" <gary.robertson@linaro.org>
Subject: [PATCH 0/2] cyclictest: Restore CPU affinity for non-NUMA builds
Date: Tue, 25 Mar 2014 18:05:30 -0500
Message-ID: <1395788732-7311-1-git-send-email-gary.robertson@linaro.org>
Cc: "Gary S. Robertson" <gary.robertson@linaro.org>
To: clark.williams@gmail.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:64577 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaCYXGB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Mar 2014 19:06:01 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so1314429yhn.12
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Mar 2014 16:06:00 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Gary S. Robertson" <gary.robertson@linaro.org>

These patches restore the ability to use the legacy CPU affinity functionality in cyclictest when built without NUMA support.  When cyclictest was patched to add bitmask CPU affinity support with NUMA V2, it broke the existing CPU affinity support for non-NUMA builds.  That patch mapped the legacy CPU affinity behavior (choosing a single core or else all cores) onto the bit-mapped framework when cyclictest was built against NUMA V1 libraries.  I simply extended this mapping to include also the case where cyclictest was built with no NUMA support.

Unfortunately the addition of the extra conditional compilation clauses into the function definitions from that patch made the resulting source code difficult to follow - so I also re-organized the code to make the end result more understandable.  I simply created conditional compilation clauses for the three NUMA-related build configurations (V2, V1, or none).  Then I created separate clean function definitions for each configuration... an extension of the method already used for the non-NUMA configuration case..

The restructuring of the code makes the patch containing changes to rt_numa.h difficult to follow.  If you prefer I can re-work these changes as three patches instead of two... splitting the rt_numa.h patch into one patch which re-organizes the code and a second which applies the changes that fix the CPU affinity bug.


Gary S. Robertson (2):
  Restore CPU affinity function for non-NUMA builds
  Don't offer --numa option when unavailable

 src/cyclictest/cyclictest.c |    2 +
 src/cyclictest/rt_numa.h    |  188 +++++++++++++++++++++++++++----------------
 2 files changed, 121 insertions(+), 69 deletions(-)

-- 
1.7.9.5

