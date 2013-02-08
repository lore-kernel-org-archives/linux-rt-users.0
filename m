From: Frank Rowand <frank.rowand@am.sony.com>
Subject: rt-tests: make rpm fails if numactl-devel is missing
Date: Fri, 8 Feb 2013 15:03:50 -0800
Message-ID: <51158456.8000009@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Clark Williams <williams@redhat.com>, <jkacur@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:31053
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1947094Ab3BHXDs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 18:03:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm not sure what the best solution for this is.  Or if it is even
worth fixing.  So just reporting for the archives...

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



-Frank

