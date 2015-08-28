From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 0/4] build tweaks and a bug fix
Date: Thu, 27 Aug 2015 19:19:47 -0500
Message-ID: <cover.1440720422.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>,
	Robert Yang <liezhi.yang@windriver.com>,
	Kai Kang <kai.kang@windriver.com>,
	"Song.Li" <Song.Li@windriver.com>,
	Jesse Zhang <sen.zhang@windriver.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:33516 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751882AbbH1ATy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2015 20:19:54 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey John, Clark-

This series has a few minor rt-tests tweaks that make it a bit easier to build
and package rt-tests for the bizarro build demands in the embedded space.  With
a bug fix thrown in for good measure.

The first patch breaks the assumption that build host == target; the second
patch allows a packager to more easily split hwlatdetect into a separate
package.  (Both of these patches are unchanged since Darren's original
submission in 2012[1]).

The third patch works around crappy gzip implementations.

The forth patch fixes a hypothetical (as far as I know) bug in hackbench's
error handling.

A form of all of these patches has been carried out-of-tree in the OpenEmbedded
project for years now :(.  They are more widely useful; as such, it's time to
land them in rt-tests proper.

Thanks,
  Josh

1: http://permalink.gmane.org/gmane.linux.rt.user/8749

Cc: Darren Hart <dvhart@linux.intel.com>
Cc: Robert Yang <liezhi.yang@windriver.com>
Cc: Kai Kang <kai.kang@windriver.com>
Cc: Song.Li <Song.Li@windriver.com>
Cc: Jesse Zhang <sen.zhang@windriver.com>

Darren Hart (2):
  rt-tests: Allow for user-specified PYLIB
  rt-tests: Break out install_hwlatdetect

Josh Cartwright (2):
  rt-tests: workaround poor gzip implementations
  hackbench: cleanup error handling in create_worker

 Makefile                  | 32 ++++++++++++++++++--------------
 src/hackbench/hackbench.c | 36 +++++++++++++++---------------------
 2 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.5.0

