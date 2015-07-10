From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/6] Various rt-test patches
Date: Fri, 10 Jul 2015 14:25:25 +0200
Message-ID: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35991 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbbGJMZh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:37 -0400
Received: by widjy10 with SMTP id jy10so14094182wid.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:36 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Various rt-patches

Some of these have to do with infrastructure.
Moving to git-archive so we get cleaner tarballs.
I'm planning on ripping out anything in the makefiles that have to do w=
ith
maintaining rt-tests though, and either removing it or putting it in th=
e
scripts dir.

Oh, and we have a new repo you should clone, one of the following

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

And a new location for our tarballs

https://www.kernel.org/pub/linux/utils/rt-tests/


Cheers!

John Kacur (6):
  Fix warning: unused variable =E2=80=98c=E2=80=99
  Fix possible exit on error without releasing mutex
  Create a .gitattribute file to specify what files git-archive should
    ignore
  Add .tar files to .gitignore
  Change VERSION_STRING to VERSION
  Create an rt-tests.tar file using git-archive

 .gitattributes                |  4 ++++
 .gitignore                    |  1 +
 Makefile                      | 25 +++++++++++++++----------
 src/backfire/sendme.c         |  2 +-
 src/cyclictest/cyclictest.c   |  2 +-
 src/pi_tests/pi_stress.c      | 17 ++++++++++++-----
 src/pi_tests/pip_stress.c     |  1 -
 src/pmqtest/pmqtest.c         |  2 +-
 src/ptsematest/ptsematest.c   |  2 +-
 src/signaltest/signaltest.c   |  2 +-
 src/sigwaittest/sigwaittest.c |  2 +-
 src/svsematest/svsematest.c   |  2 +-
 12 files changed, 39 insertions(+), 23 deletions(-)
 create mode 100644 .gitattributes

--=20
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
