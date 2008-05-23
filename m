From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: [PATCH -rt] gitignore Module.markers
Date: Fri, 23 May 2008 12:37:40 -0700
Message-ID: <48371D04.9050906@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:36347 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYEWThn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 May 2008 15:37:43 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index fdcce40..3d04ea7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,6 +28,7 @@ vmlinux*
 !vmlinux.lds.S
 System.map
 Module.symvers
+Module.markers
 !.gitignore
 
 #
-- 
1.5.4.1

