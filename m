From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE]rt-tests-1.3  New Devlopment version of rt-tests
Date: Mon, 30 Apr 2018 18:04:28 +0100 (IST)
Message-ID: <alpine.LFD.2.21.1804301747410.19103@planxty>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        Marcelo <mtosatti@redhat.com>
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


There is a new development version of rt-tests (cyclictest and friends)

As this is the unstable version, there might be some rough spots, but 
patches are welcome!

Recent development includes
- Clark Williams added python3 support for hwlatdetect
 Note: I will accept patches that make the code run correctly for 
both python3 and python2, but only if it doesn't break python3
- Marcelo Tosatti added a new test called queuelat
 Note: Please cc Marcelo on any questions / patches, etc to do with 
queuelat

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch
unstable/devel/latest

Tar ball
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/snapshot/rt-tests-1.3.tar.gz

Enjoy!

John Kacur
