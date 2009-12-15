From: Carsten Emde <c.emde@osadl.org>
Subject: Re: [PATCH 4/7] Add the following new tests - ptsematest - sigwaittest
 - svsematest - sendme
Date: Tue, 15 Dec 2009 02:23:48 +0100
Message-ID: <4B26E524.7010602@osadl.org>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com> <1260806336-4691-2-git-send-email-jkacur@redhat.com> <1260806336-4691-3-git-send-email-jkacur@redhat.com> <1260806336-4691-4-git-send-email-jkacur@redhat.com> <1260806336-4691-5-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from swiss.web-alm.ch ([80.74.142.2]:32856 "EHLO swiss.web-alm.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758638AbZLOCPe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 21:15:34 -0500
In-Reply-To: <1260806336-4691-5-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

thanks a lot for taking care of the new tests.

By some reason, the spec file was not included in the patch. This
patch is needed to prevent the rpm build from finding installed
but unpackaged files.


Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--- rt-tests.spec-in-orig       2009-12-15 02:15:36.724746547 +0100
+++ rt-tests.spec-in    2009-12-15 02:16:51.320459770 +0100
@@ -36,10 +36,20 @@
 /usr/bin/signaltest
 /usr/bin/hwlatdetect
 /usr/bin/rt-migrate-test
+/usr/bin/ptsematest
+/usr/bin/sendme
+/usr/bin/sigwaittest
+/usr/bin/svsematest
+
 %doc
 /usr/share/man/man8/cyclictest.8.gz
 /usr/share/man/man8/pi_stress.8.gz
 /usr/share/man/man8/hwlatdetect.8.gz
+/usr/share/man/man4/backfire.4.gz
+/usr/share/man/man8/ptsematest.8.gz
+/usr/share/man/man8/sendme.8.gz
+/usr/share/man/man8/sigwaittest.8.gz
+/usr/share/man/man8/svsematest.8.gz
 
 %changelog
 * Thu Dec 10 2009 Clark Williams <williams@redhat.com> - 0.56-1
