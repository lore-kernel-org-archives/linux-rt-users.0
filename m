Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753960AbeFTNWF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38342C0587E3
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jun 2018 13:22:05 +0000 (UTC)
Date: Wed, 20 Jun 2018 10:21:31 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH rt-tests] queuelat: fix get_cpuinfo_mhz.sh script on SMP
 systems
Message-ID: <20180620132129.GA7983@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org


get_cpuinfo_mhz.sh fails on SMP systems because 
/proc/cpuinfo returns multiple "cpu MHz" containing
lines.

Get only the first one.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
index fb5158f..46f94c4 100755
--- a/src/queuelat/get_cpuinfo_mhz.sh
+++ b/src/queuelat/get_cpuinfo_mhz.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
 
-mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " "`
+mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " " | head -1`
 echo $mhz
 
