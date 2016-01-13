From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] hwlatdetect patches
Date: Wed, 13 Jan 2016 15:59:44 +0100
Message-ID: <1452697187-14894-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35998 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcAMO7w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 09:59:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so37311900wmf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jan 2016 06:59:51 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sending this on behalf of Clark to the list, the latest update to the devel/v0.97 branch

Clark Williams (3):
  hwlatdetect: handle hwlat_detector being builtin rather than module
  hwlatdetect: modify to handle python3 prints
  hwlatdetect: make reading sample date work with python2 and python3

 src/hwlatdetect/hwlatdetect.py | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.4.3

