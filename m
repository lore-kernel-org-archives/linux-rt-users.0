From: John Kacur <jkacur@redhat.com>
Subject: ANNOUNCE v0.85 rt-tests
Date: Tue, 13 Nov 2012 17:41:42 -0500 (EST)
Message-ID: <1136362490.243403.1352846502316.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:54167 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687Ab2KMWlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 17:41:42 -0500
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qADMfgrM013551
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2012 17:41:42 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm pleased to announce v0.85 of rt-tests

Most changes, where just clean-ups, but
the biggest change was to the histogram reporting from Bhavesh Davda
Please give it a good test, and let us know if this interferes with any
current automated testing.

Repo: git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.=
git
Branch: master
Tag: v0.85 - caution, the tag is one behind the actual patch that bumps=
 the version, sigh -
but this will probably get overwritten in the future.

I've pushed my own branch to collect future patches
Repo: git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git
Branch: rt-tests-0.86-devel

Thanks, enjoy!

Bhavesh Davda (2):
  cyclictest: whitespace cleanup
  cyclictest: histogram overflow instance tracking

Clark Williams (2):
  add setup and call of tracemark function for breaktrace
  version bump to 0.85

=46rank Rowand (2):
  V3: cyclictest: clean up getopt_long() parameters
  V3: cyclictest: report large measured clock latency

John Kacur (2):
  rt-tests / gitignore: Exclude patches and .a libs too.
  rt-tests Makefile: Add CPPFLAGS to the pattern rule to generate
    dependencies     Signed-off-by: John Kacur <jkacur@redhat.com>

Uwe Kleine-K=C3=B6nig (2):
  rt-tests: have printf use %s format for strings
  rt-tests Makefile: separate CFLAGS and CPPFLAGS
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
