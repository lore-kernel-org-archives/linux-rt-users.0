From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH] rt-tests: NUMA optional for make rpm
Date: Fri, 8 Feb 2013 18:28:50 -0800
Message-ID: <5115B462.3050307@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <jkacur@redhat.com>, <sven@thebigcorporation.com>,
	<linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:44573 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab3BIC3G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 21:29:06 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I'm not sure if this is worth fixing, but...

rt-tests can be built without NUMA:

   make NUMA=0

But "make rpm" does not have a way to be successful without NUMA:

   build_rt-tests_0.85> make rpm
   for F in cyclictest signaltest pi_stress rt-migrate-test ptsematest sigwaittest svsematest pmqtest sendme pip_stress hackbench *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a  ChangeLog; do find -type f -name $F | xargs rm -f; done
   rm -f hwlatdetect
   rm -f tags
   rm -rf BUILD BUILDROOT RPMS SRPMS SPECS releases *.tar.gz rt-tests.spec tmp
   git log >ChangeLog
   mkdir -p releases
   mkdir -p tmp/rt-tests
   cp -r Makefile COPYING ChangeLog src tmp/rt-tests
   tar -C tmp -czf rt-tests-0.85.tar.gz rt-tests
   rm -f ChangeLog
   cp rt-tests-0.85.tar.gz releases
   sed s/__VERSION__/0.85/ <rt-tests.spec-in >rt-tests.spec
   rpmbuild -ba --define "_topdir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85" --define "_sourcedir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85/releases" --define "_builddir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85/BUILD"  rt-tests.spec
   error: Failed build dependencies:
           numactl-devel is needed by rt-tests-0.85-1.fc12.src
   make: *** [rpm] Error 1


The following patch allows the rpm to be built without NUMA, with the command:

   make NUMA=0 rpm

This is a somewhat ugly implementation, other suggestions are welcome.


Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

---
 Makefile |    4 	4 +	0 -	0 !
 1 file changed, 4 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -161,6 +161,10 @@ pushtest: release
 
 rt-tests.spec: Makefile rt-tests.spec-in
 	sed s/__VERSION__/$(VERSION_STRING)/ <$@-in >$@
+ifneq ($(NUMA),1)
+	sed -i -e 's/numactl-devel//' -e 's/make NUMA=1/make NUMA=0/' $@
+endif
+
 
 HERE	:=	$(shell pwd)
 RPMARGS	:=	--define "_topdir $(HERE)" 	\

