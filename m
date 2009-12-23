From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH 2/5] rt-tests: Add a new test pip - priority inheritance
 with processes
Date: Wed, 23 Dec 2009 23:52:39 +0100
Message-ID: <4B329F37.8040508@osadl.org>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com> <1261584180-13922-2-git-send-email-jkacur@redhat.com> <1261584180-13922-3-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:44979 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157AbZLWXAc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 18:00:32 -0500
In-Reply-To: <1261584180-13922-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

When creating an RPM package with the newly provided test pip, the message
error: Installed (but unpackaged) file(s) found:
   /usr/bin/pip
appeared, and rpmbuild refused to finish building the package.

	Carsten.

-=--------------------------------------------------------------------=-

Prevent rpmbuild from finding installed but unpackaged files.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

diff --git a/rt-tests.spec-in b/rt-tests.spec-in
index 5ca08ee..a55a9ba 100644
--- a/rt-tests.spec-in
+++ b/rt-tests.spec-in
@@ -35,6 +35,7 @@ rm -rf $RPM_BUILD_ROOT
 /usr/bin/signaltest
 /usr/bin/hwlatdetect
 /usr/bin/rt-migrate-test
+/usr/bin/pip
 /usr/bin/ptsematest
 /usr/bin/sendme
 /usr/bin/sigwaittest
