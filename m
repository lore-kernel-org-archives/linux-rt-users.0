From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/3] rt-tests: Add cyclicdeadline and deadline_test to
 the Make system
Date: Fri, 24 Jun 2016 13:40:45 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1606241339510.6589@riemann>
References: <1466683911-10994-1-git-send-email-jkacur@redhat.com> <1466683911-10994-4-git-send-email-jkacur@redhat.com> <20160623174746.36d3657d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623174746.36d3657d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Thu, 23 Jun 2016, Steven Rostedt wrote:

> On Thu, 23 Jun 2016 14:11:51 +0200
> John Kacur <jkacur@redhat.com> wrote:
> 
> 
> > index 9c50456f7419..f530488545e0 100644
> > --- a/src/sched_deadline/cyclicdeadline.c
> > +++ b/src/sched_deadline/cyclicdeadline.c
> > @@ -1,4 +1,6 @@
> > +#ifndef _GNU_SOURCE
> >  #define _GNU_SOURCE
> > +#endif
> >  #include <pthread.h>
> >  #include <stdarg.h>
> >  #include <stdlib.h>
> > diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> > index 8a813c494520..2794730febc4 100644
> > --- a/src/sched_deadline/deadline_test.c
> > +++ b/src/sched_deadline/deadline_test.c
> > @@ -29,7 +29,9 @@
> >   *    Look for "simple_test"
> >   *
> >   */
> > +#ifndef _GNU_SOURCE
> >  #define _GNU_SOURCE
> > +#endif
> 
> I'd say nuke these if they are already defined via the Makefile or
> something. I can move the define to the Makefile in my github too.
> 
> -- Steve

Agreed.

>From 02b15d056e6127f773fb71f69c0c5fe393422a87 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Fri, 24 Jun 2016 13:34:54 +0200
Subject: [PATCH] rt-tests-1.1.1: Remove _GNU_SOURCE from source files

Remove _GNU_SOURCE from source files since it is defined in the Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 3 ---
 src/sched_deadline/cyclicdeadline.c   | 3 ---
 src/sched_deadline/deadline_test.c    | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index d7b68ddac3e5..0a0bb77ab661 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -20,9 +20,6 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
 #include <stdio.h>
 #ifndef __USE_XOPEN2K
 # define __USE_XOPEN2K
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index f530488545e0..fd78d315563e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1,6 +1,3 @@
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdlib.h>
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 2794730febc4..196dfecbbb78 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -29,9 +29,6 @@
  *    Look for "simple_test"
  *
  */
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
 #include <pthread.h>
 #include <stdarg.h>
 #include <stdlib.h>
-- 
2.4.11
