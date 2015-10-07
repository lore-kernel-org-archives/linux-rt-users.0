From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-v0.95
Date: Wed, 7 Oct 2015 15:53:19 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510071533540.14006@riemann>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1892712943-1444226000=:14006"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38875 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbJGNxX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2015 09:53:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1892712943-1444226000=:14006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Dear RT Folks
We're pleased to announce the latest version of rt-tests

The previous version included the first addition of the ability to build 
some of the tests for android which uses the bionic library. (Thank you to 
Henrik Austad for that) Henrik is continuing his development work on 
that.

This version includes a lot of changes to the build system that you will 
hopefully find makes working with rt-tests a lot easier and more pleasant. 
Chiefly the addition of a bld directory for the object files, plus some 
clarification in the comments for different ways to build rt-tests. A 
separate Makefile for bionic, and more.

To clear-up any previous confusion, we do support building without the 
numa libs.

And there are a few odds and ends, clean-ups and a new man page

You can fetch it via git by cloning one of the following repos

git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

tag: v0.95

You can also fetch the tarball here
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.95.tar.xz
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-0.95.tar.gz

older versions are in
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests/older

I've pushed a branch for new development, so you can start sending us your 
patches, and bug reports.

branch: devel/v0.96

Enjoy!

List of Changes

Henrik Austad (1):
  cyclictest: move redefine of CPUSET back to uclib

John Kacur (11):
  Explicitly separate VPATH paths with a colon
  build: Generate .o, .a, and .d files in bld dir
  signaltest: call process_options before calling check_privs
  signaltest: Check the status of pthread_create
  rt-utils: Add John Kacur to the copyright
  rt-utils: Fix some checkpatch errors in rt-utils.c
  signaltest: Add a man page to signaltest
  Makefile: Document certain compiling options
  Makefile: Only call cc -dumpmachine once in the makefile
  Bionic: Move android functionality into it's own arch Makefile
  maintainence: VERSION bump and Change-log update

Uwe Kleine-König (4):
  backfire: remove unused header file
  remove several unused Makefiles
  rt-migrate-test: remove space before \n
  drop compiling without NPTL support

---1463804494-1892712943-1444226000=:14006--
