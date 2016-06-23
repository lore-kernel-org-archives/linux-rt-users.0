From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] rt-tests: sched_deadline tests
Date: Thu, 23 Jun 2016 14:11:48 +0200
Message-ID: <1466683911-10994-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

First of all, I have renamed the unstable v2.0 branch to v1.1,
to make our numbering scheme more closely match other Linux projects.

Then I have added two programs written by Steven Rostedt for testing
SCHED_DEADLINE

This is our first change that is to the unstable branch only.

Thanks

John Kacur

John Kacur (3):
  rt-tests: Makefile, change version to 1.1
  rt-tests: Add cyclicdeadline and deadline_test
  rt-tests: Add cyclicdeadline and deadline_test to the Make system

 .gitignore                          |    2 +
 Makefile                            |   13 +-
 src/sched_deadline/cyclicdeadline.c | 1269 +++++++++++++++++++++
 src/sched_deadline/deadline_test.c  | 2099 +++++++++++++++++++++++++++++++++++
 4 files changed, 3381 insertions(+), 2 deletions(-)
 create mode 100644 src/sched_deadline/cyclicdeadline.c
 create mode 100644 src/sched_deadline/deadline_test.c

-- 
2.4.11
