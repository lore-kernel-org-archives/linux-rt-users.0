From: Josh Cartwright <josh.cartwright@ni.com>
Subject: [PATCH rt-tests] gitignore: add librttest.a to git ignore
Date: Thu, 18 Oct 2012 11:23:59 -0500
Message-ID: <20121018162359.GA27911@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:47342 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2JRQXz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2012 12:23:55 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit fb7ef61416b6b191a5186a715e51792847de883c introduced librttest.a
as a library, but did not add it to .gitignore.  Add it now.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 047925c..f7ba1d0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,6 +27,7 @@ SRPMS
 /pip_stress
 /hackbench
 /pmqtest
+librttest.a
 
 rt-tests.spec
 tags
-- 
1.7.12.3
