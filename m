From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RT-TESTS 0/3] A few Makefile clean-ups
Date: Fri,  8 Feb 2013 15:47:32 +0100
Message-ID: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:53119 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758440Ab3BHOrm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 09:47:42 -0500
Received: by mail-bk0-f54.google.com with SMTP id w5so1716906bku.13
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Feb 2013 06:47:40 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: John Kacur <jkacur@redhat.com>

I have few simple build clean-ups, which should be uncontroversial
for the rt-tests suite

John Kacur (3):
  Makefile: Don't tag tmp files created when making a release
  Makefile: Add tmp dir to distclean and "make release" call distclean
  Makefile: Add BUILDROOT and SPECS to the dirs to remove for distclean

 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.11.7

