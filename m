From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH 3/4] rt-tests: Clean-up - protect rt-utils.h
Date: Tue, 22 Dec 2009 00:43:40 +0100
Message-ID: <4B30082C.80107@osadl.org>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>	<1261431950-28500-2-git-send-email-jkacur@redhat.com>	<1261431950-28500-3-git-send-email-jkacur@redhat.com>	<1261431950-28500-4-git-send-email-jkacur@redhat.com>	<4B30002F.3030209@osadl.org> <20091221171913.5ae81e6d@torg>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050607020905000006020402"
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37536 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbZLUXtV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 18:49:21 -0500
In-Reply-To: <20091221171913.5ae81e6d@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050607020905000006020402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Clark,

>>> Clean-up: Protect rt-utils.h with #ifndef RT_UTILS_H
>>> [..]
>>> +#ifndef RT_UTILS.H
>> Macro names should only consist of alphanumeric characters and
>> underscores, i.e. 'a-z', 'A-Z', '0-9', and '_', and the first character
>> should not be a digit.
> Yeah, I caught that and also pushed it out of application name space
> with two leading underscores. 
Great.

I did some first tests on 0.58, and all works very well now. Thanks a
lot, you and John, for all the work!

As a very minor issue, the below patch still didn't make it into your
tree.

	Carsten.

-=--------------------------------------------------------------------=-
Explain in the sendme error message how to make the backfire module,
if not available.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------050607020905000006020402
Content-Type: text/x-patch;
 name="explain-howto-make-backfire-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="explain-howto-make-backfire-module.patch"

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index fdc1056..1f02c72 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -209,7 +209,12 @@ int main(int argc, char *argv[])
 	path = open("/dev/backfire", O_RDWR);
 	if (path < 0) {
 		fprintf(stderr, "ERROR: Could not access backfire device, "
-				"try 'modprobe backfire'\n");
+				"try 'modprobe backfire'.\n"
+				"If the module backfire can't be loaded, "
+				"it may need to be built first.\n"
+				"Execute 'cd src/backfire; make' in the "
+				"rt-tests directory (requires rt-tests\n"
+				"sources and kernel-devel package).\n");
 		return 1;
 	}
 	fl.l_type = F_WRLCK;

--------------050607020905000006020402--
